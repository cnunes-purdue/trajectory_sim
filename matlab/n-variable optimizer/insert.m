function [xAr,yAr] = insert(xAr,yAr,x,y)
    if length(xAr) > 1
        addr = find(xAr > x, 1 );
        xAr = [xAr(1:addr-1) x xAr(addr:end)];
        yAr = [yAr(1:addr-1) y yAr(addr:end)];
    elseif x > xAr
        xAr = [xAr x];
        yAr = [yAr y];
    elseif x < xAr
        xAr = [x xAr];
        yAr = [y yAr];
    end
end