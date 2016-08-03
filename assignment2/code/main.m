% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 2

% Autor: Renan Gomes Pereira
% Outubro 2015

clear all;

% Deseja que o programa plote os graficos?
plot_images = true;

% Escolha qual video deseja analisar
toy = true;
xylophone = true;

if toy
    fprintf('\nToy\n');
    frames = read_video_conv_rgb2gray('input/toy.mp4');

    t1 = 50;
    t2 = 500;

    count = pixel_dif(frames, t1, t2, plot_images);

    fprintf('Resultado para a diferenca entre pixels: %d\n', count);

    t1 = 100;
    t2 = 120;
    blockSize = 8;
    count = statistic_dif(frames, blockSize, t1, t2, plot_images);

    fprintf('Resultado para as diferencas estatisticas: %d\n', count);

    alfa = 1;
    nbins =  [4, 8, 32, 256];
    count = hist_dif(frames, alfa, nbins, plot_images);

    for i=1:size(nbins(:))
        fprintf('Resultado para histogramas com %d bins: %d\n', nbins(i), count(i));
    end
end

if xylophone
    fprintf('\nXylophone\n');
    frames = read_video_conv_rgb2gray('input/xylophone.mp4');

    t1 = 100;
    t2 = 70;

    count = pixel_dif(frames, t1, t2, plot_images);

    fprintf('Resultado para a diferenca entre pixels: %d\n', count);

    t1 = 100;
    t2 = 70;
    blockSize = 8;
    count = statistic_dif(frames, blockSize, t1, t2, plot_images);

    fprintf('Resultado para as diferencas estatisticas: %d\n', count);

    alfa = 0.4;
    nbins =  [4, 8, 32, 256];
    count = hist_dif(frames, alfa, nbins, plot_images);

    for i=1:size(nbins(:))
        fprintf('Resultado para histogramas com %d bins: %d\n', nbins(i), count(i));
   end
end
