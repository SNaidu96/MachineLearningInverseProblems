function [T,T_k] = current_patterns()
%     %% Synthesise current patterns
    L=16; % from dataset
    T=zeros(16);
    a = pi^(-0.5);

    theta = 2*pi*([1:16]/16);
    %theta = [2*pi * (1:8) ./ 16,2*pi * (-1:-1:-8) ./ 16]
    
    theta=theta/4;
 
    for n=1:16
       for l=1:16
           if mod(n,2)==0
            T(l,n) = a*sin((n)*theta(l));
           else
            T(l,n) = a*cos((n+1)*theta(l));
           end
       end
    end
  
%elements are T(electrode,pattern)
    T_k=T;
    for pat = 1:16
          k = norm(T(:,pat));
        T_k(:,pat) = T(:,pat)./k; %Normalise Current as stated in Muller
        
    end

% % 
% figure; hold on;
% for i=1:16
% subplot(4,4,i);
% 
% plot(T(:,i))
% title(num2str(i));












    % 
    % N=16; % from paper
    % 
    % 
    % T_k = zeros(N);
    % a = pi^(-0.5);

   
    % figure; hold on;
    % sgtitle('Normalised current Patterns Generated for 16 Electrodes')
    % for i=1:N
    %     subplot(4,4,i);
    %     plot(T_k(i,:));
    %     title(sprintf('Pattern %d',i));
    %     ylabel('Current');
    %     %xlabel('n');
    %     grid on;
    % end

end