
"use strict";

let Lease = require('./Lease.js');
let EStopState = require('./EStopState.js');
let DockState = require('./DockState.js');
let LeaseArray = require('./LeaseArray.js');
let ImageProperties = require('./ImageProperties.js');
let BehaviorFault = require('./BehaviorFault.js');
let SpotCheckDepth = require('./SpotCheckDepth.js');
let ObstacleParams = require('./ObstacleParams.js');
let Feedback = require('./Feedback.js');
let PowerState = require('./PowerState.js');
let FootStateArray = require('./FootStateArray.js');
let Metrics = require('./Metrics.js');
let EStopStateArray = require('./EStopStateArray.js');
let ImageSource = require('./ImageSource.js');
let MobilityParams = require('./MobilityParams.js');
let AprilTagProperties = require('./AprilTagProperties.js');
let FootState = require('./FootState.js');
let WorldObject = require('./WorldObject.js');
let BatteryStateArray = require('./BatteryStateArray.js');
let TerrainState = require('./TerrainState.js');
let BehaviorFaultState = require('./BehaviorFaultState.js');
let ParentEdge = require('./ParentEdge.js');
let LeaseOwner = require('./LeaseOwner.js');
let SpotCheckHipROM = require('./SpotCheckHipROM.js');
let WiFiState = require('./WiFiState.js');
let LeaseResource = require('./LeaseResource.js');
let SpotCheckKinematic = require('./SpotCheckKinematic.js');
let ImageCapture = require('./ImageCapture.js');
let SpotCheckPayload = require('./SpotCheckPayload.js');
let SpotCheckLoadCell = require('./SpotCheckLoadCell.js');
let FrameTreeSnapshot = require('./FrameTreeSnapshot.js');
let TerrainParams = require('./TerrainParams.js');
let BatteryState = require('./BatteryState.js');
let WorldObjectArray = require('./WorldObjectArray.js');
let SystemFault = require('./SystemFault.js');
let SystemFaultState = require('./SystemFaultState.js');
let NavigateRouteFeedback = require('./NavigateRouteFeedback.js');
let NavigateToGoal = require('./NavigateToGoal.js');
let NavigateToActionGoal = require('./NavigateToActionGoal.js');
let PoseBodyResult = require('./PoseBodyResult.js');
let DockActionFeedback = require('./DockActionFeedback.js');
let PoseBodyActionGoal = require('./PoseBodyActionGoal.js');
let TrajectoryFeedback = require('./TrajectoryFeedback.js');
let NavigateToActionFeedback = require('./NavigateToActionFeedback.js');
let TrajectoryResult = require('./TrajectoryResult.js');
let PoseBodyAction = require('./PoseBodyAction.js');
let NavigateRouteActionGoal = require('./NavigateRouteActionGoal.js');
let NavigateToResult = require('./NavigateToResult.js');
let DockActionResult = require('./DockActionResult.js');
let DockResult = require('./DockResult.js');
let PoseBodyActionResult = require('./PoseBodyActionResult.js');
let NavigateToFeedback = require('./NavigateToFeedback.js');
let NavigateToAction = require('./NavigateToAction.js');
let TrajectoryActionFeedback = require('./TrajectoryActionFeedback.js');
let DockActionGoal = require('./DockActionGoal.js');
let NavigateRouteActionResult = require('./NavigateRouteActionResult.js');
let PoseBodyGoal = require('./PoseBodyGoal.js');
let NavigateRouteActionFeedback = require('./NavigateRouteActionFeedback.js');
let TrajectoryAction = require('./TrajectoryAction.js');
let PoseBodyActionFeedback = require('./PoseBodyActionFeedback.js');
let NavigateRouteResult = require('./NavigateRouteResult.js');
let TrajectoryGoal = require('./TrajectoryGoal.js');
let DockGoal = require('./DockGoal.js');
let TrajectoryActionResult = require('./TrajectoryActionResult.js');
let NavigateRouteAction = require('./NavigateRouteAction.js');
let DockAction = require('./DockAction.js');
let NavigateRouteGoal = require('./NavigateRouteGoal.js');
let PoseBodyFeedback = require('./PoseBodyFeedback.js');
let TrajectoryActionGoal = require('./TrajectoryActionGoal.js');
let NavigateToActionResult = require('./NavigateToActionResult.js');
let DockFeedback = require('./DockFeedback.js');

