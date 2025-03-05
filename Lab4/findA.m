function A = findA(N, audio)

R = zeros(N);
P = zeros(N,1);

rxxvals = zeros(N,1);

for k = 0:(N-1)
    rxxvals(k+1) = Rxx(k,audio);
end

for i= 1:N
    P(i) = Rxx(i,audio);
    for j = 1:N
        R(i,j) = rxxvals(abs(i-j) + 1);
    end
end


A = R\ P;

end 

function val = Rxx(k,x)
    val = mean(x(1:end-k) .* x(k+1:end));
end