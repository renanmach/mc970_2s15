% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 3
% Autor: Renan Gomes Pereira
% RA 103927
% Outubro 2015
function  img_out = difusao_erro_floyd_steinberg(img, alternate)
% Implementa a tecnica de pontilhado por difusao de erro
% Utilizando o metodo de floyd-steinberg
    img = double(padarray(img, [1, 1], 0));
    
    [x,y] = size(img);
    img_out = zeros(x,y);
    
    % usada na varredura alternada
    flag = true; 
    a = 2;
    b = y-1;
    c = 1;
    
     for i = 2:x-1
         if (alternate == true)
            if(flag == true) 
               a = 2;
               b = y-1;
               c = 1;
            else
                a = y-1;
                b = 2;
                c = -1;
            end
         end
        for j=a:c:b
            if(img(i,j) > 128)
                img_out(i,j) = 255;
            else
                img_out(i,j) = 0;
            end
            
            erro = double(img(i,j))-double(img_out(i,j));
            
            if(flag)
                img(i, j+1) = img(i, j+1) + (7/16)*erro;
                img(i+1, j-1) = img(i+1, j-1) + (3/16)*erro;
                img(i+1, j) = img(i+1, j) + (5/16)*erro;
                img(i+1, j+1) = img(i+1, j+1) + (1/16)*erro;
            % espelha a mascara
            else
                img(i, j-1) = img(i, j-1) + (7/16)*erro;
                img(i+1, j+1) = img(i+1, j+1) + (3/16)*erro;
                img(i+1, j) = img(i+1, j) + (5/16)*erro;
                img(i+1, j-1) = img(i+1, j-1) + (1/16)*erro;   
            end             
        end
       if(alternate == true) 
           if(flag == true)
              flag = false;
           else
               flag = true;
           end
       end
     end
     % remove a borda de zeros
     img_out = img_out((2:x-1), (2:y-1));
end

