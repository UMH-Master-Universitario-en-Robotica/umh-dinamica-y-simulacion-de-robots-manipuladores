%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                         optimize_path.m                         %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   optimize_path.m
% @brief  Optimize path using a "pruning" algorithm.
% @author Raúl Tapia

function path = optimize_path(path)

x = path.pos(1,:);
y = path.pos(2,:);
o = path.orient;
e = path.exit;

i = 1;
while i < length(x)
    %%% If you go through the same point more than once...
    j = find(x == x(i) & y == y(i), 1, 'last');
    
    while i < j
        %%% ...forget about the intermediate points
        i = i+1;
        x(i) = -1;
    end
    
    i = i+1;
    
%     %%% --- ALTENATIVE ALGORITHM WITHOUT USING FIND --- %%%
%     %%% If you go through the same point more than once...
%     cnt = in([x(i);y(i)], [x(i+1:end);y(i+1:end)]);
%     j = i+1;
%     while cnt > 0
%         %%% ...forget about the intermediate points
%         while x(j) ~= x(i) || y(j) ~= y(i)
%             x(j) = -1;
%             j = j+1;
%         end
%         x(j) = -1;
%         cnt = cnt - 1;
%     end
%     i = i+1;
end

%%% Refine orientation after exploration
for i = 2:length(o)-1
    if o(i-1) == o(i+1) && o(i) ~= o(i+1)
        x(i) = -1;
    end
end

%%% Save optimal path
e = e(x>0);
o = o(x>0);
y = y(x>0);
x = x(x>0);
path.pos = [x;y];
path.orient = o;
path.exit = e;
end

% %%% Check how many times is "a" in "A"
% function cnt = in(a, A)
% cnt = 0;
% for i=1:size(A,2)
%     if a(1) == A(1,i) && a(2) == A(2,i)
%         cnt = cnt + 1;
%     end
% end
% end
