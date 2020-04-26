%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                        check_collision.m                        %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   check_collision.m
% @brief  Returns TRUE if the robot goes off the line.
% @author Raúl Tapia

function r = check_collision(robot, maze)

if(robot.pos(1) <= robot.vol || robot.pos(2) <= robot.vol ||...
   robot.pos(1) > maze.size-robot.vol || robot.pos(2) > maze.size-robot.vol)
    %%% If it comes in here, you're off-limits
    r = true;
else
    neighbors = maze.image(robot.pos(1)-robot.vol:robot.pos(1)+robot.vol,...
                           robot.pos(2)-robot.vol:robot.pos(2)+robot.vol);
    %%% Check if I have a clear path in front of me
    r = any_zero(neighbors);
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
