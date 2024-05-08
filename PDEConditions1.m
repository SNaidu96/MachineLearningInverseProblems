function [voltages,results] = PDEConditions1(FCNNSpec,T_k)
    % Here each Inc is individually associated the boundary conditions
    shape = FCNNSpec.GeometryObject ; %The Inc Generated
    
    model = createpde();
    geometryFromEdges(model,shape);
    tensor = [randi([2,20],1);0;randi([2,20],1)]; %postive definite
    specifyCoefficients(model,"m",0,"d",0,"c",1.45*tensor,"a",0,"f",0,"Face",1); % conductivity fo Tank
    specifyCoefficients(model,"m",0,"d",0,"c",10*tensor,"a",0,"f",0,"Face",2); %diff rad diff loc
    %% Apply Boundary-wise voltage 
    [voltages,results]=Voltage_Tk(model,T_k); %VOltage Patterns Applied

    %pdeplot(model,'XYData',results.NodalSolution,'Contour','on','ColorMap','jet')
    %%to plot
%     function emagVal = coeff(location,state)
% 
%         emagVal = sqrt(location.x.^2 + location.y.^2);
%         emagVal=rescale(emagVal,1,1.45); %max conductivity is 1.45 of saline
%         %emagVal = emagVal*[1;1;1];
%     end
% 
% function emagVal = coeff1(location,state)
% 
%         emagVal =  sqrt(location.x.^2 + location.y.^2);
%         emagVal=rescale(emagVal,10,20); %max conductivity is 10-20S/m 
% 
%     end
    


end