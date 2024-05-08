function [FCNNSpecs] = GeometryGeneration(FCNNSpecs)
   
    points_d = height(FCNNSpecs);
    C1 = [1,0,0,280]';%Unit disk 
    a=-62;b=62; %to stay within skull boundary
    inclu_x = a + (b-a).*rand(points_d,1);
    inclu_y = a + (b-a).*rand(points_d,1);

    class_size = floor(points_d/4);
    r1 = 19.4*ones(class_size,1);
    r2= 38.8*ones(class_size,1);
    r3=58.2*ones(class_size,1);
    r4=77.6*ones(class_size,1);
    radii = [r1;r2;r3;r4];
    for i=1:points_d
        
        C2 = [1,inclu_x(i),inclu_y(i),radii(i)]';
        
        
        %% Make Geometry
        % sf = 'C1+C2+C3'; %compud the shapes in the geometry
        % gm = [C1,C2,C3];
        % ns = char('C1','C2','C3');

        sf = 'C1+C2'; %compud the shapes in the geometry
        gm = [C1,C2];
        ns = char('C1','C2');
        ns = ns';
        g = decsg(gm,sf,ns); %decsg is inbult function 
        FCNNSpecs(i).GeometryObject = g;
        FCNNSpecs(i).Radius = radii(i);
        %Geometry Generated
        
    end
   
end