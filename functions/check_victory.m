%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                         check_victory.m                         %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   check_victory.m
% @brief  Returns TRUE if the robot is over an exit.
% @author Raúl Tapia

function r = check_victory(robot, maze)

r = false;

for i = 1:size(maze.exit,2)
    %%% Allow a tolerance equal to the robot volume
    if abs(robot.pos(1) - maze.exit(1,i)) < maze.vol && abs(robot.pos(2) - maze.exit(2,i)) < maze.vol
        %%% Congrats!
        r = true;
    end
end

end
