import Constantes.*;

fComptable = -1*[919/60; 13; 1048/60; 19.5; 1376/60; 8.75];

fResponsableAtelier = -1*[1;1;1;1;1;1];

fResponsableStocks = [1; 1; 1; 1; 1; 1];

lb = [0 0 0 0 0 0];
ub = [9999 9999 9999 9999 9999 9999];

[x, benefMax] = linprog(fComptable, cont, b, [], [], lb, ub)
