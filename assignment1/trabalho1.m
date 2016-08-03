% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Aluno: Renan Gomes Pereira 103927
%
% Trabalho 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 MAIN                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
function trabalho1 
    images_input_path = 'D:\LIVROS FACUL\12 semestre\MC940\trabalho 1\input\';
    images_output_path = 'D:\LIVROS FACUL\12 semestre\MC940\trabalho 1\output\';
    
    % escolhe quais procedimentos rodar
    combinacao = true;
    planos_bits = true;
    comparacoes = true;
    filtragem = true;
    mosaicos = true;
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Parte de combinacao de imagens          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if combinacao
        fprintf('1.1 Combinacao de Imagens\n');

        % inicialmente pega as duas imagens exemplo
        % do enunciado e as combina
        img1 = read_image('baboon256x256', 'png');
        img2 = read_image('monalisa256x256', 'png');

        % combina as duas imagens por meio da media dos seus tons de cinza
        img_combined = combination(img1, img2);

        % salva a imagem combinada no diretorio de OUTPUT
        save_image(img_combined, 'imagem1_combinada.pgm');

        % Agora combina duas imagens de tamanhos diferentes
        % Para isso primeiro as converte para 256x256

        img1 = read_image('girl', 'png');
        img2 = read_image('peppers', 'png');

        % redimensiona a imagem
        % NAO mantem o "aspect ratio" da imagem
        img1 = imresize(img1, [256, 256]); 
        img2 = imresize(img2, [256, 256]); 

        img_combined = combination(img1, img2);
        save_image(img_combined, 'imagem2_combinada.pgm');
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Parte de planos de bits                 %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if planos_bits
         fprintf('1.2 Planos de Bits\n');

         img1 = read_image('pool', 'png');
         s = strcat(images_output_path,'imagem3_bitplane');
         bit_planes(img1, s);

         img2 = read_image('lenna', 'png');
         s = strcat(images_output_path,'imagem4_bitplane');
         bit_planes(img2, s);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Parte das comparacoes de imagens        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if comparacoes
        img1 = read_image('baboon', 'png');
        img2 = read_image('peppers', 'png');
        
        compara(img1, img2, images_output_path); 
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Parte da filtragem                      %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if filtragem

        % As figuras sao salvas na pasta output/
        % torne show_screen true para mostrar 
        % as imagens na tela alem apenas salva-las.

        show_screen = false;

        fprintf('1.4 Filtragem\n');

        img1 = read_image('sails', 'png');
        img1 = rgb2gray(img1);
        img_filtrada = my_filter(img1);
        
        if show_screen 
            figure;
            imshow(img1); title('Imagem Original em Niveis de cinza');
            figure;
            imshow(img_filtrada); title('Imagem Filtrada');
        end
        
        save_image(img1, 'imagem7a_original.pgm');
        save_image(img_filtrada, 'imagem7b_filtrada.pgm');

        % aplicando ruido salt & pepper

        img_noise = imnoise(img1,'salt & pepper', 0.01);
        img_filtrada = my_filter(img_noise);
        
        if show_screen
            figure;
            imshow(img_noise); title('Imagem com ruido Salt & Pepper');
            figure;
            imshow(img_filtrada); title('Imagem com ruido Salt & Pepper filtrada');
        end
        
        save_image(img_noise, 'imagem8a_saltpepper.pgm');
        save_image(img_filtrada, 'imagem8b_saltpepper_filtrada.pgm');


        % aplicando ruido de poison

        img_noise = imnoise(img1,'poisson');
        img_filtrada = my_filter(img_noise);
        
        if show_screen
            figure;
            imshow(img_noise); title('Imagem com ruido de Poisson');
            figure;
            imshow(img_filtrada); title('Imagem com ruido de Poisson filtrada');
        end
        
        save_image(img_noise, 'imagem8c_poisson.pgm');
        save_image(img_filtrada, 'imagem8d_poisson_filtrada.pgm');


        % aplicando ruido speckle

        img_noise = imnoise(img1,'speckle');
        img_filtrada = my_filter(img_noise);
        
        if show_screen
            figure;
            imshow(img_noise); title('Imagem com ruido speckle');
            figure;
            imshow(img_filtrada); title('Imagem com ruido Speckle filtrada');
        end
        
        save_image(img_noise, 'imagem8e_speckle.pgm');
        save_image(img_filtrada, 'imagem8f_speckle_filtrada.pgm');

    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Parte dos mosaicos                      %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
        
    if mosaicos      
        fprintf('1.5 Moisaicos\n');

        img1 = read_image('lenna', 'png');
        img1 = rgb2gray(img1);
        
        im_mosaicos = cria_mosaicos(img1);
        save_image(im_mosaicos, 'imagem9b_mosaicos_lenna.pgm');
        
        img1 = read_image('girl', 'png');
        img1 = rgb2gray(img1);
        
        im_mosaicos = cria_mosaicos(img1);
        save_image(im_mosaicos, 'imagem9d_mosaicos_girl.pgm');        
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SubFuncoes da funcao main               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    function img = read_image(name, format) 
        s = strcat(images_input_path, name);
        img = imread(s, format);
    end

    function save_image(img, name)
       s = strcat(images_output_path, name);
       imwrite(img , s);
       fprintf('\tImagem %s salva.\n',s);
    end
