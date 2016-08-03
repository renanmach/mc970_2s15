% Processamento e Analise de Imagens (MC940) 
% Analise de Imagens (MO445)
% Professor: Helio Pedrini 
% Trabalho 2

% Autor: Renan Gomes Pereira
% Outubro 2015

function frames = read_video_conv_rgb2gray(path)
    video = VideoReader(path);
    numFrames = video.NumberOfFrames;
    frameHeight = video.Height;
    frameWidth = video.Width;
    
    frames = zeros(frameHeight, frameWidth, numFrames);
    
    % coverte para niveis de cinza
    for k = 1 : numFrames
        I = read(video, k);
        I = rgb2gray(I);
        
        frames(:,:,k) = I;
        
        %fprintf('frame %d\n', k);
        %imshow(frames(:,:,k), []);
       % pause(0.005);
    end
end

