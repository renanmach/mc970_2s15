function img_out = lim_PMS(img, n, k, R, p, q)
    img_out = zeros(size(img));
    
    % numero de deslocamentos pra cima e para baixo da janela
    t = floor(n/2);
    
    img = padarray(img, [t, t], 'replicate');
    
    for i=t+1:size(img,1)-t
        for j=t+1:size(img,2)-t
            w = img(i-t:i+t, j-t:j+t);
            mi = double(mean(w(:))); 
            delta = std(w(:));
            
            % todo verificar parenteses
            T = mi*(1.0 + p*exp((-q)*mi) + (k*((delta/R)-1)));
            
            if img(i,j) < T
               img_out(i-t,j-t) = 0;
            else
               img_out(i-t,j-t) = 1;       
            end
        end 
    end 
end