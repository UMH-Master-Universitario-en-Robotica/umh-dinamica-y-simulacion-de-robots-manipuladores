%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                              gui.m                              %%%%%
%%%%%                            Raúl Tapia                           %%%%%
%%%%%          Dinámica y Simulación de Robots Manipuladores          %%%%%
%%%%% Máster Universitario en Robótica - Universidad Miguel Hernández %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% @file   gui.m
% @brief  Graphical user interface created using GUIDE
% @author Raúl Tapia

function varargout = gui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_OpeningFcn, ...
    'gui_OutputFcn',  @gui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

%%% Initializations
global config
global robot
config.volume = 5;
config.numExits = 1;
config.representationSpeed = 1;
config.abort = false;
config.stop_signal = false;
robot.action = ' ';

%%% Logo
logo = imread('assets/umh.jpg');
imshow(logo);

%%% Timer
handles.timer = timer('TimerFcn', {@timer_Callback, hObject}, 'Period', 0.1, 'TasksToExecute', inf, 'ExecutionMode', 'fixedRate');
guidata(hObject, handles);
start(handles.timer);

% --- Callback for the timer.
function timer_Callback(hTimer, eventdata, hFigure)
handles = guidata(hFigure);

global robot

%%% Display action
set(handles.action_text,'String',['Robot action: ',robot.action]);

guidata(hFigure, handles);

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

% --- Executes on button press in escape_btn.
function escape_btn_Callback(hObject, eventdata, handles)
global config

%%% Set buttons
set(handles.reset_big_btn,'Enable','off');
set(handles.reset_small_btn,'Enable','off');
set(handles.escape_btn,'Enable','off');
set(handles.explore_btn,'Enable','off');
set(handles.optimize_btn,'Enable','off');
set(handles.closest_exit_btn,'Enable','off');

%%% Execute <escape>
callback_escape();

%%% Set buttons
if ~config.abort
    set(handles.reset_big_btn,'Enable','on');
    set(handles.reset_small_btn,'Enable','on');
    set(handles.optimize_btn,'Enable','on');
end

% --- Executes on button press in explore_btn.
function explore_btn_Callback(hObject, eventdata, handles)
global config robot

%%% Set buttons
set(handles.reset_big_btn,'Enable','off');
set(handles.reset_small_btn,'Enable','off');
set(handles.escape_btn,'Enable','off');
set(handles.optimize_btn,'Enable','off');
set(handles.closest_exit_btn,'Enable','off');

if strcmp(robot.action, 'exploring')
    %%% Stop exploration (user press stop)
    config.stop_signal = true;
else
    %%% Set stop button and execute <explore>
    set(handles.explore_btn,'String','Stop exploration');
    callback_explore();
end

%%% Set buttons
if ~config.abort
    set(handles.explore_btn,'Enable','off');
    set(handles.reset_big_btn,'Enable','on');
    set(handles.reset_small_btn,'Enable','on');
    set(handles.closest_exit_btn,'Enable','on');
end

% --- Executes on button press in optimize_btn.
function optimize_btn_Callback(hObject, eventdata, handles)
global config

%%% Set buttons
set(handles.reset_big_btn,'Enable','off');
set(handles.reset_small_btn,'Enable','off');
set(handles.escape_btn,'Enable','off');
set(handles.optimize_btn,'Enable','off');
set(handles.explore_btn,'Enable','off');
set(handles.closest_exit_btn,'Enable','off');

%%% Execute <optimize>
callback_optimize();

%%% Set buttons
if ~config.abort
    set(handles.reset_big_btn,'Enable','on');
    set(handles.reset_small_btn,'Enable','on');
    set(handles.optimize_btn,'Enable','on');
end

% --- Executes on button press in closest_exit_btn.
function closest_exit_btn_Callback(hObject, eventdata, handles)
global config

%%% Set buttons
set(handles.reset_big_btn,'Enable','off');
set(handles.reset_small_btn,'Enable','off');
set(handles.escape_btn,'Enable','off');
set(handles.optimize_btn,'Enable','off');
set(handles.explore_btn,'Enable','off');
set(handles.closest_exit_btn,'Enable','off');

%%% Execute <closest_exit>
callback_closest_exit();

%%% Set buttons
if ~config.abort
    set(handles.reset_big_btn,'Enable','on');
    set(handles.reset_small_btn,'Enable','on');
end

% --- Executes on button press in reset_big_btn.
function reset_big_btn_Callback(hObject, eventdata, handles)
%%% Reset and load big maze
callback_reset('big');

reset_wrappered_Callback(hObject, eventdata, handles)

% --- Executes on button press in reset_small_btn.
function reset_small_btn_Callback(hObject, eventdata, handles)
%%% Reset and load small maze
callback_reset('small');

reset_wrappered_Callback(hObject, eventdata, handles)

function reset_wrappered_Callback(hObject, eventdata, handles)

%%% Set buttons to default
set(handles.reset_big_btn,'Enable','on');
set(handles.reset_small_btn,'Enable','on');
set(handles.escape_btn,'Enable','on');
set(handles.explore_btn,'Enable','on');
set(handles.optimize_btn,'Enable','off');
set(handles.closest_exit_btn,'Enable','off');
set(handles.explore_btn,'String','Explore');

%%% Set signal to default
global config
config.stop_signal = false;

% --- Executes on slider movement.
function speed_slider_Callback(hObject, eventdata, handles)

%%% Get values
currentValue = get(hObject,'Value');
minValue = get(hObject,'Min');
maxValue = get(hObject,'Max');

% min --- 1
% x   --- ?
% max --- 40

%%% Compute speed
global config;
config.representationSpeed = round(39/(maxValue - minValue) * (currentValue - minValue) + 1);

% --- Executes during object creation, after setting all properties.
function speed_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in low_exits_btn.
function low_exits_btn_Callback(hObject, eventdata, handles)
global config;

%%% Less exits, please
config.numExits = config.numExits - 1;
set(handles.text_exits,'String',['Exits: ', num2str(config.numExits)]);

%%% Saturation
if config.numExits == 1
    set(handles.low_exits_btn,'Enable','off');
end
set(handles.high_exits_btn,'Enable','on');

% --- Executes on button press in high_exits_btn.
function high_exits_btn_Callback(hObject, eventdata, handles)
global config;

%%% More exits, please
config.numExits = config.numExits + 1;
set(handles.text_exits,'String',['Exits: ', num2str(config.numExits)]);

%%% Saturation
if config.numExits == 20
    set(handles.high_exits_btn,'Enable','off');
end
set(handles.low_exits_btn,'Enable','on');


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
%%% Bye bye!
disp_t('Closing GUI...');

%%% Interrupt any callback
global config;
config.abort = true;
pause(0.1);

%%% Kill everything :(
delete(hObject);
pause(0.1);

clc;
clear;
close all;


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
