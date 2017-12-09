function rate = getItemColorRate(item)
%ºìÉ«£º255,0,0
%»ÆÉ«£º255,255,0
%×ØÉ«£º204,102,0
[h,w,d] = size(item);
red_count = 0;
yellow_count = 0;
brown_count = 0;
for i=1:h
    for j=1:w
        if item(i,j,3)>180
            continue;
        elseif   item(i,j,1)>230 && item(i,j,2)>200 && item(i,j,2)- item(i,j,3)>100
            yellow_count = yellow_count+1;
        elseif item(i,j,1)>230 &&  item(i,j,2)<200 &&  item(i,j,3)<200 && abs(item(i,j,2) -  item(i,j,3))<125
            red_count = red_count+1;
       elseif item(i,j,1)>200 && item(i,j,1)<230 &&  item(i,j,2)<200 &&  item(i,j,3)<200
            brown_count = brown_count+1;
        end
    end
end
rate = [red_count yellow_count brown_count]./h./w.*100;