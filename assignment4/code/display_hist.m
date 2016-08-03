function hist = display_hist( img, nbins, s )
    hist = imhist(img, nbins);
    
    figure;
    bar(hist', 'black');
    
    title(s);
    xlabel('Bin');
    ylabel('Numero de pixels');
    xlabel('Bin');
    ylabel('Numero de pixels');
    
end

