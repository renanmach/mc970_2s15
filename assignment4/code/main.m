% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 4

% Autor: Renan Gomes Pereira
% RA 103927
% Outubro 2015

clear all;
close all;

input_dir = 'input/';
output_dir = 'output/';

NUMERO = 2;1

images = {'arctichare'; 'blocks'; 'fruits'; 'pool'; 'fiducial'; 'sonnet'};

% matriz com o tamanho das janelas
% de preferencia usar valores impares
% Cada linha eh uma imagem
% Cada coluna eh o tamanho da janela para um metodo
% Ordem das colunas:
% bernsen, niblack, savoula, PMS, contraste, media, mediana
N = [15 15 15 5 15 15 15; %arctichare
    9 9 9 5 9 9 7; %blocks
    15 15 15 9 15 15 15; %fruits
    13 13 13 9 13 13 13; %pool
    9 9 9 9 9 9 9; %fiducial
    13 13 13 9 13 13 13]; %sonnet

% Linhas os valores de k para cada imagem
% Primeira coluna niblack
% Segunda sauvolaPitaksinen
% Terceira PMS
K = [-0.1 0.05 -0.01; %arctichare
    0.1 0.1 -0.0008; %blocks
    0.1 0.02 -0.0001; %fruits
    -0.05 0.02 -0.0025; %pool
    -0.05 0.02 -0.001; %fiducial
     0.01 0.05 -0.0025];  %sonnet

% Linhas os valores de R para cada imagem
% Primeira coluna sauvolaPitaksinen
% Segunda PMS
R = [128.0 0.2; %arctichare
    128.0 0.5; %blocks
    128.0 0.5; %fruits
    128.0 0.5; %pool
    128.0 0.5; %fiducial
    128.0 0.5]; %sonnet

nbins = 32;

