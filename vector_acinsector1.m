function [acin1, acin2, acin3, acin4] = vector_acinsector1(sim1)

AB = sim1(29,:);
% AC = sim1(4,:);
% AE = sim1(26,:);
% AF = sim1(27,:);
% 
% AA1 = AB>1 & AC > meter(25000) & AC < meter(40000) & (AF == 2 | AF == 1);  % Lower North (LN)
% AA2 = AB>1 & AC > meter(25000) & AC < meter(40000) & AF == 3; % Lower Centre (LC)
% AA3 = AB>1 & AC > (meter(2000) & (AC < meter(25000) | AB == 3)) & (AF == 2 | AF == 3 | AF == 1); % Terminal West; (TW)
% AA4 = AB>1 & AC > meter(30) & (AC < meter(2000) | AE < nm(10)) & (AF== 1 | AF == 2 | AF == 3); % && (AF == 1 || AF == 2 || AF == 3);% Arrival North (AN)
%  
% 
% % AF = find(AD == 0);
%  
% %desc= AF;

% 
%  acin1 = sum(AA1>0);
%  acin2 = sum(AA2>0);
%  acin3 = sum(AA3>0);
%  acin4 = sum(AA4>0);
 
 acin1 = sum(AB == 1);
 acin2 = sum(AB == 2);
 acin3 = sum(AB == 3);
 acin4 = sum(AB == 4);
 
 