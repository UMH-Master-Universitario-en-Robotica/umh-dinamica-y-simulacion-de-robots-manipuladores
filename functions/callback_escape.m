%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                        callback_escape.m                        %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   callback_escape.m
% @brief  Escape using the right hand rule.
% @author Raúl Tapia

function callback_escape()

global config
global maze
global robot

%%% Until the exit is reached ...
while ~check_victory(robot,maze)
    %%% Representation
    draw_maze(robot,maze);

    %%% Get next step
    robot = escape(robot, maze);

    %%% User has closed programme
    if config.abort
        return
    end
end

thats_all_folks(robot,maze);

end