while(true)
    fprintf('Escolha uma opcao\n');
    fprintf('0 - Sair \n');
    fprintf('1 - arctichare\n');
    fprintf('2 - blocks\n');
    fprintf('3 - fruits\n');
    fprintf('4 - pool\n');
    fprintf('5 - fiducial\n');
    fprintf('6 - sonnet\n');
    
   i = input('');
    
    if i < 1 || i > 8
       fprintf('Saindo\n');
       break; 
    end
    
    img = imread(strcat(input_dir, images{i}), 'pgm');
    
    s = sprintf('Histograma Imagem Original: %s', images{i}');
    display_hist(img, nbins, s);
    
    img = double(img);
    
    % Global
    fprintf('\nMetodo do Limiar Global para %s\n', images{i}');
    img_out = lim_global(img);

    s1 = sprintf('Global: %s', images{i}');
    h1 = imhist(img_out, 2);

    f = h1(1)/(h1(1)+h1(2));
    fprintf('Fracao de pixels pretos para %s = %.2f\n', images{i}', f);

    fname = sprintf('%s%s_global.pgm', output_dir, images{i}');
    imwrite(img_out, fname);

    % Bernsen
    fprintf('\nMetodo de Bernsen para %s\n', images{i}');
    img_out = lim_bernsen(img, N(i,1));  

    s2 = sprintf('Bernsen: %s. n=%d', images{i}', N(i,1));
    h2 = imhist(img_out, 2);

    f = h2(1)/(h2(1)+h2(2));
    fprintf('Fracao de pixels pretos para %s = %.2f\n', images{i}', f);

    fname = sprintf('%s%s_bernsen.pgm', output_dir, images{i}');
    imwrite(img_out, fname);

    % Niblack
    fprintf('\nMetodo de Niblack para %s\n', images{i}');
    img_out = lim_niblack(img, N(i,2), K(i, 1));

    s3 = sprintf('Niblack: %s. n=%d, k=%.2f', images{i}', N(i,2), K(i, 1));
    h3 = imhist(img_out, 2);

    f = h3(1)/(h3(1)+h3(2));
    fprintf('Fracao de pixels pretos para %s = %.2f\n', images{i}', f);

    fname = sprintf('%s%s_niblack.pgm', output_dir, images{i}');
    imwrite(img_out, fname);

    % Sauvola e Pitaksinen
    fprintf('\nMetodo de Sauvola e Pitaksinen para %s\n', images{i}');
    img_out = lim_sauvolaPitaksinen(img, N(i,3), K(i, 2), R(i,1));

    s4 = sprintf('Sauvola Pitaksinen: %s. n=%d, k=%.2f, R=%.2f', images{i}', N(i,3), K(i, 2), R(i,1));
    h4 = imhist(img_out, 2);

    f = h4(1)/(h4(1)+h4(2));
    fprintf('Fracao de pixels pretos para %s = %.2f\n', images{i}', f);

    fname = sprintf('%s%s_sauvolaPitaksinen.pgm', output_dir, images{i}');
    imwrite(img_out, fname);

    % Phansalskar, More e Sabale
    p = 2;
    q = 10;
    fprintf('\nMetodo de Phansalskar, More e Sabale para %s\n', images{i}');
    img_out = lim_PMS(img, N(i,4), K(i, 3), R(i,2), p, q);

    s5 = sprintf('PMS: %s. n=%d, k=%.2f, R=%.2f, p=%.2f,q=%.2f', images{i}', N(i,4), K(i, 3), R(i,2), p, q);
    h5 = imhist(img_out, 2);

    f = h5(1)/(h5(1)+h5(2));
    fprintf('Fracao de pixels pretos para %s = %.2f\n', images{i}', f);

    fname = sprintf('%s%s_PMS.pgm', output_dir, images{i}');
    imwrite(img_out, fname);

    % Contraste
    fprintf('\nMetodo do Contraste para %s\n', images{i}');
    img_out = lim_contraste(img, N(i,5));

    s6 = sprintf('Contraste: %s. n=%d', images{i}', N(i,5));
    h6 = imhist(img_out, 2);

    f = h6(1)/(h6(1)+h6(2));
    fprintf('Fracao de pixels pretos para %s = %.2f\n', images{i}', f);

    fname = sprintf('%s%s_contraste.pgm', output_dir, images{i}');
    imwrite(img_out, fname);

    % Media
    fprintf('\nMetodo da Media para %s\n', images{i}');
    img_out = lim_media(img, N(i,6));

    s7 = sprintf('Media: %s. n=%d', images{i}', N(i,6));
    h7 = imhist(img_out, 2);

    f = h7(1)/(h7(1)+h7(2));
    fprintf('Fracao de pixels pretos para %s = %.2f\n', images{i}', f);

    fname = sprintf('%s%s_media.pgm', output_dir, images{i}');
    imwrite(img_out, fname);

    % Mediana
    fprintf('\nMetodo da Mediana para %s\n', images{i}');
    img_out = lim_mediana(img, N(i,7));

    s8 = sprintf('Mediana: %s. n=%d', images{i}', N(i,7));
    h8 = imhist(img_out, 2);

    f = h8(1)/(h8(1)+h8(2));
    fprintf('Fracao de pixels pretos para %s = %.2f\n', images{i}', f);

    fname = sprintf('%s%s_mediana.pgm', output_dir, images{i}');
    imwrite(img_out, fname);

    figure;
    subplot(2,4,1);
    bar(h1'./1000, 'black');
    title(s1);
    ylim([0 size(img,1)*size(img,2)/1000]);
    xlabel('bin');
    ylabel('numero de pixels (x1000)');
    
    subplot(2,4,2);
    bar(h2'./1000, 'black');
    title(s2);
    xlabel('bin');
    ylabel('numero de pixels (x1000)');
    ylim([0 size(img,1)*size(img,2)/1000]);
    
    subplot(2,4,3);
    bar(h3'./1000, 'black');
    title(s3);
    xlabel('bin');
    ylabel('numero de pixels (x1000)');
    ylim([0 size(img,1)*size(img,2)/1000]);
    
    subplot(2,4,4);
    bar(h4'./1000, 'black');
    title(s4);
    xlabel('bin');
    ylabel('numero de pixels (x1000)');
    ylim([0 size(img,1)*size(img,2)/1000]);
    
    subplot(2,4,5);
    bar(h5'./1000, 'black');
    title(s5);
    xlabel('bin');
    ylabel('numero de pixels (x1000)');
    ylim([0 size(img,1)*size(img,2)/1000]);
    
    subplot(2,4,6);
    bar(h6'./1000, 'black');
    title(s6);
    xlabel('bin');
    ylabel('numero de pixels (x1000)');
    ylim([0 size(img,1)*size(img,2)/1000]);
    
    subplot(2,4,7);
    bar(h7'./1000, 'black');
    title(s7);
    xlabel('bin');
    ylabel('numero de pixels (x1000)');
    ylim([0 size(img,1)*size(img,2)/1000]);
    
    subplot(2,4,8);
    bar(h8'./1000, 'black');
    title(s8);
    xlabel('bin');
    ylabel('numero de pixels (x1000)');
    ylim([0 size(img,1)*size(img,2)/1000]);
end
