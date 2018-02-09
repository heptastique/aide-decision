import Constantes.*;

fComptable = -1*[919/60; 13; 1048/60; 19.5; 1376/60; 8.75];

fResponsableAtelier = -1*[1;1;1;1;1;1];


lb = [0 0 0 0 0 0];
ub = [9999 9999 9999 9999 9999 9999];
bCom = [4800 4800 4800 4800 4800 4800 4800 850 920 585 0 0];
contCom = [
    8 5 0 5 0 5; 
    7 2 12 5 7 8; 
    8 1 11 0 10 0; 
    2 10 5 4 13 7; 
    15 0 8 7 10 0; 
    5 5 3 12 8 6; 
    13 3 5 8 10 7; 
    1 2 1 1 2 1; 
    3 2 1 1 1 2; 
    0 1 1 3 2 0;
    1 1 1 -1 -1 -1;
    -1 -1 -1 1 1 1
];

histoBenef = zeros(10,1);
histoProd = zeros(10,1);
for k = 0:5:50
    bCom = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k k];
    [x, benefMax] = linprog(fComptable, contCom, bCom, [], [], lb, ub);
    [x, prodMax] = linprog(fResponsableAtelier, contCom, bCom, [], [], lb, ub);
    histoBenef((k/5)+1, 1) = benefMax*-1;
    histoProd((k/5)+1, 1) = prodMax*-1;
end
plot(histoBenef)
    