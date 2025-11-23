function Ac_nD_cpt(model,source,snap)
if nargin==0 
    model.dim='3D'; 
    model.name='homogeneous'; 
    source.name= 'Ricker';
    source.dt=0.0005;
    source.f0=20;
    source.t=2;
    source.t0=0.055;
end

if (strcmp(model.name,'homogeneous') && strcmp(model.dim,'2D'))
    Ac_2D_cpt(model,source,snap)
elseif (strcmp(model.name,'homogeneous') && strcmp(model.dim,'3D'))
    Ac_3D_cpt(model,source,snap)

elseif (strcmp(model.name,'shantanu') && strcmp(model.dim,'2D'))
    Ac_2D_cpt(model,source,snap)
elseif (strcmp(model.name,'shantanu') && strcmp(model.dim,'3D'))
    Ac_3D_cpt(model,source,snap)
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Ac_2D_cpt(mparam,sparam,snap)
    mparam=select_model(mparam);              % model, dimension, coarsening
    sparam=select_source(sparam);
    
    snap=setup_param(snap,mparam);
    check_stability(sparam,mparam);
    
    save([snap.dir_name,'\ipdata'])
    calculate_2D(mparam,sparam,snap)       
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Ac_3D_cpt(mparam,sparam,snap)
    mparam=select_model(mparam);              % model, dimension, coarsening
    sparam=select_source(sparam);
    
    snap=setup_param(snap,mparam);
    check_stability(sparam,mparam);
    
    if isunix
        save([snap.dir_name,'/ipdata'],'-v7.3')
    elseif ispc
        save([snap.dir_name,'\ipdata'],'-v7.3')
    end
    calculate_3D(mparam,sparam,snap) 
end



% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function Ac_3D_cpt_homogeneous(mname,dim)
%     clc; clear
%     type_model=1;    dim=3;    Ord.T=2;           Ord.X=6;
%     m=select_model(type_model,dim);              % model, dimension, coarsening
%     s=select_source(2,.055,0.0005,20);   % source
%     s.x= round(m.nx/2);   s.y= round(m.ny/2);   s.z= round(m.nz/2);
%     check_stability(s,m);
%     figure related things
%     snap.save=50;   snap.disp=10;   snap.name= 'shantanu_3D_cpt';
%     if ~exist('snapshots_shantanu','dir');   mkdir('snapshots_shantanu');   end
%     calculate_3D(m,s,snap)
% 
%     load([pwd,'\snapshots_homogeneous\homogeneous_3D_cpt_700.mat'])
%     plot_3D_data_slice(P1,m.dh,m.dh*s.x,m.dh*s.y,m.dh*s.z)
% 
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function Ac_2D_cpt_shantanu(mname,dim)
%     type_model=3;    dim=2;    Ord.T=2;           Ord.X=6;
%     m=select_model(type_model,dim,2);              % model, dimension, coarsening
%     s=select_source(2,.055,0.0005,20);   % source
%     s.x= round(m.nx/2);   s.y= round(m.ny/2);   s.z= round(100);
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function Ac_3D_cpt_shantanu(mname,dim)
% for 3D
%     clc; clear
%     type_model=3;    dim=3;    Ord.T=2;           Ord.X=6;
%     m=select_model(type_model,dim,2);              % model, dimension, coarsening
%     s=select_source(2,.055,0.0005,20);   % source
%     s.x= round(m.nx/2);   s.y= round(m.ny/2);   s.z= round(m.nz/2);
%     check_stability(s,m);
%     figure related things
%     snap.save=50;   snap.disp=10;   snap.name= 'shantanu_3D_cpt';
%     if ~exist('snapshots_shantanu','dir');   mkdir('snapshots_shantanu');   end
%     calculate_3D(m,s,snap)
% 
%     load([pwd,'\snapshots_shantanu\shantanu_3D_cpt_1600.mat'])
%     plot_3D_data_slice(P1,10,m.dh*s.x,m.dh*s.y,m.dh*s.z)
% end

