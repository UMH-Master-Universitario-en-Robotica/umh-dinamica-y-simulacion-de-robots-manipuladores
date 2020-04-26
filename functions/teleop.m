%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                             teleop.m                            %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   teleop.m
% @brief  NOT USED!!! JUST FOR DEBUGGING.
% @author Raúl Tapia

function robot = teleop(robot, maze)

waitforbuttonpress();
key = double(get(gcf,'CurrentCharacter'));
switch key
    case 28
        robot.pos(2) = robot.pos(2) - 1;
        if check_collision(robot, maze)
            robot.pos(2) = robot.pos(2) + 1;
        end
    case 29
        robot.pos(2) = robot.pos(2) + 1;
        if check_collision(robot, maze)
            robot.pos(2) = robot.pos(2) - 1;
        end
    case 30
        robot.pos(1) = robot.pos(1) - 1;
        if check_collision(robot, maze)
            robot.pos(1) = robot.pos(1) + 1;
        end
    case 31
        robot.pos(1) = robot.pos(1) + 1;
        if check_collision(robot, maze)
            robot.pos(1) = robot.pos(1) - 1;
        end
end

draw_maze(robot,maze,'force');

end
