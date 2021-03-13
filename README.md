# RRT-Path-Planner
This work was developed as part of the requirements to complete "Modern Robotics: Mechanics, Planning, and Control Specialization" offered on Coursera by Kevin Lynch.

An RRT path planner aglorithm was used to traverse a robot through a work space including obstacles. The position, number, and size of obstacles are taken as an input through the "obstacles.csv" file.

Link to the final simulation output on youtube https://youtu.be/pn88wIgNkhQ

• The code runs on two matlab files, one containing the major code called "RRT_Path_planner" and the supplementary code used for obstacle detection called "collision_check". Both files should be in the same directory in order to run the code. Furthermore, "Obstacles.csv" is used to add obstacles' coordinates and dimensions.

• The obstacle avoidance algorithm depended on the idea of transforming the circular objects into a rectangular ones, and checking whether the straight line connecting a new sample point with a current node in the tree passes through any of the rectangles or not.

• The algorithm is not complete or failure proof; the code could run infinetly if the random sampling of nodes was scattered in a away that is not possible to find a collision-free path. A proposed solution to this problem is to increase the number of samples "n".

• V-rep simulation environment is not added to the repository for copyright reasons.


