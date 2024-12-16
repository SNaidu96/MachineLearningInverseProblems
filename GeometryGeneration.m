function [FCNNSpecs] = GeometryGeneration(FCNNSpecs)
   % Number of samples to generates
    points_d = height(FCNNSpecs);

    %Define circular tank
    C1 = [1,0,0,280*0.001]';%disk 
    a=-62;b=62; %to stay within tank boundary

    %define location of inclusion
    inclu_x = a + (b-a).*rand(points_d,1);
    inclu_y = a + (b-a).*rand(points_d,1);
    inclu_x = 0.001*inclu_x;
    inclu_y = 0.001*inclu_y;
    class_size = floor(points_d/4);

    %define radius of inclusion. ensure equal number of samples for each
    %inclusion size
    r1 = 0.001*(19.4/2)*ones(class_size,1);
    r2= 0.001*(38.8/2)*ones(class_size,1);
    r3=0.001*(58.2/2)*ones(class_size,1);
    r4=0.001*(77.6/2)*ones(class_size,1);
    radii = [r1;r2;r3;r4];
    %for the above defined inclusions, radius and location, generate FEM
    %Mesh.
    for i=1:points_d
        
        C2 = [1,inclu_x(i),inclu_y(i),radii(i)]';
        
        
        %% Make Geometry
     

       sf = 'C1+C2'; %compud the shapes in the geometry
        gm = [C1,C2];
        ns = char('C1','C2');
        ns = ns';
        g = decsg(gm,sf,ns); %decsg is inbult function 
        FCNNSpecs(i).GeometryObject = g;
        FCNNSpecs(i).Radius = radii(i);
        FCNNSpecs(i).Location = [inclu_x(i),inclu_y(i)];
       FCNNSpecs(i).Num_Inclusion=1; %Geometry Generated
        
    end
   
end