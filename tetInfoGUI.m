function varargout = tetInfoGUI(varargin)
% TETINFOGUI MATLAB code for tetInfoGUI.fig
%      TETINFOGUI, by itself, creates a new TETINFOGUI or raises the existing
%      singleton*.
%
%      H = TETINFOGUI returns the handle to a new TETINFOGUI or the handle to
%      the existing singleton*.
%
%      TETINFOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TETINFOGUI.M with the given input arguments.
%
%      TETINFOGUI('Property','Value',...) creates a new TETINFOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tetInfoGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tetInfoGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tetInfoGUI

% Last Modified by GUIDE v2.5 24-May-2018 14:51:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tetInfoGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @tetInfoGUI_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before tetInfoGUI is made visible.
function tetInfoGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tetInfoGUI (see VARARGIN)

% Choose default command line output for tetInfoGUI
handles.output = hObject;

dat = get(handles.tet_table,'data');
handles.backup = dat;
if ~isempty(varargin)
    newDat = varargin{1};
    if ~isempty(newDat)
        fn = fieldnames(newDat);
        cn = get(handles.tet_table,'ColumnName');
        cn = strrep(lower(cn),' ','_');
        for l=1:numel(fn)
            idx = find(strcmp(cn,fn{l}));
            if ~isempty(idx)
                dat(:,idx) = {newDat.(fn{l})}';
            end
        end
        set(handles.tet_table,'data',dat)
        handles.backup = dat;
    end
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tetInfoGUI wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tetInfoGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
n = get(handles.tet_table,'ColumnName');
n = lower(n);
n = strrep(n,' ','_');
d = get(handles.tet_table,'data');
tetInfo = struct('tetrode',{1,2,3,4,5,6,7,8});
for l=1:numel(n)
    [tetInfo.(n{l})] = d{:,l};
end
varargout{1} = tetInfo;
delete(handles.figure1)


% --- Executes on button press in done_push.
function done_push_Callback(hObject, eventdata, handles)
% hObject    handle to done_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1)


% --- Executes on button press in cancel_push.
function cancel_push_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.tet_table,'data',handles.backup)
uiresume(handles.figure1)
