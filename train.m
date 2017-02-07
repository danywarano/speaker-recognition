%----------------------------Train the audio data--------------------------
%Ashok Sharma Paudel, Deepesh Lekhak, Keshav Bashayal, Sushma shrestha
%--------------------------------------------------------------------------

function varargout = train(varargin)
% TRAIN MATLAB code for train.fig
%      TRAIN, by itself, creates a new TRAIN or raises the existing
%      singleton*.
%
%      H = TRAIN returns the handle to a new TRAIN or the handle to
%      the existing singleton*.
%
%      TRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAIN.M with the given input arguments.
%
%      TRAIN('Property','Value',...) creates a new TRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before train_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to train_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help train

% Last Modified by GUIDE v2.5 28-Apr-2013 13:49:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @train_OpeningFcn, ...
                   'gui_OutputFcn',  @train_OutputFcn, ...
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


% --- Executes just before train is made visible.
function train_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to train (see VARARGIN)

% Choose default command line output for train
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes train wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global p;
global n;

% --- Outputs from this function are returned to the command line.
function varargout = train_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% Get default command line output from handles structure
varargout{1} = handles.output;

global p;
try
    
    fid=fopen('total.txt','r');
    total=fscanf(fid,'%d');
    total=total+1;
    fid=fopen('total.txt','w');
    fprintf(fid,'%d',total);
    fclose(fid);
    set(handles.ttt,'string','Processing');
    %h 
    %H = findall(0,'edit1','edit2');
    %path=get(handles.edit1,'string');
    name=['sounds/',p.path,'.wav'];
    w=wavread(name);
    % set(handles.edit1,'string',p.path);
    x=featureExtract(w,22050);
    o=gmm(x,4,p.path,total);


    if isempty(o)
    set(handles.text1,'string','an error occured lets try again');
    o=gmm(x,4,p.path,total);
    end
    asd=['Thank You ',p.path,'\n','Your voice data had been trained. ']; 
    % set(handles.text2,'string',disp(o));
    set(handles.ttt,'string',asd);
catch 
    m=lasterr();
    errordlg(m);
end

 


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);

figure(welcome);
