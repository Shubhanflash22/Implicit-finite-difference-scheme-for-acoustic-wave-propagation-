% Define the grid dimensions and spacing
nx = 601; % number of grid points in the x-direction
ny = 601; % number of grid points in the y-direction
nz = 355; % number of grid points in the z-direction
dx = 10; % grid spacing in the x-direction (m)
dy = 10; % grid spacing in the y-direction (m)
dz = 10; % grid spacing in the z-direction (m)

% Define the velocity model
vp = ones(ny, nx, nz)*1500; % initialize the velocity model to a constant value
vp(:, 1:50, :) = 3500; % assign a higher velocity to the left half of the model
vp(:, 51:end, :) = 3500; % assign a higher velocity to the right half of the model
vp(1:50, :, :) = 1000; % assign a lower velocity to the top half of the model
vp(51:end, :, :) = 3500; % assign a higher velocity to the bottom half of the model
vp(:,:,1:50) = 0;
vp(:,:,51:end) = 2500;

% Visualize the velocity model using slice function
figure;
slice(vp,[],[],1:nz)
colormap jet;
xlabel('x')
ylabel('y')
zlabel('z')
colorbar;
title('Velocity Model');