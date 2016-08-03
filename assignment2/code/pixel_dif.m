% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 2

% Autor: Renan Gomes Pereira
% Outubro 2015

% Retorna o numero de transicoes entre dois quadros consecutivos
% Pelo metodo da diferenca entre pixels
function trans = pixel_dif(frames, t1, t2, plot_images)
    [frameHeight,frameWidth,numFrames] = size(frames);
    
    count = [];
    trans = 0;
    for k = 1 : numFrames-1
       count(k) = 0;
       for i = 1: frameHeight
           for j = 1: frameWidth
               dif = abs(frames(i,j,k)-frames(i,j,k+1));
               if(dif > t1)
                   count(k) = count(k) + 1;
               end
           end
       end
        
       if(count(k) > t2)
            trans = trans + 1;
       end
    end
    
    if plot_images
        figure; 
        plot(count,'black');

        hold on
        line([1 numFrames-1], [t2 t2],'Color', 'black', 'LineWidth',2, 'LineStyle', '--');

        legend('# pixels dif', 't2');

        tit = sprintf('Numero de pixels com alteracao de intensidade com t1 = %d', t1);
        title(tit);
        xlabel('Quadros');
        ylabel('Numero de pixels com alteracao de intensidade');
        hold off; 
    end
end
