function img_out = lim_global( img )
    T = mean(img(:));
    img_out = zeros(size(img));
    Tant = -1000;
    
   diferenca = 0.01;
   
   % encontra o limiar pelo metodo de Ridler e Calvard (1978)
    while abs(T-Tant) > diferenca
        Tant = T;
        
        R1 = [];
        R2 = [];

        for i=1:size(img,1)
           for j=1:size(img,2) 
               if img(i,j) < T
                   R1 = [R1 img(i,j)];
               else
                   R2 = [R2 img(i,j)];       
               end
           end
        end
        u1 = mean(R1(:));
        u2 = mean(R2(:));
        T = (u1 + u2)/2;
    end
    
    fprintf('T = %f\n', T);
    
    % Aplica o limiar global
    for i=1:size(img,1)
       for j=1:size(img,2) 
           if img(i,j) < T
               img_out(i,j) = 0;
           else
               img_out(i,j) = 1;       
           end
       end
    end
end

