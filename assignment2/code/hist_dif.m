% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 2

% Autor: Renan Gomes Pereira
% Outubro 2015

% Retorna o numero de transicoes entre dois quadros consecutivos
% Pelo metodo da diferenca dos histogramas de intensidade
function count = hist_dif (frames, alfa, nbins, plot_images)
    
    [frameHeight,frameWidth,numFrames] = size(frames);
    
    count = [];
    for a = 1:size(nbins(:))
        x = []; % armazena a diferenca dos histogramas para cada frame
        count(a) = 0;

        A = (frames(:,:,1));
        h1 = hist(A(:),nbins(a));
        
        for k=2:numFrames
           A = frames(:,:,k);
           h2 = hist(A(:), nbins(a));

           % calcula a diferenca dos histogramas de intensidade 
           for i=1:nbins(a)
               d(i) = abs(h1(i)-h2(i));
           end

           x(k-1) = sum(d);

            h1 = h2;
        end

         mi = mean(x);
         gamma = std(x);

         t = mi + alfa*gamma;

         for k=1:numFrames-1
            if(x(k) > t)
                count(a) = count(a) + 1;
            end
         end
         
        if plot_images
            figure;
            plot(x, 'black'); 
            hold on
            line([1 numFrames-1], [t t],'Color', 'black', 'LineWidth',2, 'LineStyle', '--');

            legend('dif hist', 't');
            titulo = sprintf('Diferenca dos histogramas com %d bins de intensidade para cada quadro',nbins(a));
            title(titulo);
            xlabel('Quadros');
            ylabel('Diferenca dos histogramas de intensidade');
            hold off;
        end
    end
end
