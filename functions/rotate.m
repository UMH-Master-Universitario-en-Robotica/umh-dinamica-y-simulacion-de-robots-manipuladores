%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                             rotate.m                            %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   rotate.m
% @brief  Rotate robot, changing its orientation.
% @author Raúl Tapia

function robot = rotate(robot, direction)
    if strcmp(direction, 'clockwise')
        robot = rotate_clockwise(robot);
    elseif strcmp(direction, 'anticlockwise')
        robot = rotate_anticlockwise(robot);
    else
        error('Upsss...');
    end
end

%%% Clockwise
function robot = rotate_clockwise(robot)
switch robot.orient(1)
    case 'l'
        robot.orient = 'u';
    case 'r'
        robot.orient = 'd';
    case 'u'
        robot.orient = 'r';
    case 'd'
        robot.orient = 'l';
end
end

%%% Anticlockwise
function robot = rotate_anticlockwise(robot)
switch robot.orient(1)
    case 'l'
        robot.orient = 'd';
    case 'r'
        robot.orient = 'u';
    case 'u'
        robot.orient = 'l';
    case 'd'
        robot.orient = 'r';
end
end
