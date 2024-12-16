function [DN] = D_NMatrix(T,C_k)
    DN = zeros(16);
    %Normalise current and Voltage
    for row=1:16
        k = norm(T(:,row));
        T(:,row) = T(:,row)./k;
        C_k(:,row) = C_k(:,row)./k;
    end
    %C_k is the surface current density and T is the applied
    %current(Trigonometic Basis)
    for m=1:16
        for n=1:16
            DN(m,n) = sum( C_k(:,n).*T(:,m)); %Calculate the DN MAtrix 
        end
    end

    

end