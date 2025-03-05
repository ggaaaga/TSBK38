function [xhat, q, p, d, dhat] = pred_coder(x, a, delta)

% Function skeleton for a predictive coder.
%
% [xhat, q, p, d, dhat] = pred_coder(x, a, delta)
%
% Input:
%  x      onedimensional signal to code
%  a      vector of predictor coefficients
%  delta  stepsize of uniform quantizer
%
% Output:
%  xhat   decoded signal (the coder always contains a decoder)
%  p      prediction
%  d      prediction error
%  dhat   reconstructed prediction error
%  q      quantized prediction error (typically an integer signal
%         suitable for source coding)


% Allocate variables
% All included for completeness. We really only need all xhat and q values,
% the other ones can be scalars in the code and are not needed as output
% variables
xhat = zeros(size(x));
d    = zeros(size(x));
dhat = zeros(size(x));
p    = zeros(size(x));
q    = zeros(size(x));

N = length(a);

% Main loop
for k=1:length(x)
    if k > N
        p(k) = sum(a .* flip(xhat(k-N:k-1)));  % Prediction, should be a linear combination of old xhat values
    else
        p(k) = 0; 
    end   
  d(k) = x(k) - p(k);                   % Prediction error
  q(k) = round(d(k) / delta);           % Should be the quantization of the prediction error
  dhat(k) = q(k) * delta;               % Should be the reconstruction of the prediction error
  xhat(k) = p(k) + dhat(k);             % New decoded sample
end