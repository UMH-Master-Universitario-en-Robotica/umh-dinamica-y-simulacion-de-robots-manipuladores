%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                          insert_robot.m                         %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   insert_robot.m
% @brief  Insert robot into the maze.
% @author Raúl Tapia

function robot = insert_robot(maze)

%%% Set volumen for collisions
robot.vol = maze.vol;

%%% Position
robot.pos = randi(maze.size,2,1);
while check_collision(robot, maze) || check_victory(robot, maze)
    robot.pos = randi(maze.size,2,1);
end

%%% Orientation
options = ['u', 'd', 'r', 'l'];
robot.orient = options(randi(4));

%%% Initialization
robot.path.pos = robot.pos;
robot.path.orient = robot.orient;
robot.path.exit = false;
robot.action = 'none';

%%% Not necessary, but for convenience
robot.start = robot.pos; % Equals robot.path.pos(:,1)

end
