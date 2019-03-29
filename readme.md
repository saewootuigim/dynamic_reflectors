## Dynamic Reflectors

There is an anechoic room and the ceiling is covered with recangular reflecting panels. A sound source is positioned in front of the room and emits some sound. The sound pressure level at a position inside the room will be different. Apparently, a position closer to the sound source will experience louder sound and farther position will hear less strong sound.

If we choose multiple arbitrary positions inside the room, can we balance the sound pressure level by optimally adjusting the reflecting panels installed on the ceiling?

### Overview
This program uses genetic algorithm to solve a optimization problem with integer constraint to achieve the goal.

The scripts are developed for my own research purpose so it is not neatly organized.

Running `lets_optimize_1.m` will do the work. It calls other scripts inside the script. Line 35 of `lets_optimize_1.m` selects the position configurations. currently, a pentagram is selected as default.

### What does each script do
`lets_optimize_1.m` does the optimization and draws convergence plot.
`lets_optimize_3.m` adjusts the reflectors according to the optimized solution.
`lets_optimize_4.m` calculates Kircchoff Integral equation to draw the sound pressure level of the room.

Figures are automatically generated. 
