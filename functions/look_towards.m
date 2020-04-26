%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                          look_towards.m                         %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   look_towards.m
% @brief  Reorientate robot to a specified position.
% @author Raúl Tapia

function robot = look_towards(robot, pos, v)

%%% Get orientation in order to "look towards" the point
if robot.pos(2) == pos(2)
    if robot.pos(1) > pos(1)
        newOrientation = 'u';
    elseif robot.pos(1) < pos(1)
        newOrientation = 'd';
    else
        %%% Point has to be near the robot
        error('I am not reay for this');
    end
elseif robot.pos(1) == pos(1)
    if robot.pos(2) > pos(2)
        newOrientation = 'l';
    elseif robot.pos(2) < pos(2)
        newOrientation = 'r';
    else
        %%% Point has to be near the robot
        error('I am not reay for this');
    end
else
    %%% Point has to be near the robot
    error('I am not reay for this');
end

%%% Rotate to get the new orientation
while ~strcmp(robot.orient, newOrientation)
    robot = rotate(robot, 'clockwise');

    %%% Save movements
    robot.path.pos = [robot.path.pos, robot.pos];
    robot.path.orient = [robot.path.orient, robot.orient];
    robot.path.exit = [robot.path.exit, v];
end

end
