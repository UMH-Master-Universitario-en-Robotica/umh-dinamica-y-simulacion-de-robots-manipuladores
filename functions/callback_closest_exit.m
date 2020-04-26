%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                     callback_closest_exit.m                     %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   callback_closest_exit.m
% @brief  Go to the closest exit after exploration.
% @author Raúl Tapia

function callback_closest_exit()

global robot
global maze

%%% Check if user stopped exploration before found an exit
if sum(robot.path.exit) == 0
    disp_t('I have not found an exit yet!');
    return;
end

%%% Get closest exit
robot.path = reverse_path(robot.path); %Important: Reverse path
robot.path.exit = double(robot.path.exit);
minPathLength = Inf;
bestPath = 0;

for k = 2:length(robot.path.exit)
    %%% For each exit...
    if robot.path.exit(k) && ~robot.path.exit(k-1)
        auxPath.pos = robot.path.pos(:,1:k);
        auxPath.orient = robot.path.orient(:,1:k);
        auxPath.exit = robot.path.exit(:,1:k);

        %%% We look for the shortest path
        p = optimize_path(auxPath);
        if size(p.pos,2) < minPathLength
            minPathLength = size(p.pos,2);
            bestPath = p;
        end
    end
end

robot.path = bestPath;

% Go there
robot.action = 'path tracking';
path_tracking(robot, maze);

end
