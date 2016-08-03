function convert_video_2gray(folder, name)
    video = VideoReader(strcat(folder,name));
    numFrames = video.NumberOfFrames;
    frames = read(video);
    
    obj=VideoWriter(strcat(folder,strcat('gray', name)), 'MPEG-4');
    open(obj);

    for i = 1 : numFrames
        movie(i).cdata=rgb2gray(frames(:,:,:,i));
        %movie(i).colormap=gray;
    end
    
    writeVideo(obj,movie);
    close(obj);
end

