function [V_k] = VNodes(results)
    m = results.Mesh;
    N = findNodes(m,'region','Edge',[1:4]); %Boundary Nodes
    
    x = m.Nodes(1,N);
    y = m.Nodes(2,N);
    %pdemesh(m);
    V_k = zeros(1,16);
% Compute angle
    theta = atan2d(y,x);
    id= find(theta<0);
    theta(id) = 360+theta(id); %change angle to range from 0,360 % Angles of all nodes at bndry

    for i=1:16
         Node_Index = find(theta>=22.5*(i-1) & theta<22.5*i);
        % c=round(median(Node_Index)); %center of nodes in electrode
         if isempty(Node_Index)
             continue;
         end
         V_k(i) = mean(results.NodalSolution(Node_Index)); %center voltage at electrode.
    end
  
end