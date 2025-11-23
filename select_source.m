function sparam=select_source(sparam)%T,t0,dt,f0)
    sparam.N=round(sparam.t/sparam.dt);
    sparam.tvec=sparam.dt*(0:sparam.N-1);         

    tau_temp= sparam.tvec-sparam.t0;        
    pft= pi*pi*sparam.f0*sparam.f0*tau_temp.^2;
    sparam.src= (1-2*pft).*exp(-pft);      % plot(t,s.src)
end