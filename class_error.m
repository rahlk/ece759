function err = class_error(y, y_est)
[q, N] = size(y);
c=max(y);
err=0;
for i=1:N
    if(y(i)~=y_est(i))
        err=err+1;
    end
end