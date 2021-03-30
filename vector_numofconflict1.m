function [noc1 noc2 noc3 noc4] = vector_numofconflict1(sim1)


AB = sim1(1,:);
AD = sim1(9,:);
AC = sim1(4,:);
AE = sim1(26,:);
AF = sim1(27,:);
 
%AF = AA > 1 & AB == 0 & AC>lim_low & AC<lim_up ;

 AA1 = AB>1 & AD == 0 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & (AF == 2 | AF == 1) ; % Lower North (LN)
 AA2 = AB>1 & AD == 0 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 3; % Lower Centre (LC)

 AA3 = AB>1 & AD == 0 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & (AF == 2 | AF == 3 | AF == 1) ; % Terminal West (TW)


 AA4 = AB>1 & AD == 0 & AC > meter(2500) & AC < meter(6000) & AE > nm(12) & AE < nm(30) & (AF == 1 | AF == 2 | AF == 3); % Arrival North (AN)


% AF = find(AD == 0);
 
%desc= AF;
noc1 = sum(AA1>0);
noc2 = sum(AA2>0);
noc3 = sum(AA3>0);
noc4 = sum(AA4>0);

