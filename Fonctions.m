import Constantes.*;

% Recherche du bénifice maximal en fonctions des contraints 'cont' 
% et du maximum possible 'b'.
fComptable = -1*[919/60; 13; 1048/60; 19.5; 1376/60; 8.75];
[~, benefMax] = linprog(fComptable, cont, b, [], [], lb, ub, [], options);
fprintf('Le benefice maximal est de %d.\n',-benefMax);

% Recherche de la production maximale en fonctions des contraints 'cont' 
% et du maximum possible 'b'.
fResponsableAtelier = -1*[1;1;1;1;1;1];
[~, prodMax] = linprog(fResponsableAtelier, cont, b, [], [], lb, ub, [], options);
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
    [xBenef, benef] = linprog(fResponsableStocks, contBenef, bBenef, [], [], lb, ub, [], options);
    histoBenef(k, 1) = benef;
    
    % Deuxième approche
    bProd = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k*prodMax/100];
    [xProd, prod] = linprog(fResponsableStocks, contProd, bProd, [], [], lb, ub, [], options);
    histoProd(k, 1) = prod;
end

% Affichage
figure('numbertitle','off','name','Responsable atelier');

subplot(1,2,1);
plot(histoBenef);
title('En fonction du bénéfice');
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
    [xBenef, benef] = linprog(fResponsableAtelier, contBenef, bBenef, [], [], lb, ub, [], options);
    histoBenef(k, 1) = benef;
    
    % Deuxième approche
    bProd = [4800 4800 4800 4800 4800 4800 4800 850 920 585 k*prodMax/100];
    [xProd, prod] = linprog(fResponsableAtelier, contProd, bProd, [], [], lb, ub, [], options);
    histoProd(k, 1) = prod;
end

% Affichage
figure('numbertitle','off','name','Responsable du personnel');

subplot(1,2,1);
plot(histoBenef);
title('En fonction du bénéfice');
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
hold on;
plot(100*diff(diff(histoProd)))

dd = zeros(98, 2);
dd(:,1) = diff(diff(histoProd));
dd(:,2) = 2:99;
sort(dd, 1);
hold off;
