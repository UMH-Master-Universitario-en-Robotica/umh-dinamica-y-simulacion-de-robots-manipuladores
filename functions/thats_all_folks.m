%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                        thats_all_folks.m                        %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   thats_all_folks.m
% @brief  What happens when the robot escapes.
% @author Raúl Tapia

function thats_all_folks(robot, maze)

%%% Final representation
draw_maze(robot,maze,'force');

%%% Congratulate the robot
disp_t(['CONGRATS! Exit reached in ', num2str(size(robot.path.pos,2)), ' movements.']);

%%% Epic music
[y, Fs] = audioread('assets/game_win.wav');
sound(y, Fs, 24);
pause(0.1);

end
