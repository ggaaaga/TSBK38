function [xhat] = pred_decoder(q, a, delta)

% Function skeleton for a predictive decoder.
%
% [xhat] = pred_decoder(q, a, delta)
%
% Input:
%  q      onedimensional integer signal to decode
%  a      vector of predictor coefficients
%  delta  stepsize of uniform quantizer
%
% Output:
%  xhat   decoded signal



% Allocate variables
% All included for completeness. We really only need all xhat values,
% the other ones can be scalars in the code and are not needed as output
% variables
xhat = zeros(size(q));
dhat = zeros(size(q));
p    = zeros(size(q));

N = length(a);


% Main loop
for k=1:length(q)
    if k > N
        p(k) = sum(a .* flip(xhat(k-N:k-1)));  % Prediction, should be a linear combination of old xhat values
    else
        p(k) = 0;
    end  
  dhat(k) = q(k) * delta;               % Should be the reconstruction of the prediction error
  xhat(k) = p(k) + dhat(k);             % New decoded sample
end