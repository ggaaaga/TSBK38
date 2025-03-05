function [SNR, q] = findSNR(x, delta)
    q = round(x/delta);
%     q(q>127) = 127;
%     q(q<-128) = -128;
    
    xhat = q*delta;
    
    D = mean((x-xhat).^2);
    sigma2 = mean(x.^2);
    SNR = 10*log10(sigma2/D);
end