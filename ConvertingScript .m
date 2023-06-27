%Writing Filtered Data to Wav Files for LAB 6 DEMO
clear
clc

% Locate your selected song mp3 file, copy the path, and paste inside the
% apostrophes belolw.
%Path example--'C:User\Desktop\ENGR 202\LAB 6\Nirvana.mp3'
mpfilename = 'C:\Users\bwarr\Downloads\OSU2021\Lab7ENGR202\Crazy.mp3';

signal   = audioread(mpfilename);
info = audioinfo(mpfilename);
Fs = info.SampleRate;

%This is the data being sent to your Repeating Stair Block. Make sure that
%you change your Stair Vector to "Input" in your Simulink circuit.
Input = signal(:,1);

%This simulates the crossover network. Enter the file name of your network
%here.
%NOTE: Just the file name, you don't need the .slx
sim('AudioCrossoverNetwork');

%Assigning size parameters to your filter matrices
height = length(ans.F1);
IN = ones(height,2);
LP = ones(height,2);
HP = ones(height,2);
BP = ones(height,2);

%Filling in the first column with your filter data
IN(:,1) = ans.F1(:,1);
LP(:,1) = ans.F1(:,2);
HP(:,1) = ans.F1(:,3);
BP(:,1) = ans.F1(:,4);

%Changing the data to the second column of input data
Input = signal(:,2);

%Same as before. Copy the file name from line 19.
sim('AudioCrossoverNetwork');

%Filling in the second and final column.
IN(:,2) = ans.F1(:,1);
LP(:,2) = ans.F1(:,2);
HP(:,2) = ans.F1(:,3);
BP(:,2) = ans.F1(:,4);

%Writing the data you collected from each filter back to a playable wav
%file. Enter the path to the folder you created and called "demo". Make
%sure to keep the extension at the end of each line below. 

%Path example--'C:User\Desktop\ENGR 202\LAB 6\Demo\LOW.wav'

wavFileName = 'C:\Users\bwarr\Downloads\OSU2021\Lab7ENGR202\Demo\RAW.wav';
audiowrite(wavFileName, IN, Fs);

wavFileName = 'C:\Users\bwarr\Downloads\OSU2021\Lab7ENGR202\Demo\LOW.wav';
audiowrite(wavFileName, LP, Fs);

wavFileName = 'C:\Users\bwarr\Downloads\OSU2021\Lab7ENGR202\Demo\HIGH.wav';
audiowrite(wavFileName, HP, Fs);

wavFileName = 'C:\Users\bwarr\Downloads\OSU2021\Lab7ENGR202\Demo\BAND.wav';
audiowrite(wavFileName, BP, Fs);
