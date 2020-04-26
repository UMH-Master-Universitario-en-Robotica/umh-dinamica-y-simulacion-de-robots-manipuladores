%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                           draw_maze.m                           %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   draw_maze.m
% @brief  Draw problem status for simulation.
% @author Raúl Tapia

function draw_maze(robot,maze,varargin)
%%% 'cnt' is user-controlled (default is 1)
global config
persistent cnt
if isempty(cnt)
    cnt = 0;
end

%%% Sometimes draw in any case
if nargin > 2 && strcmp(varargin{1}, 'force')
    cnt = 0;
end

%%% Draw every 'cnt' interactions so you don't get bored
if ~cnt
    draw_maze_wrappered(robot,maze);
    pause(0.01);
    cnt = config.representationSpeed;
end

cnt = cnt - 1;
end

%%% The real draw_maze function
function draw_maze_wrappered(robot,maze)

%%% Maze
imgAux = imerode(maze.image,strel('rectangle',[8 8]));
image(:,:,1) = (imgAux~=255)*255;
image(:,:,2) = (imgAux~=255)*255;
image(:,:,3) = (imgAux~=255)*255;

%%% Nodes for exploration mode
if strcmp(robot.action, 'exploring')
    for i = 1:size(robot.exploration.closed,2)
        x = robot.exploration.closed(1,i);
        y = robot.exploration.closed(2,i);
        inc = floor(robot.vol/2);
        image(x-inc:x+inc,y-inc:y+inc,1) = 0;
        image(x-inc:x+inc,y-inc:y+inc,2) = 255;
        image(x-inc:x+inc,y-inc:y+inc,3) = 0;
    end
    
    for i = 1:size(robot.exploration.opened,2)
        x = robot.exploration.opened(1,i);
        y = robot.exploration.opened(2,i);
        inc = floor(robot.vol/2);
        image(x-inc:x+inc,y-inc:y+inc,1) = 255;
        image(x-inc:x+inc,y-inc:y+inc,2) = 0;
        image(x-inc:x+inc,y-inc:y+inc,3) = 0;
    end
end

%%% Exits
for i = 1:size(maze.exit,2)
    image(maze.exit(1,i)-maze.vol:maze.exit(1,i)+maze.vol,maze.exit(2,i)-maze.vol:maze.exit(2,i)+maze.vol,1) = 0;
    image(maze.exit(1,i)-maze.vol:maze.exit(1,i)+maze.vol,maze.exit(2,i)-maze.vol:maze.exit(2,i)+maze.vol,2) = 255;
    image(maze.exit(1,i)-maze.vol:maze.exit(1,i)+maze.vol,maze.exit(2,i)-maze.vol:maze.exit(2,i)+maze.vol,3) = 255;
end

%%% Init position
image(robot.start(1)-robot.vol:robot.start(1)+robot.vol,robot.start(2)-robot.vol,1) = 255;
image(robot.start(1)-robot.vol:robot.start(1)+robot.vol,robot.start(2)+robot.vol,1) = 255;
image(robot.start(1)-robot.vol,robot.start(2)-robot.vol:robot.start(2)+robot.vol,1) = 255;
image(robot.start(1)+robot.vol,robot.start(2)-robot.vol:robot.start(2)+robot.vol,1) = 255;
image(robot.start(1)-robot.vol:robot.start(1)+robot.vol,robot.start(2)-robot.vol,2) = 0;
image(robot.start(1)-robot.vol:robot.start(1)+robot.vol,robot.start(2)+robot.vol,2) = 0;
image(robot.start(1)-robot.vol,robot.start(2)-robot.vol:robot.start(2)+robot.vol,2) = 0;
image(robot.start(1)+robot.vol,robot.start(2)-robot.vol:robot.start(2)+robot.vol,2) = 0;
image(robot.start(1)-robot.vol:robot.start(1)+robot.vol,robot.start(2)-robot.vol,3) = 0;
image(robot.start(1)-robot.vol:robot.start(1)+robot.vol,robot.start(2)+robot.vol,3) = 0;
image(robot.start(1)-robot.vol,robot.start(2)-robot.vol:robot.start(2)+robot.vol,3) = 0;
image(robot.start(1)+robot.vol,robot.start(2)-robot.vol:robot.start(2)+robot.vol,3) = 0;

%%% Robot
if (strcmp(robot.action, 'escaping') || strcmp(robot.action, 'path tracking')) && check_victory(robot, maze)
    for i = 1:size(robot.path.pos,2)
        x = robot.path.pos(1,i);
        y = robot.path.pos(2,i);
        inc = floor(robot.vol/2);
        image(x-inc:x+inc,y-inc:y+inc,1) = 255;
        image(x-inc:x+inc,y-inc:y+inc,2) = 165;
        image(x-inc:x+inc,y-inc:y+inc,3) = 0;
    end
    
    image = draw_robot(image, robot, [0 255 0]);
else
    image = draw_robot(image, robot, [255 0 0]);
end

%%% Let's draw!
imshow(uint8(image));

end

%%% Draw robot depending on orientation
function img = draw_robot(img, robot, color)
if robot.orient == 'u'
    img = draw_robot_up(img, robot, color);
elseif robot.orient == 'd'
    img = draw_robot_down(img, robot, color);
elseif robot.orient == 'l'
    img = draw_robot_left(img, robot, color);
elseif robot.orient == 'r'
    img = draw_robot_right(img, robot, color);
else
    error('Houston, we have a problem');
end
end

%%% Orientation is 'up'
function img = draw_robot_up(img, robot, color)
k = robot.vol;
for i = robot.pos(1)-robot.vol:robot.pos(1)+robot.vol
    for j = robot.pos(2)-robot.vol+k:robot.pos(2)+robot.vol-k
        img(i,j,1) = color(1);
        img(i,j,2) = color(2);
        img(i,j,3) = color(3);
    end
    if rem(i,2)
        k = k-1;
    end
end
end

%%% Orientation is 'down'
function img = draw_robot_down(img, robot, color)
k = 0;
for i = robot.pos(1)-robot.vol:robot.pos(1)+robot.vol
    for j = robot.pos(2)-robot.vol+k:robot.pos(2)+robot.vol-k
        img(i,j,1) = color(1);
        img(i,j,2) = color(2);
        img(i,j,3) = color(3);
    end
    if rem(i,2)
        k = k+1;
    end
end
end

%%% Orientation is 'left'
function img = draw_robot_left(img, robot, color)
k = robot.vol;
for j = robot.pos(2)-robot.vol:robot.pos(2)+robot.vol
    for i = robot.pos(1)-robot.vol+k:robot.pos(1)+robot.vol-k
        img(i,j,1) = color(1);
        img(i,j,2) = color(2);
        img(i,j,3) = color(3);
    end
    if rem(j,2)
        k = k-1;
    end
end
end

%%% Orientation is 'right'
function img = draw_robot_right(img, robot, color)
k = 0;
for j = robot.pos(2)-robot.vol:robot.pos(2)+robot.vol
    for i = robot.pos(1)-robot.vol+k:robot.pos(1)+robot.vol-k
        img(i,j,1) = color(1);
        img(i,j,2) = color(2);
        img(i,j,3) = color(3);
    end
    if rem(j,2)
        k = k+1;
    end
end
end
