clc;
mesh = imread('meshwhite.png');
mesh = mesh(:,:,1);
[h,w] = size(mesh);
col_black_total =zeros(1,w);
for i=1:w
    for j=1:h
        if mesh(j,i)<50
            col_black_total(i)=col_black_total(i)+1;
        end
    end
    if col_black_total(i)>100
        col_black_total(i)=1;
    else
        col_black_total(i) = 0;
    end
end

row_black_total =zeros(1,h);
for i=1:h
    for j=1:w
        if mesh(i,j)<50
            row_black_total(i)=row_black_total(i)+1;
        end
    end
end
tmp_arr =row_black_total;
for i=1:h
    if i>1 && abs(tmp_arr(i)-tmp_arr(i-1))<50
        tmp_arr(i-1)=0;
    end
end
for i=1:h
    if i>5 &&i<h-5
        if tmp_arr(i)~=0 && tmp_arr(i)<max( tmp_arr(1,i-5:i+5))
            tmp_arr(i)=0;
        end
    end
end
for i=1:h
    if tmp_arr(i)~=0
        tmp_arr(i)=1;
    end
end
tmp = 0;
for i=1:h
    if tmp_arr(i)==1
        tmp = tmp+1;
    elseif tmp~=0
        tmp_arr(i-ceil(tmp/2))=1;
        tmp=0;
    end
end
row_split = tmp_arr;

col_split =zeros(1,w);
tmp = 0;
for i=1:w
    if col_black_total(i)==1
        tmp = tmp+1;
    elseif tmp~=0
        col_split(i-ceil(tmp/2))=1;
        tmp=0;
    end
end


base = imread('basewhite.png');
[h1,w1,d1] = size(base);
if h1~=h || w1~=w
    return;
end

col_split_num = zeros(1,sum(col_split));
row_split_num = zeros(1,sum(row_split));
num = 0;
for i=1:length(col_split)
    if col_split(i)~=0
        num=num+1;
        col_split_num(num) = i;
    end
end
num = 0;
for i=1:length(row_split)
    if row_split(i)~=0
        num=num+1;
        row_split_num(num) = i;
    end
end

item_cells = cell(length(row_split_num)-1,length(col_split_num)-1);
rate_cells = cell(length(row_split_num)-1,length(col_split_num)-1);
for i=1:length(row_split_num)-1
    for j=1:length(col_split_num)-1
        area_item = base(row_split_num(i):row_split_num(i+1)-1,col_split_num(j):col_split_num(j+1)-1,:);
        item_cells(i,j) = {area_item};
        rate_cells(i,j) = {getItemColorRate(area_item)};
    end
end
for i=1:h
    if row_split(i)==1
        for j=1:w
            for k=1:3
                base(i,j,k)=0;
            end
        end
    end
end
for j=1:w
    if col_split(j)==1
        for i=1:h
            for k=1:3
                base(i,j,k)=0;
            end
        end
    end
end
imwrite(base,'meshbase.bmp');





