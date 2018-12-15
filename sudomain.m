%sudo = load(sudo.mat);
alter = cell(9,9);
fillnum = 0;
%获得备选点组
for i = 1:9
    for j = 1:9
        if(sudo(i,j) == 0)
            alter = poss(sudo,i,j,alter);
            if length(alter{i,j}) == 1
                sudo(i,j) = alter{i,j};
                fillnum = fillnum + 1;
            end
        end
    end
end
%检查块上的单独备选
for m = 0:2
    for n = 0:2
        A = [];
        for k = 1:3
            for p = 1:3
                A = [A,alter{3*m+k,3*n+p}];
            end
        end
        %A为所有备选项
        for num = 1:9
            if sum(A == num) == 1
                for k = 1:3
                    for p = 1:3
                        ind = find(alter{3*m+k,3*n+p} == num);
                        if ~isempty(ind)
                            sudo(3*m+k,3*n+p) = num;
                            fillnum = fillnum + 1;
                        end
                    end
                end
            end
        end
    end
end
%check检查n是否可以放入（i，j）,不能返回1，能返回0；
function [k] = check(sudo,i,j,n)
k = 0;
%check列
flag1 = find(sudo(:,j) == n);
if ~isempty(flag1)
    k = 1;
    return;
end
%check行
flag2 = find(sudo(i,:) == n);
if ~isempty(flag2)
    k = 1;
    return;
end
%check框
p1 = 3*fix((i-1)/3) + 1;
p2 = 3*fix((j-1)/3) + 1;
flag3 = find(sudo(p1:p1+2,p2:p2+2) == n);
%返回值
if ~isempty(flag3)
    k = 1;
    return;
end
end
%poss将可能填入(i,j)的数放入alter{i,j}
function [alter] = poss(sudo,i,j,alter)
if sudo(i,j) == 0
    A = [];
    for n =1:9
        if check(sudo,i,j,n) == 0
            A = [A n];
        end
    end
    alter{i,j} = A;
end
end
