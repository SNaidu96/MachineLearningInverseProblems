function [FCNNSpecs] = GeometryGeneration_MultInc(FCNNSpecs)
   %% This function places multiple inclusions radially. 
    points_d = height(FCNNSpecs);
    C = [1,0,0,280]';%Unit disk 
    
    r1=38.8;
    class_size = floor(points_d/3);
    classes=[ones(class_size,1);2*ones(class_size,1);3*ones(class_size,1)];

    for i=1:points_d
            a=-5;b=5;
            inclu_x = a + (b-a).*rand(points_d,1);
            inclu_y = a + (b-a).*rand(points_d,1);
            C1 = [1,inclu_x(i),inclu_y(i),r1]';
      
            a=-150;b=-45;
            inclu_x = a + (b-a).*rand(points_d,1);
            inclu_y = 100 + (160-100).*rand(points_d,1);
            C2 = [1,inclu_x(i),inclu_y(i),r1]';

            a=45;b=150;
            inclu_x = a + (b-a).*rand(points_d,1);
            inclu_y = 100 + (160-100).*rand(points_d,1);
            C3 = [1,inclu_x(i),-inclu_y(i),r1]';
            
            if classes(i)==1
                sf = 'C+C1'; %compud the shapes in the geometry
                gm = [C,C1];
                ns = char('C','C1');
            elseif classes(i)==2
                sf = 'C+C1+C2'; %compud the shapes in the geometry
                gm = [C,C1,C2];
                ns = char('C','C1','C2');
            else
                sf = 'C+C1+C2+C3'; %compud the shapes in the geometry
                gm = [C,C1,C2,C3];
                ns = char('C','C1','C2','C3');
            end
            ns = ns';
            g = decsg(gm,sf,ns); %decsg is inbult function 
            FCNNSpecs(i).GeometryObject = g;
            FCNNSpecs(i).Num_Inclusion = classes(i);
            % figure;
            % pdegplot(g, 'FaceLabels', 'on');
            % title(sprintf('%d',classes(i)));
    end









   
end