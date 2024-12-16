
function [FCNNSpecs] = DatasetGeneration(points)
%%Initialise data structures
    FCNNSpecs=struct.empty(points,0);
    [T,T_k] = current_patterns();
    %Generate Object Geometry 
    FCNNSpecs = GeometryGeneration(FCNNSpecs);
     %change to  
    %FCNNSpecs = GeometryGeneration_MultInc(FCNNSpecs); %for
    % multiple inclusions
    for i=1:points
        %Solve the PDE for the generated domain
        [FCNNSpecs(i).CurrentDensity,FCNNSpecs(i).Results,tensor] = PDEConditions1(FCNNSpecs(i),T_k);
        FCNNSpecs(i).Vol = T_k; 
        V_k = FCNNSpecs(i).CurrentDensity;
        %Calculate the DN Matrix
        FCNNSpecs(i).DN = D_NMatrix(T,V_k); %Get DN Matrix  
        %Add noise 
        FCNNSpecs(i).NoisyDN = FCNNSpecs(i).DN + 0.01*randn(16);
        %Add data label for classification output
        FCNNSpecs(i).Label=0;
        %FCNNSpecs(i).Mu=tensor(1);

    end
     %Clear Workspace and save resuting data in .MAT file.
     clearvars all -except FCNNSpecs  
     save('FileName.mat', "FCNNSpecs",'-mat')
     % 
end
