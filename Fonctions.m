import Constantes.*;

% Recherche du bénifice maximal en fonctions des contraints 'cont' 
% et du maximum possible 'b'.
fComptable = -1*[859/60; 13; 1048/60; 19.5; 1376/60; 8.75];
[xCompta, benefMax] = linprog(fComptable, cont, b, [], [], lb, ub, [], options);
fprintf('cas comptable')
fprintf('produit comptable')
xCompta
fprintf('Le benefice maximal est de %d.\n',-benefMax);

% Recherche de la production maximale en fonctions des contraints 'cont' 
% et du maximum possible 'b'.
fResponsableAtelier = -1*[1;1;1;1;1;1];
[xAtelier, prodMax] = linprog(fResponsableAtelier, cont, b, [], [], lb, ub, [], options);
fprintf('cas resp atelier')
fprintf('produit resp atelier')
xAtelier
fprintf('La production maximale est de %d.\n',-prodMax);


%*************************************************************************%
%*************************************************************************%


% Fonction de minimisation 
fResponsableStocks = [5; 6; 4; 6; 6; 4];

% Le responsable des stocks veut que les stocks soient faibles.
% Deux approches :
% - La premiere en fonction du bénéfice
% - la deuxième en fonction de la production

% Initialisations de vecteurs.
histoBenef = zeros(100,1);
histoProd = zeros(100,1);

for k = 1:100
    
    % Premiere approche
    bBenef = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k*benefMax/100];
    [xStock, benef] = linprog(fResponsableStocks, contBenef, bBenef, [], [], lb, ub, [], options);
    histoBenef(k, 1) = benef;
    
    % Deuxième approche
    bProd = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k*prodMax/100];
    [xProd, prod] = linprog(fResponsableStocks, contProd, bProd, [], [], lb, ub, [], options);
    histoProd(k, 1) = prod;
end

% Affichage, abcisse pourcentage, ordonnée stock
figure('numbertitle','off','name','Responsable des stocks');

subplot(1,2,1);
plot(histoBenef);
title('En fonction du bénéfice');
xlabel('Pourcentage du bénéfice');
ylabel('Stock');
hold on;
plot(100*diff(diff(histoBenef)))

dd = zeros(98, 2);
dd(:,1) = diff(diff(histoBenef));
dd(:,2) = 2:99;
sort(dd, 1);
hold off;

subplot(1,2,2);
plot(histoProd);
title('En fonction de la production');
xlabel('Pourcentage de la production');
ylabel('Stock');
hold on;
plot(100*diff(diff(histoProd)))

dd = zeros(98, 2);
dd(:,1) = diff(diff(histoProd));
dd(:,2) = 2:99;
sort(dd, 1);
hold off;

%*************************************************************************%
%*************************************************************************%

% Le responsable du personnel veut réduire l'utilisation des machines 1 et 3
% Deux approches 
% - La premiere en fonction du bénéfice
% - la deuxième en fonction de la production

% Fonction de minimisation
fResponsablePersonnel = [16; 6; 11; 5; 10; 5];

% Initialisations de vecteurs.
histoBenef = zeros(100,1);
histoProd = zeros(100,1);

for k = 1:100
    
    % Premiere approche
    bBenef = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k*benefMax/100];
    [xStock, benef] = linprog(fResponsablePersonnel, contBenef, bBenef, [], [], lb, ub, [], options);
    histoBenef(k, 1) = benef;
    
    % Deuxième approche
    bProd = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k*prodMax/100];
    [xProd, prod] = linprog(fResponsablePersonnel, contProd, bProd, [], [], lb, ub, [], options);
    histoProd(k, 1) = prod;
end

% Affichage, abcisse pourcentage, ordonnée temps d'utilisation machine
% (en minutes)
figure('numbertitle','off','name','Responsable du personnel');

subplot(1,2,1);
plot(histoBenef);
title('En fonction du bénéfice');
xlabel('Pourcentage du bénéfice');
ylabel('Temps sur machines 1 et 3 (en minutes)');
hold on;
plot(50*diff(diff(histoBenef)))

