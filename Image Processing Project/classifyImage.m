function isReceipt = classifyImage(I)
    % This function processes an image and
    % classifies the image as receipt or non-receipt
    
    % Processing
    gs = im2gray(I);
    gs = imadjust(gs);
    
    H = fspecial("average",3);
    gssmooth = imfilter(gs,H,"replicate");
    
    SE = strel("disk",8);  
    Ibg = imclose(gssmooth, SE);
    Ibgsub =  Ibg - gssmooth;
    Ibw = ~imbinarize(Ibgsub);
    
    SE = strel("rectangle",[3 25]);
    stripes = imopen(Ibw, SE);
    
    signal = sum(stripes,2);  

    % Classification
    minIndices = islocalmin(signal,"MinProminence",70,"ProminenceWindow",25); 
    nMin = nnz(minIndices);
    isReceipt = nMin >= 9;
    
end