function check_stability_n_param(s,m)
    %stability conditions
    C=(s.dt/m.dh)*max(max(m.vp));
    if (C<.7/sqrt(2))
        disp('Stabilty condition satisfied')
    else
        disp('Stabilty condition not satisfied....!!!!!')
    end
    
end