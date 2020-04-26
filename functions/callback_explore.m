%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                       callback_explore.m                        %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   callback_explore.m
% @brief  Explore the full maze using Dijkstra algorithm.
% @author Raúl Tapia

function callback_explore()

global config
global maze
global robot

robot.action = 'exploring';

%%% Initialization
if use_sensor(robot, maze, 'back')
    %%% Not open a node in my back
    openedNodes = robot.pos;
else
    %%% Open a node in my back (we have two "sub-mazes")
    openedNodes = [get_position(robot, 'back'), robot.pos];
end
closedNodes = [];

while ~isempty(openedNodes)
    %%% Current node is the current position
    currentNode = openedNodes(:,end);

    %%% Generate descentants and close current node
    openedNodes = [openedNodes, generate_descendants(robot, maze)];
    [openedNodes,closedNodes] = close_node(currentNode,openedNodes,closedNodes);

    %%% Go to an unexplored node
    if ~isempty(openedNodes)
        robot = go_to_node(robot, maze, openedNodes(:,end));
    end

    %%% User has closed the programme
    if config.abort
        return
    end

    %%% For visualization
    robot.exploration.opened = openedNodes;
    robot.exploration.closed = closedNodes;
    draw_maze(robot,maze);

    %%% Check user stop signal
    if config.stop_signal
        break;
    end
end

disp_t('Exploration finished');
draw_maze(robot,maze,'force');
robot.action = 'none';

end

%%% Generate descentants from the current position
function r = generate_descendants(robot, maze)
r = [];

%%% Check front position
if ~use_sensor(robot, maze, 'front')
    r = [r, get_position(robot,'front')];
end

%%% Check left position
if ~use_sensor(robot, maze, 'left')
    r = [r, get_position(robot,'left')];
end

%%% Check right position
if ~use_sensor(robot, maze, 'right')
    r = [r, get_position(robot,'right')];
end

%%% Tell the human some things
if size(r,2) > 1
    if size(r,2) == 2
        disp_t(['I have left ', num2str(size(r,2)) - 1, ' node unexplored. I will be back!']);
    else
        disp_t(['I have left ', num2str(size(r,2)) - 1, ' nodes unexplored. I will be back!']);
    end
end
end

%%% Close visited node
function [openedNodes,closedNodes] = close_node(currentNode, openedNodes, closedNodes)

%%% Remove from opened
for i = 1:size(openedNodes,2)
    if currentNode(1) == openedNodes(1,i) && currentNode(2) == openedNodes(2,i)
        break;
    end
end
openedNodes(:,i) = [];

%%% Add to closed
closedNodes = [closedNodes, currentNode];
end

%%% Move to an open node
function robot = go_to_node(robot, maze, node)
global config

%%% Go back to the closest point in the path
if norm(robot.pos - node) > 1
    k = 1;
    returnPath = reverse_path(optimize_path(robot.path));
end
while norm(robot.pos - node) > 1
    %%% Representation
    draw_maze(robot,maze);

    %%% User abort exploration
    if config.abort || config.stop_signal
        return
    end

    %%% Going back
    robot.pos = returnPath.pos(:,k);
    robot.orient = returnPath.orient(k);

    k = k+1;

    %%% Save movements
    robot.path.pos = [robot.path.pos, robot.pos];
    robot.path.orient = [robot.path.orient, robot.orient];
    robot.path.exit = [robot.path.exit, check_victory(robot,maze)];
end

%%% Look towards the node and go ahead
robot = look_towards(robot, node, check_victory(robot,maze));
robot.pos = get_position(robot,'front');

%%% Save movements
robot.path.pos = [robot.path.pos, robot.pos];
robot.path.orient = [robot.path.orient, robot.orient];
robot.path.exit = [robot.path.exit, check_victory(robot,maze)];

if robot.path.exit(end) && ~robot.path.exit(end-1)
    disp_t('I have found a new exits');
end

end
