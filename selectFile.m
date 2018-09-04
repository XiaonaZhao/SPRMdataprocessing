% -----Information-----
% For the sake of 'protocolSPRM.m',...
% 
% Used to draw figures of (voltage,dY/dX) from SPRM.
% Author: S201346044@mail.dlut.edu.cn;
% License: http://www.apache.org/licenses/;
% look at here! There are still some questiones on mylgd{jY} = T(1,Y(jY)); % Give the legend NAMEs! 

function selectFile
% 
[filename, pathname] = ...
    uigetfile({'*.xlsx';'*.xls';'*.*'},'File Selector');
[~,sheet] = xlsfinfo(fullfile(pathname, filename));
% for i = 1:length(sheet) % 
%     sheet_n = sheet{i};
%  ullfile

% [r c] = size(M); % 
% R1 = M(2,:) % 
% 
prompt = {'Select ONE sheet:',...
    'Enter the sequence number for Frame:',...
    'Enter the sequence number for axis-Y:',...
    'Enter the label for axis-X',...
    'Enter the sequence number for axis-X:',...
    'Enter the original & final span for smoothing'};

dlg_title = 'Input';
num_lines = 1;

defaultans = {'1','3','2','Voltage /V','4','5 5'}; 


answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
n = str2num(answer{1});
F = str2num(answer{2}); 
Y = str2num(answer{3});
X = str2num(answer{5}); % X is calculated voltage
SPAN = str2num(answer{6});
% % Use curly bracket for subscript
% [val status] = str2num(answer{1});
% if ~status
%     % Handle empty value returned
%     % for unsuccessful conversion
%     % ...
% end
% % val is a scalar or matrix converted from the first input


if ~exist('Figure')
    mkdir('Figure')         
end
INpath = 'Figure';

%     M = findLow_HighVoltage(N);
%
[N, T] = xlsread(fullfile(pathname, filename),sheet{n});
f = N(:,F); % take out the number sequence
x = N(:,X); % the reason for 
mylgd = cell(1,length(Y)); % get the name of the columns
% iCount = 1; % 
for jY = 1:length(Y)
    %         f = figure; 
    % figure('visible','off') 
    hold on
    y = N(:,Y(jY));
    % x = M(:,1);
    % y = M(:,5);
    % plot(x,y); 
    y1 = smooth(y, SPAN(1)); 
    yy1 = diff(y1)./diff(f); 
    y2 = smooth(yy1,SPAN(2));
%     yy2 = y2(2:length(y2)-1,1); % What's this?
    %  yy2 = smooth(y2,30); 
    %         yy2 = diff(yy1)./diff(x); 
    %         yyy2 = smooth(yy2,30); 
    
    %       % 
    %         yyaxis left
    %         plot(x,yy1); 
    %         ylabel('intensity'); 
    
    % -----�?活右侧坐标轴-----
    %         yyaxis right
%     plot(X(1:length(yy2),1),yy2);
    plot(x(1:length(y2),1),y2); % please make sure 'x' is a sequence!
    % I cannot figure out line 71, so I note it & line 83 and add line 84.
%     ylabel('d(intensity)/d(frame)'); 
    
    %
%     xlabel(answer{4}); % Here used in diverse plot
%     mylgd{jY} = ['D3_', num2str(jY)]; % Give the legend NAMEs!
    mylgd{jY} = T(1,Y(jY)); % Give the legend NAMEs! 
    %         legend('???'); 
%     hold off
    
    %       
    %         INfilename = ['A9' num2str(n) 'NP' num2str(iCount) '.fig'];
    %         % 
    %         SavePath = fullfile(INpath, INfilename);
    %         saveas(f,SavePath);
    %         close(gcf)
%     iCount = iCount + 1; % 
    
end
xlabel(answer{4}); % 
ylabel('Current density'); % 
legend(mylgd);
hold off
% clear iCount
% end
