function mparam=select_model(mparam)

%%%%%%%%%%%%%%%%%%%%%%%%% homogeneous model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (strcmpi(mparam.name,'homogeneous')&&    strcmpi(mparam.dim,'2D')) % 2D homogeneous model      
    mparam.vp = 2000*ones(mparam.nz,mparam.nx);      %rho=1800*ones(m.nz,m.nx);
elseif (strcmp(mparam.name,'homogeneous')&& strcmp(mparam.dim,'3D')) % 3D homogeneous model
    mparam.vp = 2000*ones(mparam.nx,mparam.ny,mparam.nz);
    
%%%%%%%%%%%%%%%%%%%%%%%%% layered model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif (strcmpi(mparam.name,'layered')&&    strcmpi(mparam.dim,'2D')) % 2D layered model
    mparam.vp= 1500*ones(mparam.nx,mparam.nz);
    mparam.vp(:,100:200)=2100;
    mparam.vp(:,200:300)=2800;
    mparam.vp(:,300:400)=3600;
elseif (strcmpi(mparam.name,'layered')&&    strcmpi(mparam.dim,'3D')) % 3D layered model
    mparam.nx=400; mparam.nz=400;    mparam.dh=5;
    mparam.vp= 1500*ones(mparam.nx,mparam.ny,mparam.nz);
    mparam.vp(:,:,100:200)=2100;
    mparam.vp(:,:,200:300)=2800;
    mparam.vp(:,:,300:400)=3600;
    
%%%%%%%%%%%%%%%%%%%%%%%%% Shantanu model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif (strcmpi(mparam.name,'shantanu')&&    strcmpi(mparam.dim,'2D')) % 2D Shantanu model
    load('model_shantanu');
    mparam.vp=vp;
    mparam.nx=size(mparam.vp,2);    mparam.nz=size(mparam.vp,1);
elseif (strcmp(mparam.name,'shantanu')&&    strcmp(mparam.dim,'3D'))% 3D Shantanu model
    load('model_shantanu');        mparam.dh=5;
    vp=vp(1:mparam.cr:end,1:mparam.cr:end);
    mparam.dh = mparam.cr*mparam.dh;
    mparam.nx=size(vp,2);    mparam.nz=size(vp,1);       mparam.ny=mparam.nx;
    mparam.vp=zeros(mparam.nx,mparam.ny,mparam.nz);
    for i=1:mparam.ny;      mparam.vp(:,i,:)=vp';        end
    
%%%%%%%%%%%%%%%%%%%%%%%%% Marmousi model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
elseif (type_model==4)
    load('marm_model')
    vp=marm_model(1:1000,8000:10000);           mparam.dh=1.25;
    mparam.nx=size(mparam.vp,2);    mparam.nz=size(mparam.vp,1);    mparam.ny=mparam.nx;
    mparam.vp=zeros(mparam.nx,mparam.ny,mparam.nz);
    for i=1:mparam.ny;      mparam.vp(:,i,:)=vp;        end
end

if strcmpi(mparam.dim,'2D')
    hf=imagesc(mparam.dh*(0:mparam.nx-1),mparam.dh*(0:mparam.nz-1),mparam.vp);
    title('Velocity model')
    xlabel('X(m) \rightarrow','FontSize',14);
    ylabel('\leftarrow Z(m)','FontSize',14)
    set(gca,'FontSize',12)
    colormap(flipud(gray))
    hcb=colorbar;
    hcb.Label.String = 'Velocity (m/s)';
    axis image
    
elseif strcmpi(mparam.dim,'3D')
    plot_3D_data_cube(mparam.vp,mparam.dh)
end
end