ds = imageDatastore("test_images");
nFiles = numel(ds.Files);
isReceipt = false(1,nFiles);

for k = 1:nFiles
    I = readimage(ds,k);
    isReceipt(k) = classifyImage(I);
end

receiptFiles = ds.Files(isReceipt);

montage(receiptFiles)
title("Receipts")
