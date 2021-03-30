function [sct] = sector(AB, AC, AE, AF)

 %elseif AB>1 && (AC > meter(2500) && AC < meter(6000)) || (AE > nm(12) && AE < nm(30)) && (AF == 1 || AF == 2 || AF == 3)
%   if AB>1 && (AC > meter(25000) && AC < meter(24500)) || (AE > nm(75) && AE < nm(150)) && (AF == 2 || AF == 1)  % Lower North (LN)
%      sect = 1;
%  elseif AB>1 && (AC > meter(25000) && AC < meter(24500)) || (AE > nm(75) && AE < nm(150)) && AF == 3 % Lower Centre (LC)
%      sect = 2;
%  elseif AB>1 && (AC > meter(6000) && AC < meter(15000)) || (AE > nm(30) && AE < nm(75)) && (AF == 2 || AF == 3 || AF == 1) % Terminal West (TW)
%      sect = 3;
%  elseif AB>1 && (AC > meter(2500) && AC < meter(6000)) || (AE > nm(12) && AE < nm(30))% && (AF == 1 || AF == 2 || AF == 3) % Arrival North (AN)
%      sect = 4;
%  else
%      sect = 0;
%  end


 if AB>1 && AC > meter(25000)&& AC < meter(40000) && (AF == 2 || AF == 1)  % Lower North (LN)
     sct = 1;
 elseif AB>1 && AC > meter(25000)&& AC < meter(40000) && AF == 3 % Lower Centre (LC)
     sct = 2;
 elseif AB>1 && (AC > meter(2000) && (AC < meter(25000) || AB == 3))% && (AF == 2 || AF == 3 || AF == 1) % Terminal West (TW)
     sct = 3;
 elseif AB>1 && AC > meter(30) && (AC < meter(2000) || AE < nm(10))%&& (AF == 1 || AF == 2 || AF == 3) % && (AF == 1 || AF == 2 || AF == 3) % Arrival North (AN)
     sct = 4;
 else
     sct =0;
 end
 
