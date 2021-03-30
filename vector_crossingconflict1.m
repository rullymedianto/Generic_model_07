function [noc1 noc2 noc3 noc4] = vector_crossingconflict1(sim1)

AB = sim1(1,:);
AC = sim1(4,:);
AE = sim1(26,:);
AF = sim1(27,:);

% BC = sim1(22,:); %Waypoint 3rd
% BD = sim1(23,:); %Waypoint 4th
% BE = sim1(24,:); %Waypoint 5th
 
% Logic Crossing GAPRI

AA1aa = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 1 ; % Lower North (LN)Dorce
AA1bb = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 2  ; % Lower North (LN)BUNIK
AA1cc = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) &  AF == 3; % LN DENOK

AA4aa = AB>1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & AF == 1  ; % Terminal West (TW)
AA4bb = AB>1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & AF == 2  ; % Terminal West (TW)
AA4cc = AB>1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & AF == 3 ; % Terminal West (TW)

AA1a = sum(AA1aa>0);
AA1b = sum(AA1bb>0);
AA1c = sum(AA1cc>0);
AA4a = sum(AA4aa>0);
AA4b = sum(AA4bb>0);
AA4c = sum(AA4cc>0);

% AA1a = AA1aa;
% AA1b = AA1bb;
% AA1c = AA1cc;
% AA4a = AA4aa;
% AA4b = AA4bb;
% AA4c = AA4cc;

noc1 = (AA1a * AA1b)+ (AA1a * AA1c) + (AA1b * AA1c);
noc3 = (AA4a * AA4b)+ (AA4a * AA4c) + (AA4b * AA4c);

% noc1 = (AA1a .* AA1b)+ (AA1a .* AA1c) + (AA1b .* AA1c);
% noc4 = (AA4a .* AA4b)+ (AA4a .* AA4c) + (AA4b .* AA4c);

noc1 = noc1;
noc2 = 0;
noc3 = noc3;
noc4 = 0;

