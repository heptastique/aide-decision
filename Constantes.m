% Contraintes temps d'usinages + matières par produits
cont = [
    8 5 0 5 0 5; 
    7 2 12 5 7 8; 
    8 1 11 0 10 0; 
    2 10 5 4 13 7; 
    15 0 8 7 10 0; 
    5 5 3 12 8 6; 
    13 3 5 8 10 7; 
    1 2 1 1 2 1; 
    3 2 1 1 1 2; 
    0 1 1 3 2 0
];

% Contraintes 'cont' + coût par produit
contBenef = [
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
    -859/60 -13 -1048/60 -19.5 -1376/60 -8.75
];

% Contraintes 'cont' + coût de stockage (ici 1 par produit)
contProd = [
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
    -1 -1 -1 -1 -1 -1
];

% Contraintes 'cont' + équilibrage des familles
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

% Capacité max d'utilisation des machines + côut du stock des matières
% premières.
b = [4800 4800 4800 4800 4800 4800 4800 850 920 585];

% Bornes
lb = [0 0 0 0 0 0];
ub = [9999 9999 9999 9999 9999 9999];

% Options pour supprimer le message 'Optimization terminated'
options = optimset('Display','none');