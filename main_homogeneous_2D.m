clc; clear all;
model.dim='2D';  
model.name='homogeneous';
model.coarse=1;
model.dh=4;
model.nx=801;
model.nz=401;

source.name= 'Ricker';
source.dt=0.0005;
source.f0=20;
source.t=1;
source.t0=0.055;
source.sx= round(model.nx/2);   source.sz= round(model.nz/2);

snap.save=200;   
snap.disp=50;   
snap.name='';
snap.dir_name='';
Ac_nD_cpt(model,source,snap)
%%%%%%%%%%%%%%%%%%%%%%%%%
%POST PROCESSING
%%%%%%%%%%%%%%%%%%%%%%%%%
plot_wave('IMP_homogeneous_2D','IMP_homogeneous_2D_SNAP_800')
plot_SS2D('IMP_homogeneous_2D','IMP_homogeneous_2D_SNAP_SS',[1:1800])