end

function comb = combination(img1, img2)
% Combina duas imagens de mesmo tamanho por
% meio da media de seus n?veis de cinza.
% Retorna a imagem resultate
    
    % converte as imagens para tons de cinza
    img1 = rgb2gray(img1);
    img2 = rgb2gray(img2);
    
    comb = 0.5*img1 + 0.5*img2;
end

function bit_planes(img1, s) 
% Converte uma imagem colorida em uma imagem de n?veis de cinza. 
% Extrai os planos de bits 1 a 8, exibindo cada um deles na tela.
    img1 = rgb2gray(img1);

    % Le todos bit planes para a memoria
    a1 = logical(bitget(img1, 1));
    a2 = logical(bitget(img1, 2));
    a3 = logical(bitget(img1, 3));
    a4 = logical(bitget(img1, 4));
    a5 = logical(bitget(img1, 5));
    a6 = logical(bitget(img1, 6));
    a7 = logical(bitget(img1, 7));
    a8 = logical(bitget(img1, 8));
    
    imwrite(a1 , strcat(s, '1.pgm'));
    imwrite(a2 , strcat(s, '2.pgm'));
    imwrite(a3 , strcat(s, '3.pgm'));
    imwrite(a4 , strcat(s, '4.pgm'));
    imwrite(a5 , strcat(s, '5.pgm'));
    imwrite(a6 , strcat(s, '6.pgm'));
    imwrite(a7 , strcat(s, '7.pgm'));
    imwrite(a8 , strcat(s, '8.pgm'));

    % plota a figura
    figure;
    subplot(241), imshow(a1), title('Bit Plane 1');
    subplot(242), imshow(a2), title('Bit Plane 2');
    subplot(243), imshow(a3), title('Bit Plane 3');
    subplot(244), imshow(a4), title('Bit Plane 4');
    subplot(245), imshow(a5), title('Bit Plane 5');
    subplot(246), imshow(a6), title('Bit Plane 6');
    subplot(247), imshow(a7), title('Bit Plane 7');
    subplot(248), imshow(a8), title('Bit Plane 8');
end

