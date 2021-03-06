function varargout = Responsi2_SAW(varargin)
% RESPONSI2_SAW MATLAB code for Responsi2_SAW.fig
%      RESPONSI2_SAW, by itself, creates a new RESPONSI2_SAW or raises the existing
%      singleton*.
%
%      H = RESPONSI2_SAW returns the handle to a new RESPONSI2_SAW or the handle to
%      the existing singleton*.
%
%      RESPONSI2_SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI2_SAW.M with the given input arguments.
%
%      RESPONSI2_SAW('Property','Value',...) creates a new RESPONSI2_SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Responsi2_SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Responsi2_SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Responsi2_SAW

% Last Modified by GUIDE v2.5 25-Jun-2021 19:15:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Responsi2_SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @Responsi2_SAW_OutputFcn, ...
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


% --- Executes just before Responsi2_SAW is made visible.
function Responsi2_SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Responsi2_SAW (see VARARGIN)

% Choose default command line output for Responsi2_SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Responsi2_SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Responsi2_SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file='Data_Rumah.xlsx'; 
table=xlsread(file,'Sheet1','A:G'); %membaca file xlsx
set(handles.uitable1,'data', table); %menampilkan data pada tabel gui

x=xlsread(file,'Sheet1','B:G'); %Membaca file xlsx
k=[0,1,1,1,1,1]; %pengaturan atribut
w=[0.30,0.2,0.23,0.1,0.07,0.1]; %pengaturan bobot

[m n]=size (x);
R=zeros (m,n);
Y=zeros (m,n);
for j=1:n,
 if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
  R(:,j)=x(:,j)./max(x(:,j));
 else
  R(:,j)=min(x(:,j))./x(:,j);
 end;
end;

for i=1:m,
 V(i)= sum(w.*R(i,:));
end;
Y=reshape(1:1001,1001,1).';
result1=[Y;V]; %menggabungkan matrix
result2=result1'; %mentranspose matrix
result=sortrows(result2,2, 'descend'); %mengsorting matrix berdasarkan pada nilai V
final=result(1:20,:); %memilih 20 nilai paling atas
set(handles.uitable2,'Data',final); %menampilkan data pada table gui
