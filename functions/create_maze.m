%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                          create_maze.m                          %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   create_maze.m
% @brief  Load maze image.
% @author Raúl Tapia

function maze = create_maze(filename, numExits)

%%% Load maze
maze.image = imread(filename);
maze.image = rgb2gray(maze.image);
maze.image = imerode(maze.image,strel('rectangle',[4 4]));

%%% Size (supposed to be square)
if size(maze.image,1) ~= size(maze.image,2)
    error('There is a problem with maze dimesions, sorry');
end
maze.size = length(maze.image);

%%% Fill edge
maze.image(1:3,:) = zeros(size(maze.image(1:3,:)));
maze.image(end-3:end,:) = zeros(size(maze.image(end-3:end,:)));
maze.image(:,1:3) = zeros(size(maze.image(:,1:3)));
maze.image(:,end-3:end) = zeros(size(maze.image(:,end-3:end)));

%%% Calculate volume for exits
minCnt = 999;
for i = 5:maze.size-5
    cnt = 0;
    for j = 1:maze.size
        if maze.image(i,j) == 255
            cnt = cnt + 1;
        else
            if cnt > 0 && cnt < minCnt
                minCnt = cnt;
            end
            cnt = 0;
        end
    end
end
maze.vol = floor(minCnt/2);

%%% Set exits
fakeRobot.vol = maze.vol;
for i = 1:numExits
    fakeRobot.pos = randi(maze.size,1,2);
    while check_collision(fakeRobot, maze)
        fakeRobot.pos = randi(maze.size,1,2);
    end
    maze.exit(:,i) = fakeRobot.pos;
end

end
