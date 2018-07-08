function varargout = gui_denovo(varargin)
% GUI_DENOVO MATLAB code for gui_denovo.fig
%      GUI_DENOVO, by itself, creates a new GUI_DENOVO or raises the existing
%      singleton*.
%
%      H = GUI_DENOVO returns the handle to a new GUI_DENOVO or the handle to
%      the existing singleton*.
%
%      GUI_DENOVO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DENOVO.M with the given input arguments.
%
%      GUI_DENOVO('Property','Value',...) creates a new GUI_DENOVO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_denovo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_denovo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_denovo

% Last Modified by GUIDE v2.5 16-Apr-2018 12:05:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_denovo_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_denovo_OutputFcn, ...
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


% --- Executes just before gui_denovo is made visible.
function gui_denovo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_denovo (see VARARGIN)

% Choose default command line output for gui_denovo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_denovo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_denovo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
A=importdata('Pep1Sec.xlsx');
dt=A.data.x572;
[pks,locs]=findpeaks(dt(:,2),'MinPeakProminence',500);
plot(handles.axes1,dt(:,1),dt(:,2),dt(locs,1),pks,'.k')
plot(handles.axes2,dt(:,1),dt(:,2),dt(locs,1),pks,'.k')
%set(gca,'xtick',[])
offset=zeros(length(pks),1);
%offset(2)=offset(2)+20000;
%offset(10)=offset(11)+12000;

text(handles.axes1,dt(locs,1),pks+max(pks)*0.02+offset,num2str(dt(locs,1),4),'rotation',90);
xlim(handles.axes1,[100,1200])
ylim(handles.axes1,[0,max(pks)*1.2])
xlim(handles.axes2,[100,1200])
ylim(handles.axes2,[0,max(pks)*1.2])
%pks=pks/max(pks);
mz=dt(locs,1);
handles.exp=mz;
handles.pks=pks;
guidata(hObject, handles);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text6,'string','Optimizing...');
drawnow();
hold(handles.axes2,'off')
gui_denovo_OutputFcn(hObject, eventdata, handles)
n=10;
rng(3)
x=1:10;
exp=handles.exp;
pks=handles.pks;
ch=get(handles.edit1,'string');
fun=@(x)fit3(x,exp,handles,ch);
lb=ones(1,n)*0;
ub=ones(1,n)*1;
popu=str2num(get(handles.edit_popu,'string'));
gene=str2num(get(handles.edit_gene,'string'));
opts = gaoptimset(@ga);
opts = gaoptimset(opts,'PlotFcns',{@gaplotbestf,@gaplotstopping});
opts = gaoptimset(opts,'Generations',gene,'StallGenLimit',200);
opts = gaoptimset(opts,'PopulationSize',popu);
[x,score] = ga(fun,n,[],[],[],[],lb,ub,[],opts) ;%run ga optimization ***************
set(handles.text6,'string','Optimized');
set(handles.text_score,'string',num2str(-score));
drawnow();
[~,ind]=sort(x);
str=ch(ind);

%label figure 2
set(handles.edit1,'string',str);
[list,mz]=bylist(str);
for i=1:size(mz,1)
   for j=1:size(mz,2)
    for k=1:length(exp)
      if abs(mz(i,j)-exp(k))<0.5
          hold(handles.axes2,'on')
          lb=list{i,j};
          plot(handles.axes2,[exp(k),exp(k)],[0,pks(k)],'r')
          text(handles.axes2,exp(k),pks(k)+ max(pks)*0.02,lb);
          
      end
    end
   end
end
zoom(handles.axes2,'on');



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gene_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gene (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gene as text
%        str2double(get(hObject,'String')) returns contents of edit_gene as a double


% --- Executes during object creation, after setting all properties.
function edit_gene_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gene (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_popu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_popu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_popu as text
%        str2double(get(hObject,'String')) returns contents of edit_popu as a double


% --- Executes during object creation, after setting all properties.
function edit_popu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_popu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_frag_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frag as text
%        str2double(get(hObject,'String')) returns contents of edit_frag as a double

str=get(handles.edit_frag,'string');
if get(handles.radiobutton1,'value')
    opt='b';
else
    opt='y';
end
[mz,lb]=peptide_mz(str,opt);
mz2=(mz-1)/2+1;
mz2=round(mz2*10)/10;

set(handles.text_frag,'string',num2str(mz));
set(handles.text_frag2,'string',num2str(mz2));



% --- Executes during object creation, after setting all properties.
function edit_frag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
edit_frag_Callback(hObject, eventdata, handles)


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
edit_frag_Callback(hObject, eventdata, handles)
