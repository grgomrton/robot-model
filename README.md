# Robot model

This project is for designing the control of a differential drive robot.

### Update strategies

The kinematic model alternates between updating the orientation and the position. In the `VelocityControlledDifferentialDrive` the position is updated by the halfway orientation, which reduces error significantly.

Comparison of different update strategies while having a `0.1 sec` update cycle with `1 rad/sec` difference between the left angular velocity and the right angular velocity and `6.5 rad/sec` angular velocity of the right wheel:

```
Results: midway angle
Expected: [0.999749 0.0197979 1.59618]
Calculated: [0.999749 0.0197984 1.59618]
Error[mm]: 0.0005053026810065165

Results: previous theta
Expected: [0.999749 0.0197979 1.59618]
Calculated: [1.0 0.0198 1.59618]
Error[mm]: 0.25129877456925176

Results: new theta
Expected: [0.999749 0.0197979 1.59618]
Calculated: [0.999497 0.0197936 1.59618]
Error[mm]: 0.251307839107361
```

The error still accumulates over time only at a slower pace. See `VelocityControlledDifferentialDrive` tests for details.
