function [Voltages,results] = Voltage_Tk(model,T_k,tensor)
Voltages = zeros(16);
% figure;
% hold on; xlim([-1,1]); ylim([-1,1]);
%16 injection patterns, so we solve the pde repeatedly 16 times
    for row = 1:16
        %Apply dirichlet boundary condition
        applyBoundaryCondition(model,"dirichlet",'Edge',1:4,'h',1,'r',@t_k_func);
        generateMesh(model); %Suggested for 2D 
        results=solvepde(model); %results of solved PDE
        % %plot resulting voltage for differnet patterns 
        subplot(4,4,row);
        pdeplot(model,'XYData',results.NodalSolution,'Contour','on','ColorBar','on','ColorMap','jet'); hold on;
        pdegplot(model); %View Inc 
        title(sprintf('Injection %d',row));
        Voltages(:,row) = VNodes(results,tensor); %Find Voltage at center of electrode
    end
    
    function t = t_k_func(region,state)   
        % Apply trigonometirc basic voltage around boundary
    % Compute angle
        theta = atan2d(region.y,region.x);
       % plot(region.x,region.y,'ok'); hold on
        theta(theta<0)=360+theta(theta<0); %change angle to range from 0,360
        %360 degress/16electrodes = 22.5 degress for each electrode
       
        for i=1:16
            %16 electrodes
                nodes = find(theta>=22.5*(i-1) & theta<22.5*i); %E1: [0,22.5] , E2:2*[11.25,11.25*2]...etc
                if isempty(nodes) 
                    continue
                else
                    t(1,nodes) = T_k(i,row); %apply the current at those nodes
                  
                end
        
        end
    end

end