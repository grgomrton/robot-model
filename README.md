# Robot model

This project is for designing the control of a differential drive robot.

## Plots

### Constant acceleration then move

Assuming that the robot was controlled to accelerate for 0.5 sec and then to constant move for 1 sec:

<img src="./plots/angular_velocity_const_acc_then_move.png" width="270" alt="Angular velocity over time" /> <img src="./plots/robotbase_velocity_const_acc_then_move.png" width="270" alt="Robot base frame velocity over time" /> <img src="./plots/robot_position_const_acc_then_move.png" width="270" alt="Robot position over time" />

#### Difference from ideal control

![Highlighted point at end of acceleration period](./plots/robot_position_const_acc_then_move_highlighted.png)

Assuming continuous control the highlighted value would have been `0.04125`.

## Dependencies

You will need _Plots_ and _PlotlyJS_ to execute everything. Type in the _Julia console (REPL)_:

```julia
Pkg.add("Plots")
Pkg.add("PlotlyJS")
```
