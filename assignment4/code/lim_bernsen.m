function img_out = lim_bernsen( img, n )
    img_out = zeros(size(img));
    
    % numero de deslocamentos pra cima e para baixo da janela
    t = floor(n/2);
    
    img = padarray(img, [t, t], 'replicate');
    
    for i=t+1:size(img,1)-t
        for j=t+1:size(img,2)-t     
            w = img(i-t:i+t, j-t:j+t);
            zmin = min(w(:)); 
            zmax = max(w(:)); 
            
            T = (zmin+zmax)/2;
            
            if img(i,j) < T
               img_out(i-t,j-t) = 0;
            else
               img_out(i-t,j-t) = 1;       
            end
        end 
    end  
end