module.exports = {
  Lease: Lease,
  EStopState: EStopState,
  DockState: DockState,
  LeaseArray: LeaseArray,
  ImageProperties: ImageProperties,
  BehaviorFault: BehaviorFault,
  SpotCheckDepth: SpotCheckDepth,
  ObstacleParams: ObstacleParams,
  Feedback: Feedback,
  PowerState: PowerState,
  FootStateArray: FootStateArray,
  Metrics: Metrics,
  EStopStateArray: EStopStateArray,
  ImageSource: ImageSource,
  MobilityParams: MobilityParams,
  AprilTagProperties: AprilTagProperties,
  FootState: FootState,
  WorldObject: WorldObject,
  BatteryStateArray: BatteryStateArray,
  TerrainState: TerrainState,
  BehaviorFaultState: BehaviorFaultState,
  ParentEdge: ParentEdge,
  LeaseOwner: LeaseOwner,
  SpotCheckHipROM: SpotCheckHipROM,
  WiFiState: WiFiState,
  LeaseResource: LeaseResource,
  SpotCheckKinematic: SpotCheckKinematic,
  ImageCapture: ImageCapture,
  SpotCheckPayload: SpotCheckPayload,
  SpotCheckLoadCell: SpotCheckLoadCell,
  FrameTreeSnapshot: FrameTreeSnapshot,
  TerrainParams: TerrainParams,
  BatteryState: BatteryState,
  WorldObjectArray: WorldObjectArray,
  SystemFault: SystemFault,
  SystemFaultState: SystemFaultState,
  NavigateRouteFeedback: NavigateRouteFeedback,
  NavigateToGoal: NavigateToGoal,
  NavigateToActionGoal: NavigateToActionGoal,
  PoseBodyResult: PoseBodyResult,
  DockActionFeedback: DockActionFeedback,
  PoseBodyActionGoal: PoseBodyActionGoal,
  TrajectoryFeedback: TrajectoryFeedback,
  NavigateToActionFeedback: NavigateToActionFeedback,
  TrajectoryResult: TrajectoryResult,
  PoseBodyAction: PoseBodyAction,
  NavigateRouteActionGoal: NavigateRouteActionGoal,
  NavigateToResult: NavigateToResult,
  DockActionResult: DockActionResult,
  DockResult: DockResult,
  PoseBodyActionResult: PoseBodyActionResult,
  NavigateToFeedback: NavigateToFeedback,
  NavigateToAction: NavigateToAction,
  TrajectoryActionFeedback: TrajectoryActionFeedback,
  DockActionGoal: DockActionGoal,
  NavigateRouteActionResult: NavigateRouteActionResult,
  PoseBodyGoal: PoseBodyGoal,
  NavigateRouteActionFeedback: NavigateRouteActionFeedback,
  TrajectoryAction: TrajectoryAction,
  PoseBodyActionFeedback: PoseBodyActionFeedback,
  NavigateRouteResult: NavigateRouteResult,
  TrajectoryGoal: TrajectoryGoal,
  DockGoal: DockGoal,
  TrajectoryActionResult: TrajectoryActionResult,
  NavigateRouteAction: NavigateRouteAction,
  DockAction: DockAction,
  NavigateRouteGoal: NavigateRouteGoal,
  PoseBodyFeedback: PoseBodyFeedback,
  TrajectoryActionGoal: TrajectoryActionGoal,
  NavigateToActionResult: NavigateToActionResult,
  DockFeedback: DockFeedback,
};
