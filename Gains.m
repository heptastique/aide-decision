import Fonctions.*

XCompta = [105.4885 40.7435 165.4667 0 189.3939 83.5915];
XAtelier = [0 227.5490 308.6275 16.2745 0 70];
XStocks = [0 0 331.0149 3.3272 115.8836 0];
XPersonnel = [0 0 23.3510 81.6625 158.3308 328.3279];
XCom = [96.6445 39.6445 157.3934 0 193.9810 99.7014];

A = [XCompta; XAtelier; XStocks; XPersonnel; XCom];
B = [-fComptable -fResponsableAtelier fResponsableStocks fResponsablePersonnel fResponsableCommercial];

A*B