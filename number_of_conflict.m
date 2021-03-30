function [noc_1, noc_2, noc_3, noc_4] = number_of_conflict(sim1)
% global lim_low lim_up

AB = sim1(1,:);
AC = sim1(4,:);
AD = sim1(30,:);
AE = sim1(26,:);
AF = sim1(27,:);

AA1 = AB>1 & AD == 0 & AC > meter(25000) & AC < meter(40000) & (AF == 2 | AF == 1);  % Lower North (LN)
AA2 = AB>1 & AD == 0 & AC > meter(25000) & AC < meter(40000) & AF == 3; % Lower Centre (LC)
AA3 = AB>1 & AD == 0 &(AC > meter(2000) & (AC < meter(25000) | AB == 3)) & (AF == 2 | AF == 3 | AF == 1); % Terminal West; (TW)
AA4 = AB>1 & AD == 0 & AC > meter(30) & (AC < meter(2000) | AE < nm(10)) & (AF== 1 | AF == 2 | AF == 3); % && (AF == 1 || AF == 2 || AF == 3);% Arrival North (AN)

%AA1 = AD > 0;
%  AA1 = AB>1 & AD > 0 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & (AF == 1 | AF == 2 ) ; % Lower North (LN)
%   AA2 = AB>1 & AD > 0 & AC > meter(15000) & AC < meter(24500) %& AE > nm(75) & AE < nm(150) & AF == 3; % Lower Centre (LC)
% 
%  AA3 = AB>1 & AD == 1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & (AF == 2 | AF == 3 | AF == 1) ; % Terminal West (TW)
% 
%  AA4 = AB>1 & AD == 1 & AC > meter(2500) & AC < meter(6000) & AE > nm(12) & AE < nm(30) & (AF == 1 | AF == 2 | AF == 3); % Arrival North (AN)
% 
% 
% % AF = find(AD == 0);
%  
% %desc= AF;
noc_1 = sum(AA1>0);
noc_2 = sum(AA2>0);
noc_3 = sum(AA3>0);
noc_4 = sum(AA4>0);
%noc_1 = sum(AA2>0);
