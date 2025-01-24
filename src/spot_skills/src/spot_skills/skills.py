from abc import ABC, abstractmethod
import rospy
from SpotROS1Wrapper import handle_stand, handle_unlock_arm, handle_stow_arm



class SpotSkill(ABC):

    def __init__(self, **kwargs):
        '''When creating a SpotSkill class, pass in a set of service names that are relevant to the skill'''
        pass

    @property
    def skill_client(self):
        '''Create an instance of rospy ServiceProxy to serve as the ROS client that calls any ROS services i.e. client for a skill service'''
        return rospy.ServiceProxy


    @abstractmethod
    def localize_robot(self, **kwargs):
        '''Any skill needs the robot to be first localized before executing the skill'''
        return True, None

    @abstractmethod
    def localize_arguments(self, **kwargs):
        '''Any skill needs to localize the objects (in SLAM map and object pose) it is interacting provided as arguments to the skill'''
        return True, None
    
    @abstractmethod
    def detect_arguments(self, **kwargs):
        '''Any skill needs to detect the objects that it may be interacting with in the scene first'''
        return True, None
    
    @abstractmethod
    def generate_spline(self, **kwargs):
        '''Some skills might need to generate splines to move the SPOT arm to some specified/sampled 3D pose'''
        return True, None

    @abstractmethod
    def run_skill(self, **kwargs):
        '''Any skill can be run provided the right number and type of arguments'''
        pass

    


'''Example spot skills class for standing up'''

class StandUp(SpotSkill):

    def __init__(self, **kwargs):
        
        #NOTE: all skills need to start __init__ with a init_node() call
        rospy.init_node(kwargs['skill_name'])

        self.skill_client = rospy.ServiceProxy

        self.precond_functions = [self.localize_robot, self.localize_arguments, self.detect_arguments, self.generate_spline]

        self.timeout = kwargs['service_timeout'] #NOTE: after timeout throw error



    
    def run_skill(self, **kwargs):
        
        #first ensure required preconditions are all done + gather all data needed from precondition checks
        preconds_done = False
        preconds_data = []

        while not preconds_done:

            for precond in self.precond_functions:

                done, data = precond(kwargs)

                preconds_done &= done
                preconds_data.append(data)
        
        #once all precondition checks pass, wait for ros service to be runnable
        try:
            rospy.wait_for_service(kwargs['service'], timeout=self.timeout)
        except rospy.ROSException as e:
            print("Timeout when waiting for service call: %s"%e)
        
        #finally run the service using the client: skill might involve multiple service calls so sequence them
        try:
            
            for (service, skill_function) in zip(kwargs['services'], kwargs['skill_functions']):
                self.skill_client(service, skill_function)
                response = self.skill_client(kwargs)

            return response
        except rospy.ServiceException as e:
            print("Service call failed: %s"%e)


  




args = {'service': 'spot/stand', 'skill_function': handle_stand}