function img_out = conjunto_dez_padroes(img)
% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 3

% Autor: Renan Gomes Pereira
% RA 103927
% Outubro 2015

% Implementa a tecnica de pontilhado ordenado
% Utilizando a mascara do conjunto de dez padroes

    img =  9.*mat2gray(img);
    
    [x,y] = size(img);
    img_out = zeros(3*x,3*y);
       
    for i = 1:x
        a = 3*(i-1);
        for j = 1:y
            b = 3*(j-1)+1;  
            
            if(img(i,j) == 0)
              continue;
            elseif(img(i,j) <=1)
                img_out(a+2,b+2) = 1;
            elseif(img(i,j) <=2)
                img_out(a+2,b+2) = 1;
                img_out(a+2,b+1) = 1;
            elseif(img(i,j) <=3)
               img_out(a+2,b+2) = 1;
               img_out(a+2,b+1) = 1; 
               img_out(a+3,b+2) = 1;
            elseif(img(i,j) <=4)
               img_out(a+2,b+2) = 1;
               img_out(a+2,b+1) = 1; 
               img_out(a+3,b+2) = 1;
               img_out(a+2,b+3) = 1;
            elseif(img(i,j) <=5)
               img_out(a+2,b+2) = 1;
               img_out(a+2,b+1) = 1; 
               img_out(a+3,b+2) = 1;
               img_out(a+2,b+3) = 1;
               img_out(a+1,b+3) = 1;
            elseif(img(i,j) <=6)
               img_out(a+2,b+2) = 1;
               img_out(a+2,b+1) = 1; 
               img_out(a+3,b+2) = 1;
               img_out(a+2,b+3) = 1;
               img_out(a+1,b+3) = 1;
               img_out(a+3,b+1) = 1;
            elseif(img(i,j) <=7)
               img_out(a+2,b+2) = 1;
               img_out(a+2,b+1) = 1; 
               img_out(a+3,b+2) = 1;
               img_out(a+2,b+3) = 1;
               img_out(a+1,b+3) = 1;
               img_out(a+3,b+1) = 1;
               img_out(a+1,b+1) = 1;
            elseif(img(i,j) <=8)
               img_out(a+2,b+2) = 1;
               img_out(a+2,b+1) = 1; 
               img_out(a+3,b+2) = 1;
               img_out(a+2,b+3) = 1;
               img_out(a+1,b+3) = 1;
               img_out(a+3,b+1) = 1;
               img_out(a+1,b+1) = 1;  
               img_out(a+3,b+3) = 1;
            else    
               img_out(a+2,b+2) = 1;
               img_out(a+2,b+1) = 1; 
               img_out(a+3,b+2) = 1;
               img_out(a+2,b+3) = 1;
               img_out(a+1,b+3) = 1;
               img_out(a+3,b+1) = 1;
               img_out(a+1,b+1) = 1;  
               img_out(a+3,b+3) = 1; 
               img_out(a+1,b+2) = 1;
            end
        end
    end
end

