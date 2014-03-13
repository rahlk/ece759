function out = poissRnd(n,k,p)
%% log(gamma(k+1)) + log(out) = -np + log(npk)
log_out = (-n*p)+log(n) + k*log(p) - gammaln(k);
out = exp(log_out);
end