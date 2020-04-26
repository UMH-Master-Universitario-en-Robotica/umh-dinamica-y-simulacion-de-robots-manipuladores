%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                       callback_optimize.m                       %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   callback_optimize.m
% @brief  Optimize path after escape and execute it.
% @author Raúl Tapia

function callback_optimize()

global maze;
global robot;

%%% Optimiza path
robot.path = optimize_path(robot.path);

%%% Track the path
robot.action = 'path tracking';
path_tracking(robot, maze);

end
