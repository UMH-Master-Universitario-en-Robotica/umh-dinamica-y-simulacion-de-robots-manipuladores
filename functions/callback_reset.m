%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                         callback_reset.m                        %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   callback_reset.m
% @brief  Load a new maze.
% @author Raúl Tapia

function callback_reset(type)

global config
global maze
global robot

%%% Create maze
filename = ['assets/mazes/', type, '_maze', num2str(randi(5)), '.png'];
maze = create_maze(filename, config.numExits);

%%% Insert robot in maze
robot = insert_robot(maze);

%%% Representation
draw_maze(robot, maze, 'force');

clc;

end
