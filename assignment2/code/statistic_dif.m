% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 2

% Autor: Renan Gomes Pereira
% Outubro 2015

% Retorna o numero de transicoes entre dois quadros consecutivos
% Pelo metodo das diferencas estatisticas
function  trans = statistic_dif(frames, bs, t1, t2, plot_images)
    [frameHeight,frameWidth,numFrames] = size(frames);

    x = frameHeight/bs;
    y = frameWidth/bs;
    
    trans = 0;
    count = [];
       
    for k = 1:numFrames-1
        count(k) = 0;
        
        % calcula o erro quadriatico medio para os blocos
        for bx = 1:x
           for by = 1:y
               bloc1 = frames((bx-1)*(bs)+1:bx*bs,(by-1)*(bs)+1:by*bs,k);
               bloc2 = frames((bx-1)*(bs)+1:bx*bs,(by-1)*(bs)+1:by*bs,k+1);
               D = abs(bloc1-bloc2).^2;
               MSE = sum(D(:))/numel(bloc1); 
               if(MSE > t1) 
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

        tit = sprintf('Numero de Pixels diferentes para cada quadro com t1 = %d', t1);
        title(tit);
        xlabel('Quadros');
        ylabel('Numero de Pixels diferentes para cada quadro');
        hold off; 
    end
end
