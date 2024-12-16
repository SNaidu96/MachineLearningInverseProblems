function [voltages,results,tensor] = PDEConditions1(FCNNSpec,T_k)
    %Find the mesh generated for the sample
    shape = FCNNSpec.GeometryObject ; %The Inc Generated
    %MATLAB PDE oject with generated FEM Mesh
    model = createpde();
    geometryFromEdges(model,shape);
    %Anisotropy tensor if used
    %tensor = [randi([1,20],1);0;randi([1,20],1)]; %postive definite
    tensor = [1;0;1];
    %specify coefficients of PDE to solve. See 'doc specifuCoefficients'
    %for descriptions of m,d,c,a,f.
    specifyCoefficients(model,"m",0,"d",0,"c",1.45,"a",0,"f",0,"Face",1); % conductivity for Tank
    specifyCoefficients(model,"m",0,"d",0,"c",10,"a",0,"f",0,"Face",2); %conductivity for inclusion

    %conductivity for multiple inclusions.
     if FCNNSpec.Num_Inclusion ==2
         specifyCoefficients(model,"m",0,"d",0,"c",10,"a",0,"f",0,"Face",3); 
    elseif FCNNSpec.Num_Inclusion ==3
        specifyCoefficients(model,"m",0,"d",0,"c",10,"a",0,"f",0,"Face",3);
        specifyCoefficients(model,"m",0,"d",0,"c",10,"a",0,"f",0,"Face",4)
    end

      function c = coeff(region,state) 
          c = [region.x^2;0;region.y^2]; 
      end
    %% Apply Boundary-wise voltage 
    [voltages,results]=Voltage_Tk(model,T_k,tensor); %Voltage Patterns Applied

   


end