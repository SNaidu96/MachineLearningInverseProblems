
function [FCNNSpecs] = DatasetGeneration(points)
    %FCNNSpecs=BrainSpecs(points); %Generate Conductivity and Thickness
    FCNNSpecs=struct.empty(points,0);
    [T,T_k] = current_patterns();
    FCNNSpecs = GeometryGeneration(FCNNSpecs);
   for i=1:points
        [FCNNSpecs(i).Voltages,FCNNSpecs(i).Results] = PDEConditions1(FCNNSpecs(i),T_k);
        FCNNSpecs(i).Cur = T_k; 
        V_k = FCNNSpecs(i).Voltages;
        FCNNSpecs(i).ND = N_DMatrix(T,V_k); %Get ND Matrix   
        FCNNSpecs(i).Label = 0;
        FCNNSpecs(i).NoisyND = FCNNSpecs(i).ND + 0.01*randn(16);
        clc,i
    end
     %clearvars all -except FCNNSpecs  
     %save('IsoDataIsoInc.mat', "FCNNSpecs",'-mat')
     % 
end

%%% Uncomment to plot
%This plots the 100th stroke postion and radius, change index for more. 
% g=s(1000).GeometryObject
% geometryFromEdges(model,g);
% delete(model.Geometry)
% model.Geometry = []
% geometryFromEdges(model,g)
% pdegplot(model,'EdgeLabels','on')