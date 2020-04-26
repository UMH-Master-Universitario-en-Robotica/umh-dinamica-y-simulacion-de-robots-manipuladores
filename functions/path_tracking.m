%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                          path_tracking.m                        %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   path_tracking.m
% @brief  Follow the specified path.
% @author Raúl Tapia

function path_tracking(robot, maze)

global config

for k = 1:size(robot.path.pos,2)
    %%% Update position and orientation
    robot.pos = robot.path.pos(:,k);
    robot.orient = robot.path.orient(k);

    %%% Representation
    draw_maze(robot,maze);

    %%% User has closed the programme
    if config.abort
        return
    end
end

thats_all_folks(robot, maze);

end
