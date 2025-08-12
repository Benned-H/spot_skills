VENV_NAME ?= venv-spot
VENV_DIR ?= ./$(VENV_NAME)

RESOURCES_BASE_DIR = $(PWD)/resources
DATA_BASE_DIR = $(PWD)/data
SBERT_MODEL_DIR = sentence_transformers

clean:
	@echo "Cleaning the '$(VENV_NAME)' python environment."
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
	@sudo rm -rf $(VENV_NAME)
	@sudo rm /data /resources
	@echo "...done cleaning."

build-prereqs:
	@echo "Installing build prerequisites."
	sudo apt update && DEBIAN_FRONTEND=noninteractive sudo apt install -y --no-install-recommends \
		curl ca-certificates cmake git python3 python3-dev python3-venv \
		g++ libgeos-dev \
		libboost-all-dev libcgal-dev ffmpeg python3-tk \
		libeigen3-dev

$(VENV_NAME)/bin/activate:
	python3 -m venv $(VENV_DIR)

rail-repo-setup = ./RAIL-lsp-dev/Makefile
$(rail-repo-setup):
	git clone -b abpaudel/spot-brown https://github.com/rail-group/RAIL-lsp-dev.git

.PHONY: rail-repo
rail-repo: $(rail-repo-setup)

pddlstream-setup = ./pddlstream/README.md
$(pddlstream-setup):
	git clone https://github.com/caelan/pddlstream.git \
		&& cd pddlstream && ls -a && cat .gitmodules \
		&& sed -i 's/ss-pybullet/pybullet-planning/' .gitmodules \
		&& sed -i 's/git@github.com:caelan\/downward.git/https:\/\/github.com\/caelan\/downward/' .gitmodules \
		&& git submodule update --init --recursive
	cd pddlstream \
		&& ./downward/build.py

.PHONY: pddlstream
pddlstream: $(pddlstream-setup)
pddlstream:
	@if ! grep -q 'export PYTHONPATH="$(PWD)/pddlstream:$${PYTHONPATH}"' ~/.bashrc; then \
		echo 'export PYTHONPATH="'$(PWD)'/pddlstream:$${PYTHONPATH}"' >> ~/.bashrc; \
	fi

.PHONY: build
build: $(VENV_DIR)/bin/activate
build: pddlstream
build: rail-repo
build: symlinks
build:
	. $(VENV_DIR)/bin/activate && pip3 install uv
	. $(VENV_DIR)/bin/activate && uv pip install pybind11 wheel setuptools
	. $(VENV_DIR)/bin/activate && uv pip install torch torch_geometric
	. $(VENV_DIR)/bin/activate && uv pip install -r RAIL-lsp-dev/modules/requirements.txt
	. $(VENV_DIR)/bin/activate && uv pip install sknw
	. $(VENV_DIR)/bin/activate && \
		pip3 install RAIL-lsp-dev/modules/common && \
		pip3 install RAIL-lsp-dev/modules/unitybridge && \
		pip3 install RAIL-lsp-dev/modules/environments && \
		pip3 install RAIL-lsp-dev/modules/learning && \
		pip3 install RAIL-lsp-dev/modules/lsp && \
		pip3 install RAIL-lsp-dev/modules/lsp_accel && \
		pip3 install RAIL-lsp-dev/modules/gridmap && \
		pip3 install RAIL-lsp-dev/modules/procthor && \
		pip3 install RAIL-lsp-dev/modules/taskplan

.PHONY: download-sbert-model
download-sbert-model: $(RESOURCES_BASE_DIR)/$(SBERT_MODEL_DIR)/model.safetensors
$(RESOURCES_BASE_DIR)/$(SBERT_MODEL_DIR)/model.safetensors:
	@mkdir -p $(RESOURCES_BASE_DIR)/$(SBERT_MODEL_DIR)
	. $(VENV_DIR)/bin/activate && python -m procthor.scripts.download_sbert \
		--save_dir /resources/$(SBERT_MODEL_DIR)

symlinks:
	@echo "Creating symlinks."
	mkdir -p $(RESOURCES_BASE_DIR) $(DATA_BASE_DIR)
	sudo ln -sf $(RESOURCES_BASE_DIR) /resources
	sudo ln -sf $(DATA_BASE_DIR) /data
	sudo chown -R $(USER):$(USER) /resources /data

.PHONY: test-demo
test-demo: download-sbert-model
test-demo:
	@mkdir -p $(DATA_BASE_DIR)/test_logs
	PYTHONPATH="$(PWD)/pddlstream:$(PWD)/$(VENV_NAME)/lib/python3.8/site-packages:$${PYTHONPATH}" \
		python3 RAIL-lsp-dev/modules/taskplan/tests/test_demo.py
