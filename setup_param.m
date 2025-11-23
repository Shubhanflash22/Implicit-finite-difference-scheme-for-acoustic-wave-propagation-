function snap=setup_param(snap,mparam)
if (~exist('snap','var') && ~isfield('snap','save'))
    disp('snap.save=ND, set to default(50)')
    snap.save=50;
end
if (~exist('snap','var') && ~isfield('snap','disp'))
    disp('snap.disp=ND, set to default(10)')
    snap.disp=10;
end
if ~exist('snap.dir_name','var')
    snap.dir_name= ['IMP_',mparam.name,'_',mparam.dim] ;
    disp(['snap.dir_name=ND, set to default(',snap.dir_name,')'])
end
if ~exist('snap.name','var')
    snap.name= ['IMP_',mparam.name,'_',mparam.dim,'_SNAP'] ;
    disp(['snap.name=ND, set to default(',snap.name,')'])
end

if ~exist(snap.dir_name,'dir');   mkdir(snap.dir_name);   end


end