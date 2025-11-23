function calculate_2D(m,s,snap)

[DxL, DxR]=sparce_der_D2_O6(m.nx);
[DzL, DzR]=sparce_der_D2_O6(m.nz);

dim=size(m.vp);
P0=zeros(dim);   P1=zeros(dim);   P2=zeros(dim);
DPX_O2=zeros(dim);  DPZ_O2=zeros(dim);

const= (s.dt*m.vp/m.dh).^2;
clear m.vp
pause(1);

for it=1:s.N
P1(s.sz,s.sx)=P1(s.sz,s.sx)+s.src(it);
    % Add First term
    for iz=1:m.nz;  DPX_O2(iz,:) = DxL\(DxR*P1(iz,:)');   end
    for ix=1:m.nx;  DPZ_O2(:,ix) = DzL\(DzR*P1(:,ix));    end      
    T1= const.*(DPX_O2 + DPZ_O2);
    
    % second term
    for iz=1:m.nz;  DPX_O2(iz,:) = DxL\(DxR*T1(iz,:)');   end
    for ix=1:m.nx;  DPZ_O2(:,ix) = DzL\(DzR*T1(:,ix));    end      
    T2= (DPX_O2 + DPZ_O2);
    
    P2=2*P1-P0 + T1 + (1/12)*(const.^2).*T2;
    
    if(mod(it,snap.disp)==0)
        figure(1);
        imagesc(m.dh*(0:m.nx-1),m.dh*(0:m.nz-1),P2);
        colormap('parula');  %colorbar
        xlabel('X(m) \rightarrow');    ylabel('\leftarrow Z(m) ')
        title(['Time = ',num2str(s.dt*(it-1)),'sec'])
        axis image;
        set(gca,'XaxisLocation','Top')
    end
    if(mod(it,snap.save)==0)
        save([snap.dir_name,'\',snap.name,'_',num2str(it)],'P1')
        savefig([snap.dir_name,'\',snap.name,'_',num2str(it),'.fig'])
        saveas(gcf,[snap.dir_name,'\',snap.name,'_',num2str(it),'.jpg'])
    end
    P0(2:m.nz,2:m.nx)=P1(2:m.nz,2:m.nx);
    P1(2:m.nz,2:m.nx)=P2(2:m.nz,2:m.nx);
    
    P1(1,:)= P1(2,:);
    pause(.01)
    SS(it,:) = P1(1,:);
end


save([snap.dir_name,'\',snap.name,'_SS'],'SS')
imagesc(m.dh*(0:m.nx-1), s.dt*(0:s.N-1),SS)
xlabel('X(m) \rightarrow')
ylabel('\leftarrow Time(sec)')
set(gca, 'XAxisLocation','Top')
savefig([snap.dir_name,'\',snap.name,'_SS.fig']);
saveas(gcf,[snap.dir_name,'\',snap.name,'_SS.jpg']);
end


