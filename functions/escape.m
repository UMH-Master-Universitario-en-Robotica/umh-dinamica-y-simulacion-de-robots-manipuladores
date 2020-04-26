%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                             escape.m                            %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   escape.m
% @brief  Escape using the right hand rule. Update robot state.
% @author Raúl Tapia

function robot = escape(robot, maze)

if use_sensor(robot, maze, 'right') || ~strcmp(robot.action,'escaping')
    if use_sensor(robot, maze, 'front')
        %%% Dead end
        disp_t(['Avoiding collision! New robot orientation: ', robot.orient]);
        robot = rotate(robot, 'anticlockwise');
    else
        %%% Can go forward
        robot.pos = get_position(robot,'front');
    end

    %%% For initialization
    if use_sensor(robot, maze, 'right')
        robot.action = 'escaping';
    end
else
    %%% Turn using the right hand rule
    disp_t(['Line lost! New robot orientation: ', robot.orient]);

    robot = rotate(robot, 'clockwise');
    robot.path.pos = [robot.path.pos, robot.pos];
    robot.path.orient = [robot.path.orient, robot.orient(1)];
    robot.path.exit = [robot.path.exit, false];

    robot.pos = get_position(robot,'front');
end

%%% Save movement
robot.path.pos = [robot.path.pos, robot.pos];
robot.path.orient = [robot.path.orient, robot.orient(1)];
robot.path.exit = [robot.path.exit, false];

end
