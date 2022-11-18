% Run Harvard pump PHD ultra
% Thomas Cochard - Harvard University - 10/25/2022
close all; clear all;

%% Inputs

Q=[10 20 30];              % Imposed flow rates
DeltaT=10;                 % Time (s) at each flow rate

%% Comm

s = serial('COM4'); %Initialize pump on COM [serialportlist]

%Set all values in order to read values correctly

set(s, 'Timeout', 60);
set(s,'BaudRate', 9600);
set(s, 'Parity', 'none');
set(s, 'DataBits', 8);
set(s, 'StopBits', 1);
set(s, 'RequestToSend', 'off');

fopen(s); % Open pump data stream

fwrite(s, [double('run') char([13 10])]); % Write the ASCII value of 'run<CR><LF>' to the pump

for i=1:length(Q)
fwrite(s, [double(['irate ' num2str(Q(i)) ' m/h'])   char([13 10])]);
pause(DeltaT);
end

%% Stops the pump

fwrite(s, [double('stop') char([13 10])]);

%Close pump I/O stream

fclose(instrfind);

