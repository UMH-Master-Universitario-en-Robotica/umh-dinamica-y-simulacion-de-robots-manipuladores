%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                          reverse_path.m                         %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   path_tracking.m
% @brief  Return the reversed path.
% @author Raúl Tapia

function path = reverse_path(path)
%%% Flip order
path.pos = flip(path.pos,2);
path.orient = flip(path.orient);
path.exit = flip(path.exit);

%%% Change orientation
for i = 1:length(path.orient)
    path.orient(i) = inverse_orient(path.orient(i));
end

end

%%% Return the opposite orientation
function x = inverse_orient(x)
switch x
    case 'u'
        x = 'd';
    case 'd'
        x = 'u';
    case 'r'
        x = 'l';
    case 'l'
        x = 'r';
end
end
