function [desc1 desc2 desc3 desc4] = vector_descent1(sim1)
% global lim_low lim_up

%, desc2, desc3, desc4, desc5, desc6, desc7, desc8
AB = sim1(1,:);
AC = sim1(4,:);
AD = sim1(20,:);
AE = sim1(26,:);
AF = sim1(27,:);

 %AA1 = (AF == 2 | AF == 3 | AF == 1 | AF == 12) & AB>1 & AC > meter(15000) & AC < meter(24500) & AD == -1  ; % Lower North (LN)
 AA1 = AB>1 & AD == -1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & (AF == 2 | AF == 1) ; % Lower North (LN)
 AA2 = AB>1 & AD == -1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 3; % Lower Centre (LC)

 AA3 = AB>1 & AD == -1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & (AF == 2 | AF == 3 | AF == 1) ; % Terminal West (TW)

 AA4 = AB>1 & AD == -1 & AC > meter(2500) & AC < meter(6000) & AE > nm(12) & AE < nm(30) & (AF == 1 | AF == 2 | AF == 3); % Arrival North (AN)


% AF = find(AD == 0);
 
%desc= AF;
 desc1 = sum(AA1>0);
 desc2 = sum(AA2>0);
 desc3 = sum(AA3>0);
 desc4 = sum(AA4>0);
