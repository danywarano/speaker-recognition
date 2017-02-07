%-------------------------------speaker Identification  figure---------------------
%Ashok Sharma Paudel, Deepesh Lekhak, Keshav Bashayal, Sushma shrestha
%-----------------------------------------------------------------------------------


function varargout = Identification(varargin)
% IDENTIFICATION MATLAB code for Identification.fig
%      IDENTIFICATION, by itself, creates a new IDENTIFICATION or raises the existing
%      singleton*.
%
%      H = IDENTIFICATION returns the handle to a new IDENTIFICATION or the handle to
%      the existing singleton*.
%
%      IDENTIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IDENTIFICATION.M with the given input arguments.
%
%      IDENTIFICATION('Property','Value',...) creates a new IDENTIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Identification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Identification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Identification

% Last Modified by GUIDE v2.5 01-May-2013 23:07:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Identification_OpeningFcn, ...
                   'gui_OutputFcn',  @Identification_OutputFcn, ...
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


% --- Executes just before Identification is made visible.
function Identification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Identification (see VARARGIN)

% Choose default command line output for Identification
handles.output = hObject;
global x;
global n;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Identification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Identification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global a;
global n;
try
  fid=fopen('total.txt','r');
 total=fscanf(fid,'%d');
data=getaudiodata(a.r);
ceps=featureExtract(data,22050);
dis=identSpeaker(ceps,4,total);
if strcmp(a,'impostr')==1
    output='Sorry Access is denied.';
else
     output=['welcome! ',dis];
end
   

set(handles.text1,'string',output);
catch 
    m=lasterr();
    errordlg(m);
end


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);

figure(welcome);
