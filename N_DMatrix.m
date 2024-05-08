function [ND] = N_DMatrix(T,V_k)
    ND = zeros(16);
    % for row=1:16
    %     k = norm(T(:,row));
    %     T(:,row) = T(:,row)./k;
    %     V_k(:,row) = V_k(:,row)./k;
    % end

    for m=1:16
        for n=1:16
            ND(m,n) = sum(T(:,m).* V_k(:,n))/11.25; %t^k/area of electrode (16/360Degree *Unit Disk
        end
    end

    

end