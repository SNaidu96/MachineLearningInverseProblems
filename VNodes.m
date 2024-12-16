function [V_k] = VNodes(results,tensor)
    m = results.Mesh;
    N = findNodes(m,'region','Edge',1:4); %find Boundary Nodes
    
    x = m.Nodes(1,N); %x-cordinate of nodes
    y = m.Nodes(2,N); %y-cordinate of nodes
    %Find outward normal to get surface current density
    Norm_Vector = [x',y']; %Norm from cicular boundary is projection of point on boundary from origion
    for i=1:height(Norm_Vector)
        Norm_Vector(i,:)= Norm_Vector(i,:)/norm(Norm_Vector(i,:)); %make norm unit norm. 
    end
    %pdemesh(m);
    V_k = zeros(1,16);
% Compute angle
    theta = atan2d(y,x);
    id= find(theta<0);
    theta(id) = 360+theta(id); %change angle to range from 0,360 % Angles of all nodes at bndry
     gradUx = results.XGradients(N); %Only find results at boundary nodes
     gradUy = results.YGradients(N); %Only find results at boundary nodes
     electricFieldX = -gradUx;  % E_x = -dU/dx
     electricFieldY = -gradUy;  % E_y = -dU/dy
     %J = σ * (\gradE \cdot n), where σ is the conductivity tensor
     tensor = [tensor(1),tensor(2);tensor(2),tensor(3)];
     %Unit Normal to a circle is the projection from the centre of the bdry
          
    %find surface current density 
     currentDensityX = tensor(1,1) * (electricFieldX.*Norm_Vector(:,1)) + tensor(1,2) * (electricFieldY.*Norm_Vector(:,2));  % J_x
     currentDensityY = tensor(2,1) * electricFieldX.*Norm_Vector(:,1) + tensor(2,2) * electricFieldY.*Norm_Vector(:,2);  % J_y
     currentDensityMagnitude = sqrt(currentDensityX.^2 + currentDensityY.^2);
    for i=1:16
         Node_Index = find(theta>=22.5*(i-1) & theta<22.5*i); %nodes in e_i region. 
         if isempty(Node_Index)
             continue;
         end
         V_k(i) = mean(currentDensityMagnitude(Node_Index)); %mean current density at electrode.
    end
  
end