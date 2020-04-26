%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                           use_sensor.m                          %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   use_sensor.m
% @brief  What happens when the robot escapes.
% @author Raúl Tapia

function r = use_sensor(robot, maze, direction)

%%% Rotations made here are not real
%%% They are only used to facilitate calculation
if strcmp(direction, 'front')
    fakeRobot = robot;
elseif strcmp(direction, 'right')
    fakeRobot = rotate(robot, 'clockwise');
elseif strcmp(direction, 'left')
    fakeRobot = rotate(robot, 'anticlockwise');
elseif strcmp(direction, 'back')
    fakeRobot = rotate(rotate(robot, 'clockwise'), 'clockwise');
else
    error('Upsss...');
end

switch fakeRobot.orient(1)
    case 'l'
        r = any_zero(maze.image(fakeRobot.pos(1)-fakeRobot.vol:fakeRobot.pos(1)+fakeRobot.vol, fakeRobot.pos(2)-fakeRobot.vol-1));
    case 'r'
        r = any_zero(maze.image(fakeRobot.pos(1)-fakeRobot.vol:fakeRobot.pos(1)+fakeRobot.vol, fakeRobot.pos(2)+fakeRobot.vol+1));
    case 'u'
        r = any_zero(maze.image(fakeRobot.pos(1)-fakeRobot.vol-1, fakeRobot.pos(2)-fakeRobot.vol:fakeRobot.pos(2)+fakeRobot.vol));
    case 'd'
        r = any_zero(maze.image(fakeRobot.pos(1)+fakeRobot.vol+1, fakeRobot.pos(2)-fakeRobot.vol:fakeRobot.pos(2)+fakeRobot.vol));
end

end

%%% Some imaging stuffs
function r = any_zero(mat)
if prod(prod(mat)) == 0
    r = true;
else
    r = false;
end
end
