% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 3

% Autor: Renan Gomes Pereira
% RA 103927
% Outubro 2015

clear all;

% mudar para true se deseja mostrar as imagens na tela
% vai abrir muitas imagens
show_images = false;

% escolha quais metodos rodar
dez_padroes = true;
bayer = true;
floyd_steinberg = true;

input_dir = 'input/';
output_dir = 'output/';

images = {'baboon'; 'lena'; 'gradient'; 'monarch'; 'retina'; 'sonnet'; 'wedge'};

for i=1:7
    img = imread(strcat(input_dir, images{i}), 'pgm');
    
    if(dez_padroes)
        img_out = conjunto_dez_padroes(img);
        name = sprintf('%s%s_dez_padr.pgm', output_dir, images{i}');
        imwrite(img_out, name);
        
        if(show_images)
            figure;
            imshow(img_out);
        end
    end

    if(bayer)
        img_out = bayer_matrix(img);
        
        name = sprintf('%s%s_bayer.pgm', output_dir, images{i}');
        imwrite(img_out, name);
        
        if(show_images)
          figure;
          imshow(img_out);
        end
    end

    if(floyd_steinberg)
        % varredura alternada
        img_out = difusao_erro_floyd_steinberg(img, true);
        
        name = sprintf('%s%s_floyd_steinberg_alternada.pgm', output_dir, images{i}');
        imwrite(img_out, name);
        
        if(show_images)
            figure;
            imshow(img_out);
        end
        
        % varredura unidirecional
        img_out = difusao_erro_floyd_steinberg(img, false);
        
        name = sprintf('%s%s_floyd_steinberg_unidirecional.pgm', output_dir, images{i}');
        imwrite(img_out, name);
        
        if(show_images)
            figure;
            imshow(img_out);
        end 
    end
end

