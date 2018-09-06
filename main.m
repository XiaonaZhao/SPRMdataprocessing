%% Cut from the others
[filename, pathname] = ...
    uigetfile({'*.xlsx';'*.xls';'*.*'},'File Selector');
[~,sheet] = xlsfinfo(fullfile(pathname, filename));

prompt = {'Select ONE sheet:',...
    'Enter the sequence number for axis-Y:',...
    'Enter the sequence number for axis-X:'};

dlg_title = 'Input';
num_lines = 1;

defaultans = {'5','2','4'}; 


answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
n = str2num(answer{1});
Y = str2num(answer{2}); 
X = str2num(answer{3});


[N, T] = xlsread(fullfile(pathname, filename),sheet{n});
Intensity = N(:,Y); % take out the number sequence
Potential = N(:, X);
imgNum = length(Potential); % the reason for 
%% 
Current = intensity2current(Intensity, imgNum);
skip = 18;
currentSkip = Current(1:skip:length(Current),:);

%% 
% hold on

% plot(Potential(2:end), -Current);
scatter(Potential(2:skip:end), -currentSkip, 'o');
% 
% hold off