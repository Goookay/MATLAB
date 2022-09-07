m=100;
n = 10;
e = 10^-3;
k = 8*log10(n)/e^2;
xij = normrnd(0,1,n,m);
Jij = normrnd(0,1/k,k,n);

x_dist = zeros(n,n);

dist_x = 0;
for i=1:1:n
    for j=1:1:n
        for u = 1:1:m
           dist_x  = (xij(i,u)-xij(j,u))^2 + dist_x;
        end
            x_dist(i,j) = sqrt(dist_x);
            dist_x = 0;
    end
end
e_matrix1 = (1-e) * x_dist;
e_matrix2 = (1+e) * x_dist;

%% for J*x

jx = Jij*xij; %J*x matrix
%%
dist_J_xij = 0;
J_dist = zeros(k,10); % make a J*x matrix l^2 norm with 10 realizeation


for i=1:1:k
    for j=1:1:10
        for u = 1:1:m
           dist_J_xij  = (jx(i,u)-jx(j,u))^2 + dist_J_xij;
        end
            J_dist(i,j) = sqrt(dist_J_xij);
            dist_J_xij = 0;
    end
end

%% checking possible pairs 

count = zeros(1,10);

for i=1:1:10
    for j=1:1:10
    if(e_matrix1(j,i) <= J_dist(j,i) && J_dist(j,i) <= e_matrix2(j,i))
        count(1,i) = count(1,i) +1;
    else
    end
    end
end
% this part did not worked