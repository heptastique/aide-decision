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
ftemp = transpose(fResPerso);
contCom2 = [ contCom; ftemp ];
bCom2 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 0 0 5057.13];
[xCom2, benefMax] = linprog(fComptable, contCom2, bCom2, [], [], lb, ub, [], options);
%
ftemp2 = transpose(fResponsableStocks);
contCom3 = [ contCom2; ftemp2 ];
bCom3 = [bCom2 2651.012];
[xCom3, benefMax] = linprog(fComptable, contCom3, bCom3, [], [], lb, ub, [], options);
%
bBenefStock2 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 95*-10004.95/100];
[xStock2, benef] = linprog(fResponsableStocks, contBenef, bBenefStock2, [], [], lb, ub, [], options);
%
ftemp = transpose(fResPerso);
contBenef3 = [ contBenef; ftemp ];
bBenefStock3 = [bBenefStock2 5057.13];
[xStock3, benef] = linprog(fResponsableStocks, contBenef3, bBenefStock3, [], [], lb, ub, [], options);
%
bBenef90 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 90*-10004.95/100];
[xStock90, benef] = linprog(fResponsableStocks, contBenef, bBenef90, [], [], lb, ub, [], options);
%
bBenefPers2 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 95*-10004.95/100];
[xPers2, benef] = linprog(fResPerso, contBenef, bBenefPers2, [], [], lb, ub, [], options);
%
bBenefPers3 = [4800 4800 4800 4800 4800 4800 4800 850 920 585 90*-10004.95/100];
[xPers3, benef] = linprog(fResPerso, contBenef, bBenefPers3, [], [], lb, ub, [], options);
%
% pasage de colonne à ligne
xCom2 = transpose (xCom2);
xCom3 = transpose (xCom3);
xStock2 = transpose (xStock2);
xStock3 = transpose (xStock3);
xStock90 = transpose (xStock90);
xPers2 = transpose (xPers2);
xPers3 = transpose (xPers3);

% le calcul du gain
xTousPoints = [ xCompta; xAtelier; xStock; xPersonnel; xCom; xCom2; xCom3; xStock2; xStock3; xStock90; xPers2; xPers3];
fCritere = [ -fComptable -fResponsableAtelier fResponsableStocks fResPerso fCom];
gain = xTousPoints * fCritere;
gainPercent = gain;
for k = 1:1:2
    gainPercent(:,k) = gain(:,k)/gain(k,k)*100;
end
gainPercent(:,3) = gain(:,3)/gain(3,3)*100;
gainPercent(:,4) = gain(:,4)/gain(4,4)*100;
gainPercent(:,5) = gain(:,5)/(1000-gain(5,5))*100;
