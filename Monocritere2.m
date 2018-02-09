import Constantes.*;

fComptable = -1*[919/60; 13; 1048/60; 19.5; 1376/60; 8.75];

fResponsableAtelier = -1*[1;1;1;1;1;1];

fResponsablePersonnel = [16; 6; 11; 5; 10; 5];

lb = [0 0 0 0 0 0];
ub = [9999 9999 9999 9999 9999 9999];

[x, benefMax] = linprog(fComptable, cont, b, [], [], lb, ub);
[x, prodMax] = linprog(fResponsableAtelier, cont, b, [], [], lb, ub);

histoStock = zeros(100,1);
histoProd = zeros(100,1);

for k = 1:100
    bStock = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k*benefMax/100];
    bProd = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k*prodMax/100];
    
    [xStock, stock] = linprog(fResponsablePersonnel, contBenef, bStock, [], [], lb, ub);
    [xProd, prod] = linprog(fResponsablePersonnel, contProd, bProd, [], [], lb, ub);
    
    histoStock(k, 1) = stock;
    histoProd(k, 1) = prod;
end

plot(histoStock)