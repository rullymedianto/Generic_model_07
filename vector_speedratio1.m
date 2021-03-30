function [sr1 sr2 sr3 sr4] = vector_speedratio1(sim1)

AB = sim1(1,:);
AC = sim1(4,:);
AD = sim1(19,:);
AE = sim1(26,:);
AF = sim1(27,:);

%AF = AB>1 & AC>meter(500) & AC<meter(25000); 

 AA1 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & (AF == 2 | AF == 1) ; % Lower North (LN)
 AA2 = AB>1 & AC > meter(15000) & AC < meter(24500) & AE > nm(75) & AE < nm(150) & AF == 3; % Lower Centre (LC)
 AA3 = AB>1 & AC > meter(6000) & AC < meter(15000) & AE > nm(30) & AE < nm(75) & (AF == 2 | AF == 3 | AF == 1);  % Terminal West (TW)
 AA4 = AB>1 & AC > meter(2500) & AC < meter(6000) & AE > nm(12) & AE < nm(30) & (AF == 1 | AF == 2 | AF == 3); % Arrival North (AN)
 
AD1 = AD(AA1);
vmax1 = max(AD1);
vmin1 = min(AD1);
%as= AD(AD>80);

AD2 = AD(AA2);
vmax2 = max(AD2);
vmin2 = min(AD2);

AD3 = AD(AA3);
vmax3 = max(AD3);
vmin3 = min(AD3);

AD4 = AD(AA4);
vmax4 = max(AD4);
vmin4 = min(AD4);



if vmin1 < 50 | vmax1<50 | vmax1 == vmin1
     sr1 = 0;
 else
     sr1 = 10*(vmax1-vmin1)/vmin1;
 end


if vmin2 < 50 | vmax2<50 vmax2 == vmin2
    sr2 = 0;
else
   sr2 = 10*(vmax2-vmin2)/vmin2;
end
   
if vmin3 < 50 | vmax3<50 | vmax3 == vmin3
     sr3 = 0;
else
     sr3 = 10*(vmax3-vmin3)/vmin3;
end
   
if vmin4 < 50 | vmax4<50 | vmax4 == vmin4
     sr4 = 0;
else
     sr4 = 10*(vmax4-vmin4)/vmin4;
end


% sr1 = sr1;
% sr2 = sr2;
% sr3 = sr3;
% sr4 = sr4;
% sr5 = sr5;
% sr6 = sr6;
% sr7 = sr7;
% sr8 = sr8;