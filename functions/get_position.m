%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                          get_position.m                         %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   get_position.m
% @brief  Return position coordinates.
% @author Raúl Tapia

function pos = get_position(robot, dir)

%%% Rotations made here are not real
%%% They are only used to facilitate calculation
if strcmp(dir, 'front')
    pos = get_front_position(robot);
elseif strcmp(dir, 'right')
    fakeRobot = rotate(robot, 'clockwise');
    pos = get_front_position(fakeRobot);
elseif strcmp(dir, 'left')
    fakeRobot = rotate(robot, 'anticlockwise');
    pos = get_front_position(fakeRobot);
elseif strcmp(dir, 'back')
    fakeRobot = rotate(rotate(robot, 'clockwise'), 'clockwise');
    pos = get_front_position(fakeRobot);
else
    error('Upsss...');
end

end

%%% Return coordinates of the position in front of me.
function pos = get_front_position(robot)

pos = robot.pos;

switch robot.orient(1)
    case 'l'
        pos(2) = pos(2)-1;
    case 'r'
        pos(2) = pos(2)+1;
    case 'u'
        pos(1) = pos(1)-1;
    case 'd'
        pos(1) = pos(1)+1;
end

end
