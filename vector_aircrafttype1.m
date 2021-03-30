function [sr1 sr2 sr3 sr4] = vector_aircrafttype1(sim1)


AB = sim1(1,:);
AC = sim1(4,:);
AD = sim1(28,:);
AE = sim1(26,:);
AF = sim1(27,:);
%  
 AA1k1 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & (AF == 2 | AF == 1) & AD == 1 ; % Lower North (LN)
 AA1k2 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & (AF == 2 | AF == 1) & AD == 2 ; % Lower North (LN)
 AA1k3 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & (AF == 2 | AF == 1) & AD == 3 ; % Lower North (LN)
 AA1k4 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & (AF == 2 | AF == 1) & AD == 4 ; % Lower North (LN)
 AA1k5 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & (AF == 2 | AF == 1) & AD == 5 ; % Lower North (LN)
 
 AA2k1 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 3 & AD == 1; % Lower Centre (LC)
 AA2k2 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 3 & AD == 2; % Lower Centre (LC)
 AA2k3 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 3 & AD == 3; % Lower Centre (LC)
 AA2k4 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 3 & AD == 4; % Lower Centre (LC)
 AA2k5 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 3 & AD == 5; % Lower Centre (LC)
 
 
 AA4k1 = AB>1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & (AF == 2 | AF == 3 | AF == 1) & AD == 1 ; % Terminal West (TW)
 AA4k2 = AB>1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & (AF == 2 | AF == 3 | AF == 1) & AD == 2 ; % Terminal West (TW)
 AA4k3 = AB>1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & (AF == 2 | AF == 3 | AF == 1) & AD == 3 ; % Terminal West (TW)
 AA4k4 = AB>1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & (AF == 2 | AF == 3 | AF == 1) & AD == 4 ; % Terminal West (TW)
 AA4k5 = AB>1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & (AF == 2 | AF == 3 | AF == 1) & AD == 5 ; % Terminal West (TW)
 


  
 AA7k1 = AB>1 & AC > meter(2500) & AC < meter(6000) & AE > nm(12) & AE < nm(30) & (AF == 1 | AF == 2 | AF == 3 | AF == 4) & AD == 1; % Arrival North (AN)
 AA7k2 = AB>1 & AC > meter(2500) & AC < meter(6000) & AE > nm(12) & AE < nm(30) & (AF == 1 | AF == 2 | AF == 3 | AF == 4) & AD == 2; % Arrival North (AN)
 AA7k3 = AB>1 & AC > meter(2500) & AC < meter(6000) & AE > nm(12) & AE < nm(30) & (AF == 1 | AF == 2 | AF == 3 | AF == 4) & AD == 3; % Arrival North (AN)
 AA7k4 = AB>1 & AC > meter(2500) & AC < meter(6000) & AE > nm(12) & AE < nm(30) & (AF == 1 | AF == 2 | AF == 3 | AF == 4) & AD == 4; % Arrival North (AN)
 AA7k5 = AB>1 & AC > meter(2500) & AC < meter(6000) & AE > nm(12) & AE < nm(30) & (AF == 1 | AF == 2 | AF == 3 | AF == 4) & AD == 5; % Arrival North (AN)

%  k1 = sum(AB>1 & AC>meter(500) & AC<meter(20000)& AD ==1);
% k2 = sum(AB>1 & AC>meter(500) & AC<meter(20000)& AD ==2);
% k3 = sum(AB>1 & AC>meter(500) & AC<meter(20000)& AD ==3);
% k4 = sum(AB>1 & AC>meter(500) & AC<meter(20000)& AD ==4);
% k5 = sum(AB>1 & AC>meter(500) & AC<meter(20000)& AD ==5);


sr1 = sum(AA1k1+AA1k2+AA1k3+AA1k4+AA1k5>0);
sr2 = sum(AA2k1+AA2k2+AA2k3+AA2k4+AA2k5>0);

sr3 = sum(AA4k1+AA4k2+AA4k3+AA4k4+AA4k5>0);

sr4 = sum(AA7k1+AA7k2+AA7k3+AA7k4+AA7k5>0);
