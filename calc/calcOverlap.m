function ratio = calcOverlap( rec1, rec2, mode )
%l, t, r, d
%mode: 0=calc overlap, 1=if rect1 contains rect2(or contained by),
%2=overlap size, 3=overlap/min(s1,s2)
    rec1 = double(rec1);
    rec2 = double(rec2);
    if nargin < 3
        mode = 0;
    end
    s1 = (rec1(3)-rec1(1))*(rec1(4)-rec1(2));
    s2 = (rec2(3)-rec2(1))*(rec2(4)-rec2(2));
    so = max((min(rec1(4),rec2(4))-max(rec1(2),rec2(2))),0)*max((min(rec1(3),rec2(3))-max(rec1(1),rec2(1))),0);
    so = max(0, so);
    if mode==0
        ratio = so/(s1+s2-so+0.000000001);
    elseif mode==1
        ratio = min((so==s2||s0==s1),so);
    elseif mode==2
        ratio = s0;
    else
        ratio = so / min(s1,s2);
    end
end

