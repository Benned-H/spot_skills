import yaml
from typing import Mapping, Union
from geometry_msgs.msg import Pose2D, Pose
from tf.transformations import quaternion_from_euler

class ObjectLocationDB:
    def __init__(
            self,
            save_loc="~/.ros/spot_skills_py/object_location_db.yaml",
        ):
        self.object_location_db: Mapping[str, Pose] = {}
        self.save_loc = save_loc
        try:
            self._load_object_location_db()
        except FileNotFoundError:
            pass
    
    def _load_object_location_db(self):
        with open(self.save_loc, 'r') as file:
            db = yaml.load(file, Loader=yaml.FullLoader)
            objs = db.get('static_locations', {})
            for key, value in objs.items():
                # parse pose into Pose message
                if len(value) == 3:
                    pose_arr = [value[0], value[1], 1, 0, 0, value[2]]
                else:
                    pose_arr = value
                pose = Pose()
                pose.position.x = pose_arr[0]
                pose.position.y = pose_arr[1]
                pose.position.z = pose_arr[2]
                q = quaternion_from_euler(*pose_arr[3:])
                pose.orientation.x = q[0]
                pose.orientation.y = q[1]
                pose.orientation.z = q[2]
                pose.orientation.w = q[3]
                self.object_location_db[key] = pose

    def _save_object_location_db(self):
        raise NotImplementedError()

    def add_object_location(self, object_name: object, location: Pose):
        self.object_location_db[object_name] = location

    def get_object_location(self, object_name):
        return self.object_location_db.get(object_name, None)

    def get_all_object_locations(self):
        return self.object_location_db

    def clear_object_locations(self):
        self.object_location_db.clear()