function compara(img1, img2, s)
    
    R1 = imhist(img1(:,:,1), 32); % histograma do canal vermelho
    G1 = imhist(img1(:,:,2), 32); % histograma do canal verde
    B1 = imhist(img1(:,:,3), 32); % histograma do canal azul
    
    R2 = imhist(img2(:,:,1), 32); % histograma do canal vermelho
    G2 = imhist(img2(:,:,2), 32); % histograma do canal verde
    B2 = imhist(img2(:,:,3), 32); % histograma do canal azul   
    
    show_screen = false;  %%%%%%%%%%%%%%%%%%%%%%%%%
    
    if show_screen
        figure; 
        plot(R1,'r');
        hold on, plot(G1,'g');
        plot(B1,'b'), legend(' Red channel','Green channel','Blue channel'), 
        title('Histograma 32 bins da Imagem Baboon');
        hold off;
        
        figure; 
        plot(R2,'r');
        hold on, plot(G2,'g');
        plot(B2,'b'), legend(' Red channel','Green channel','Blue channel'), 
        title('Histograma 32 bins da Imagem Peppers');
        hold off;
    
        figure;
        plot(R1,'r');
        hold on,
        plot(R2,'r:'),
        legend(' Baboon Red Channel','Peppers Red Channel'),
        title('Comparacao dos histogramas do canal vermelho 32 bins');
        hold off;

        figure;
        plot(G1,'g');
        hold on,
        plot(G2,'g:'),
        legend(' Baboon Green Channel','Peppers Green Channel'),
        title('Comparacao dos histogramas do canal verde 32 bins');
        hold off;  

        figure;
        plot(B1,'b');
        hold on,
        plot(B2,'b:'),
        legend(' Baboon Blue Channel','Peppers Blue Channel'),
        title('Comparacao dos histogramas do canal azul 32 bins');
        hold off;
    end
    
    % Computando a similaridade entre as imagens:
    
    bins = [4, 32, 128, 256];
    
    distances = zeros(1, 4);
    
    % para todos tamanhos de bins
    for k = 1:4
        R1 = imhist(img1(:,:,1), bins(k)); % histograma do canal vermelho
        G1 = imhist(img1(:,:,2), bins(k)); % histograma do canal verde
        B1 = imhist(img1(:,:,3), bins(k)); % histograma do canal azul

        R2 = imhist(img2(:,:,1), bins(k)); % histograma do canal vermelho
        G2 = imhist(img2(:,:,2), bins(k)); % histograma do canal verde
        B2 = imhist(img2(:,:,3), bins(k)); % histograma do canal azul  

        soma_r1 = sum(R1(:));
        soma_g1 = sum(G1(:));
        soma_b1 = sum(B1(:));

        soma_r2 = sum(R2(:));
        soma_g2 = sum(G2(:));
        soma_b2 = sum(B2(:));  

        % normaliza os histogramas dos canais
        for i = 1:bins(k)
            R1(i) = R1(i)/soma_r1;
            R2(i) = R2(i)/soma_r2;
            G1(i) = G1(i)/soma_g1;
            G2(i) = G2(i)/soma_g2;
            B1(i) = B1(i)/soma_b1;
            B2(i) = B2(i)/soma_b2;
        end
        
        % calcula a distancia euclidiana de cada canal
        dist_red = norm(R1-R2);
        dist_green = norm(G1-G2);
        dist_blue = norm(B1-B2);

        distances(k) = (dist_red + dist_green +dist_blue)/3;   
    end
    
    % Plota figura 
    figure
    bar(bins, distances),
    
    for i1=1:numel(distances)
    text(bins(i1),distances(i1),num2str(distances(i1),'%0.4f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
    end
    
    title('Numero de Bins vs Distancia das Imagens'), 
    xlabel('Número de bins'), ylabel('Distancia');
end

function imfilt = my_filter(img)
% Aplica o filtro da media na img.
% Retorna a imagem resultante de 
% tamanho 256x256.
    
    % mascara do filtro da media
    h = (1/9)*ones(3,3);
    
    % adiciona uma borda de zeros
    img2 = padarray(img, [1, 1], 0);
    
    % converte os valores de img2 para double
    img2 = double(img2);
    
    [n,m]= size(img2);

    for i = 2:n-1
       for j = 2:m-1
           % obtem sub matriz 3x3 da imagem envolta de img(i,j)
           z = img2((i-1):(i+1), (j-1):(j+1), 1);
           % element wise multiplication
           z = z.*h;
           img2(i,j) = sum(z(:));
       end
    end
    
    % converte novamente a imagem para 
    % inteiros de 8 bits
    imfilt = uint8(img2(2:n-1, 2:m-1));
end

function mos = cria_mosaicos(img) 
% Retorna moisaco de 4x4 blocos da imagem
% A disposicao dos blocos foi escolhida 
% de forma arbitraria.
% As dimensoes da imagem devem ser pares.

    [n,m] = size(img);
    
    n_4 = n/4;
    m_4 = m/4;
    
    % A cada 4 indices do array mapeamento temos para o bloco b
    %(0<=b<=15):
    
    % mapeamento[1+4*b] - Origem bloco original b no eixo x
    % mapeamento[2+4*b] - Origem do bloco original b no eixo y
    % mapeamento[3+4*b] - Origem do bloco destino de b no eixo x
    % mapeamento[4+4*b] - Origem do bloco destino de b no eixo y
    
    mapeamento = [
                  1; 1;  % Origem bloco 1 x;y
                  (3*m_4)+1; (3*n_4)+1; % Destino do bloco 1 = bloco 16
              
                  1; n_4+1; % Origem bloco 2 x;y
                  1; (3*n_4)+1; % bloco 4
                  
                  1; (2*n_4)+1; % Origem bloco 3 x;y
                  (2*m_4)+1; n_4+1; % bloco 10
                  
                  1; (3*n_4)+1; % bloco 4
                  1; 1;  % Origem bloco 1 x;y
                  
                  m_4+1; 1; % bloco 5
                  (2*m_4)+1; (3*n_4)+1; % bloco 12
                  
                  m_4+1; n_4+1; % bloco 6
                  m_4+1; (2*n_4)+1; % bloco 7
                  
                  m_4+1; (2*n_4)+1; % bloco 7
                  m_4+1; n_4+1; % bloco 6
                  
                  m_4+1; (3*n_4)+1; % bloco 8
                  1; (2*n_4)+1; % bloco 3
                  
                  (2*m_4)+1; 1; % bloco 9
                  1; n_4+1; % bloco 2
                  
                  (2*m_4)+1; n_4+1; % bloco 10
                  m_4+1; (3*n_4)+1; % bloco 8
                  
                  (2*m_4)+1; (2*n_4)+1; % bloco 11
                  m_4+1; 1; % bloco 5
                  
                  (2*m_4)+1; (3*n_4)+1; % bloco 12
                  (3*m_4)+1; (2*n_4)+1; % bloco 15
                  
                  (3*m_4)+1; 1; % bloco 13
                  (2*m_4)+1; (2*n_4)+1; % bloco 11
                  
                  (3*m_4)+1; n_4+1; % bloco 14
                  (3*m_4)+1; 1; % bloco 13
                  
                  (3*m_4)+1; (2*n_4)+1; % bloco 15
                  (2*m_4)+1; 1; %bloco 9
                  
                  (3*m_4)+1; (3*n_4)+1; % Origem bloco 16 x;y
                  (3*m_4)+1; n_4+1; % bloco 14
                 ];

    img2 = uint8(zeros(n,m));

    for i = 1:16
        x = mapeamento(4*(i-1)+1);
        y = mapeamento(4*(i-1)+2);
        x_dest = mapeamento(4*(i-1)+3);
        y_dest = mapeamento(4*(i-1)+4);

        img2(y_dest:y_dest+n_4-1, x_dest:x_dest+m_4-1, 1) = img(y:y+n_4-1, x:x+m_4-1, 1);
        
        % Remover comentarios para ver a figura sendo gerada
        % figure;
        % imshow(img2);
    end
    mos = img2; 
end