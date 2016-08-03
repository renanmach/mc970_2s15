function img_out = bayer_matrix(img)
% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 3

% Autor: Renan Gomes Pereira
% RA 103927
% Outubro 2015

% Implementa a tecnica de pontilhado ordenado
% Utilizando a mascara da matriz de bayer

    M1 = [1 0 0 0; 0 0 0 0; 0 0 0 0; 0 0 0 0];
    M2 = [1 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 0];
    M3 = [1 0 0 0; 0 0 0 0; 1 0 1 0; 0 0 0 0];
    M4 = [1 0 1 0; 0 0 0 0; 1 0 1 0; 0 0 0 0];
    M5 = [1 0 1 0; 0 1 0 0; 1 0 1 0; 0 0 0 0];
    M6 = [1 0 1 0; 0 1 0 0; 1 0 1 0; 0 0 0 1];
    M7 = [1 0 1 0; 0 1 0 0; 1 0 1 0; 0 1 0 1];
    M8 = [1 0 1 0; 0 1 0 1; 1 0 1 0; 0 1 0 1];
    M9 = [1 0 1 0; 1 1 0 1; 1 0 1 0; 0 1 0 1];
    M10 = [1 0 1 0; 1 1 0 1; 1 0 1 0; 0 1 1 1];
    M11 = [1 0 1 0; 1 1 0 1; 1 0 1 0; 1 1 1 1];
    M12 = [1 0 1 0; 1 1 1 1; 1 0 1 0; 1 1 1 1];
    M13 = [1 1 1 0; 1 1 1 1; 1 0 1 0; 1 1 1 1];
    M14 = [1 1 1 0; 1 1 1 1; 1 0 1 1; 1 1 1 1];
    M15 = [1 1 1 0; 1 1 1 1; 1 1 1 1; 1 1 1 1];
    M16 = [1 1 1 1; 1 1 1 1; 1 1 1 1; 1 1 1 1];
    
    img =  16.*mat2gray(img);
    
    [x,y] = size(img);
    img_out = zeros(4*x,4*y);
       
    for i = 1:x
        a = 4*(i-1);
        for j = 1:y
            b = 4*(j-1)+1;  
            
            if(img(i,j) == 0)
                continue;
            elseif(img(i,j) <=1)
                img_out(a+1:a+4,b+1:b+4) = M1;
            elseif(img(i,j) <=2)
                img_out(a+1:a+4,b+1:b+4) = M2;                
            elseif(img(i,j) <=3)
                img_out(a+1:a+4,b+1:b+4) = M3;    
            elseif(img(i,j) <=4)
                img_out(a+1:a+4,b+1:b+4) = M4; 
            elseif(img(i,j) <=5)
                img_out(a+1:a+4,b+1:b+4) = M5; 
            elseif(img(i,j) <=6)
                img_out(a+1:a+4,b+1:b+4) = M6; 
            elseif(img(i,j) <=7)
                img_out(a+1:a+4,b+1:b+4) = M7; 
            elseif(img(i,j) <=8)
                img_out(a+1:a+4,b+1:b+4) = M8;    
            elseif(img(i,j) <=9)
                img_out(a+1:a+4,b+1:b+4) = M9; 
            elseif(img(i,j) <=10)
                img_out(a+1:a+4,b+1:b+4) = M10; 
            elseif(img(i,j) <=11)
                img_out(a+1:a+4,b+1:b+4) = M11; 
            elseif(img(i,j) <=12)
                img_out(a+1:a+4,b+1:b+4) = M12;
            elseif(img(i,j) <=13)
                img_out(a+1:a+4,b+1:b+4) = M13; 
            elseif(img(i,j) <=14)
                img_out(a+1:a+4,b+1:b+4) = M14; 
            elseif(img(i,j) <=15)
                img_out(a+1:a+4,b+1:b+4) = M15; 
            else
                img_out(a+1:a+4,b+1:b+4) = M16;
            end
        end
    end
end