dd = zeros(98, 2);
dd(:,1) = diff(diff(histoBenef));
dd(:,2) = 2:99;
sort(dd, 1);
hold off;

subplot(1,2,2);
plot(histoProd);
title('En fonction de la production');
xlabel('Pourcentage de la production');
ylabel('Temps sur machines 1 et 3 (en minutes)');
hold on;
plot(20*diff(diff(histoProd)))

dd = zeros(98, 2);
dd(:,1) = diff(diff(histoProd));
dd(:,2) = 2:99;
sort(dd, 1);
hold off;

%*************************************************************************%
%*************************************************************************%

% Le responsable commercial veut équilibrer les deux familles
% Deux approches 
% - La premiere en fonction du bénéfice
% - la deuxième en fonction de la production

% Initialisations de vecteurs.
histoBenef = zeros(10,1);
histoProd = zeros(10,1);

for k = 0:5:50
    bCom = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k k];
    
    % Premiere approche
    [~, benefMax] = linprog(fComptable, contCom, bCom, [], [], lb, ub, [], options);
    histoBenef((k/5)+1, 1) = benefMax*-1;
    
    % Deuxième approche
    [~, prodMax] = linprog(fResponsableAtelier, contCom, bCom, [], [], lb, ub, [], options);
    histoProd((k/5)+1, 1) = prodMax*-1;
end

% Affichage, abcisse différence entre famille, ordonnée bénéfice puis stock
% (en minutes)
figure('numbertitle','off','name','Responsable commercial');

subplot(1,2,1);
plot(histoBenef);
title('En fonction du bénéfice');
xlabel('Différence entre les familles');
ylabel('Bénéfice');

hold on;
plot(10*diff(diff(histoBenef)) + 10050);
dd = zeros(9, 2);
dd(:,1) = diff(diff(histoBenef))
dd(:,2) = 1:9;
sort(dd, 1);
hold off;

subplot(1,2,2);
plot(histoProd);
title('En fonction de la production');
xlabel('Différence entre les familles');
ylabel('Stock');

hold on;
plot(10*diff(diff(histoProd)) + 616)
dd = zeros(9, 2);
dd(:,1) = diff(diff(histoProd));
dd(:,2) = 1:9;
sort(dd, 1);
hold off;


fResponsableStocks;
bBenef = [4800 4800 4800 4800 4800 4800 4800 850 920 585 85*benefMax/100];
[xStock, benef] = linprog(fResponsableStocks, contBenef, bBenef, [], [], lb, ub, [], options);
fprintf('cas resp stock')
fprintf('produit resp stock')
xStock
resCalc = transpose(xStock)*fResponsableStocks; % et oui c'est pas beau
fprintf('Les stocks sont de %d.\n',resCalc);
fprintf('cas resp personnel')
bBenef = [4800 4800 4800 4800 4800 4800 4800 850 920 585 85*benefMax/100];
[xPersonnel, benef] = linprog(fResponsablePersonnel, contBenef, bBenef, [], [], lb, ub, [], options);
histoBenef(k, 1) = benef;
fprintf('produit resp personnel')
xPersonnel
heureMachine1et3 = ( 8*2* xPersonnel(1) + (5+1)* xPersonnel(2) + 11 * xPersonnel(3) + 5 * xPersonnel(4) + 10* xPersonnel(5) + 5 * xPersonnel(6));
fprintf('L utilisation de 1 et 3 est de %d.\n',heureMachine1et3);
bCom = [4800 4800 4800 4800 4800 4800 4800 850 920 585 0 0];
[xCom, benefMax] = linprog(fComptable, contCom, bCom, [], [], lb, ub, [], options);
fprintf('cas com')
fprintf('produit com')
xCom
fprintf('Quantité de de la famille A %d.\n',xCom(1)+ xCom(2) +xCom(3));