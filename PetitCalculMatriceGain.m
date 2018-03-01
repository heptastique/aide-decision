import Fonctions.*;

%fComptable
%fResponsableAtelier
%fResponsableStocks
%heureMachine1et3 = ( 8*2* xPersonnel(1) + (5+1)* xPersonnel(2) + 11 * xPersonnel(3) + 5 * xPersonnel(4) + 10* xPersonnel(5) + 5 * xPersonnel(6));
fResPerso = [ 8*2; (5+1); 11; 5; 10; 5 ];
fCom = [ 1; 1; 1; -1; -1; -1 ];

xCompta = [ 105.4885 40.7955 165.4667 0 189.3939 83.5915 ];
xAtelier = [ 0 227.5490 308.6275 16.2745 0 70];
xStock = [ 0 0 331.0149 3.3272 115.8836 0];
xPersonnel = [ 0 0 23.3510 81.6625 158.3308 328.3279];
xCom = [ 96.6445 39.6445 157.3934 0 193.9810 99.7014];



% point ajoutés
% desc point
% 6 - Optimisation commercial, avec contrainte sur temps machine 
ftemp = transpose(fResPerso);
contCom2 = [ contCom; ftemp ];
bCom2 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 0 0 5057.13];
[xCom2, benefMax] = linprog(fComptable, contCom2, bCom2, [], [], lb, ub, [], options);

% 7 - Optimisation commercial, avec contraintes sur temps machie et sur stock
ftemp2 = transpose(fResponsableStocks);
contCom3 = [ contCom2; ftemp2 ];
bCom3 = [bCom2 2651.012];
[xCom3, benefMax] = linprog(fComptable, contCom3, bCom3, [], [], lb, ub, [], options);

% 8 - Optimisation responsable des stocks avec contrainte sur benef
bBenefStock2 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 95*-10004.95/100];
[xStock2, benef] = linprog(fResponsableStocks, contBenef, bBenefStock2, [], [], lb, ub, [], options);

% 9 - Optimisation responsable des stocks avec contraintes sur benef et temps
% machine
ftemp = transpose(fResPerso);
contBenef3 = [ contBenef; ftemp ];
bBenefStock3 = [bBenefStock2 5057.13];
[xStock3, benef] = linprog(fResponsableStocks, contBenef3, bBenefStock3, [], [], lb, ub, [], options);

% 10 - Optimisation responsable des stocks avec contrainte sur benef plus petite
bBenef90 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 90*-10004.95/100];
[xStock90, benef] = linprog(fResponsableStocks, contBenef, bBenef90, [], [], lb, ub, [], options);

% 11 - Optimisation responsable personnel avec contrainte sur benef
bBenefPers2 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 95*-10004.95/100];
[xPers2, benef] = linprog(fResPerso, contBenef, bBenefPers2, [], [], lb, ub, [], options);

% 12 - Optimisation responsable personnel avec contrainte sur benef plus petite
bBenefPers3 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 90*-10004.95/100];
[xPers3, benef] = linprog(fResPerso, contBenef, bBenefPers3, [], [], lb, ub, [], options);
%
ftemp = transpose(fResPerso);
contCompta2 = [cont; ftemp];
bCompta2 = [b 1.30*3890.120];
[xCompta2, benef] = linprog(fComptable, contCompta2, bCompta2, [], [], lb, ub, [], options);
%
ftemp = transpose(fResponsableStocks);
contCompta3 = [contCompta2; ftemp];
bCompta3 = [bCompta2 1.25*2039.24];
[xCompta3, benef] = linprog(fComptable, contCompta3, bCompta3, [], [], lb, ub, [], options);
%
ftemp = transpose(fResponsableStocks);
contCompta4 = [cont; ftemp];
bCompta4 = [b 1.25*2039.24];
[xCompta4, benef] = linprog(fComptable, contCompta4, bCompta4, [], [], lb, ub, [], options);
%

% pasage de colonne à ligne
xCom2 = transpose (xCom2);
xCom3 = transpose (xCom3);
xStock2 = transpose (xStock2);
xStock3 = transpose (xStock3);
xStock90 = transpose (xStock90);
xPers2 = transpose (xPers2);
xPers3 = transpose (xPers3);
xCompta2 = transpose (xCompta2);
xCompta3 = transpose (xCompta3);
xCompta4 = transpose (xCompta4);

% le calcul du gain
xTousPoints = [ xCompta; xAtelier; xStock; xPersonnel; xCom; xCom2; xCom3; xStock2; xStock3; xStock90; xPers2; xPers3; xCompta2; xCompta3; xCompta4];
fCritere = [ -fComptable -fResponsableAtelier fResponsableStocks fResPerso fCom];
gain = xTousPoints * fCritere;
gainPercent = gain;
for k = 1:1:2
    gainPercent(:,k) = gain(:,k)/gain(k,k)*100;
end
gainPercent(:,3) = abs(gain(:,3)/gain(3,3)*100-200);
gainPercent(:,4) = abs(gain(:,4)/gain(4,4)*100-200);
for k = 1:1:length(gainPercent)
    gainPercent(k,5) = abs((abs(gain(k,5)/gain(k,2)*50))-100);
end
