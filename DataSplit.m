% Data_Input = zeros(5000,16*16);
N=length(Data);
Data_Output = zeros(N,2);
Data_Input = zeros(N,16*16);
for i =1:N
    Data_Input(i,:) =rescale(reshape(Data(i).NoisyND,1,16*16));
    Data_Output(i,:) = [(Data(i).Label),abs((Data(i).Label)-1)];
    %Data_Output(i,:) = (Data(i).Label);
end
% id = randperm(5000);

% id = randperm(5000,500);
% Test_In = Data_Input(id,:);
% Test_Out = Data_Output(id,:);
% Data_Input(id,:)=[];
% Data_Output(id,:)=[];

 %Data_Output = categorical(Data_Output);
% Test_Out = categorical(Test_Out);