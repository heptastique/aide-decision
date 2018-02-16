import Fonctions.*;

%fComptable
%fResponsableAtelier
%fResponsableStocks
%heureMachine1et3 = ( 8*2* xPersonnel(1) + (5+1)* xPersonnel(2) + 11 * xPersonnel(3) + 5 * xPersonnel(4) + 10* xPersonnel(5) + 5 * xPersonnel(6));
fResPerso = [ 8*2; (5+1); 11; 5; 10; 5 ];
fCompta = [ 1; 1; 1; -1; -1; -1 ];

xCompta = [ 105.4885 40.7955 165.4667 0 189.3939 83.5915 ];
xAtelier = [ 0 227.5490 308.6275 16.2745 0 70];
xStock = [ 0 0 331.0149 3.3272 115.8836 0];
xPersonnel = [ 0 0 23.3510 81.6625 158.3308 328.3279];
xCom = [ 96.6445 39.6445 157.3934 0 193.9810 99.7014];

xTousPoints = [ xCompta; xAtelier; xStock; xPersonnel; xCom];
fCritere = [ -fComptable -fResponsableAtelier fResponsableStocks fResPerso fCompta ];

gain = xTousPoints * fCritere