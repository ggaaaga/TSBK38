function [psnr, bpp, imr]=transcoder(im, k1)

% This is a very simple transform coder and decoder. Copy it to your directory
% and edit it to suit your needs.
% You probably want to supply the image and coding parameters as
% arguments to the function instead of having them hardcoded.

% Somewhere to put the decoded image
imyr=zeros(size(im));
bits=0;

imy=rgb2ycbcr(im);
blocksize = [8 8];

% Quantization steps for luminance and chrominance
% qy = k1;
% qc = k1;

QL=repmat(1:blocksize(1), blocksize(1), 1); 
QL=(QL+QL-9)/8;
%k1 = 0.1; 
k2 = 0.7; 
qy = k1 * (1 + k2 * QL);
qc = qy; 


% Code luminance component %

% Tranformation %
tmp = bdct(imy(:,:,1), blocksize); % DCT
%tmp = bdwht(imy(:,:,1), blocksize); % DCT


% Quantization %
tmp = bquant(tmp, qy);             % Simple quantization

% Source coding %
% p = ihist(tmp(:));                 % Only one huffman code
% bits = bits + huffman(p);          % Add the contribution from
%                                    % each component

bits= bits + sum(jpgrate(tmp, blocksize));   % Add the contribution from 
			
% Decoding %
tmp = brec(tmp, qy);               % Reconstruction
imyr(:,:,1) = ibdct(tmp, blocksize, [512 768]);  % Inverse DCT
%imyr(:,:,1) = ibdwht(tmp, blocksize, [512 768]);  % Inverse DWHT

% Next we code the chrominance components
for c=2:3                          % Loop over the two chrominance components
    
    tmp = imy(:,:,c);
    
    % If you're using chrominance subsampling, it should be done
    % here, before the transform.
    
    factor = 0.5;
     tmp = imresize(tmp, factor);
    sz = size(tmp);
    
    
    % Tranformation %
    tmp = bdct(tmp, blocksize);      % DCT
    %tmp = bdwht(tmp, blocksize);      % DCT
    
    % Quantization %
    tmp = bquant(tmp, qc);           % Simple quantization
    % Source Coding %
%       p = ihist(tmp(:));               % Only one huffman code
%       bits = bits + huffman(p);        % Add the contribution from
%                                        % each component
    
    bits = bits + sum(jpgrate(tmp, blocksize));
	    
    % Decoding
    tmp = brec(tmp, qc);            % Reconstruction
    tmp = ibdct(tmp, blocksize, sz);  % Inverse DCT
    %tmp = ibdwht(tmp, blocksize, sz);  % Inverse DWHT
    
    % If you're using chrominance subsampling, this is where the
    % signal should be upsampled, after the inverse transform.
    
    tmp = imresize(tmp, 1/factor);
    
    imyr(:,:,c) = tmp;
  
end

% Display total number of bits and bits per pixel
bits;
bpp = bits/(size(im,1)*size(im,2));

% Revert to RGB colour space again.
imr=ycbcr2rgb(imyr);

% Measure distortion and PSNR
dist = mean((im(:)-imr(:)).^2);
psnr = 10*log10(1/dist);

% Display the original image
figure, imshow(im)
title('Original image')

%Display the coded and decoded image
figure, imshow(imr);
title(sprintf('Decoded image, %5.2f bits/pixel, PSNR %5.2f dB', bpp, psnr))

