%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                             disp_t.m                            %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   disp_t.m
% @brief  Display in command window with timestamp.
% @author Raúl Tapia

function disp_t(string)
    %%% It might be cool...
    disp([datestr(datetime('now')), ' > ', string]);
end
