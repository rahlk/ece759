function out = bern(n,k,p)

out = nchoosek(n,k)*p^(k)*(1-p)^(n-k);

end