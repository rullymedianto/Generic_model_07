tic
% clear all
% close all
load('NavData_07.mat')
load('NavAIP_07.mat')
load('Label_07.mat')

time= 7200; %
temp1=3;
lat_RADAR = -25118.4; %Koordinat X RADAR
lon_RADAR = -71138.2; %Koordinat Y RADAR
Vw = 5;   % Besar kecepatan angin
tetaw = 210; %sudut arah angin (dari)

separation_length = nm(12);                      %%Manual Input
%Separation_Angle = [270 335 28 432 393 494 250 250 250 250 250 250 250 250 250 250 250]; 
a = 1;                                          %For Platform Looping NavAIP
b = 1; 

Time_Trigger = cell(1,time);
Holding_status = cell(1,time);
Sim2 = cell(1,time);

sa1 = [1 480 960 1440 1920 2400 2880 3360 3840 4320 4800 5280 5760 6240 6720 7200];
sa2 = [40 480 960 1440 1920 2400 2880 3360 3840 4320 4800 5280 5760 6240 6720 7200];
sa3 = [1 480 960 1440 1920 2400 2880 3360 3840 4320 4800 5280 5760 6240 6720 7200];
sa4 = [1 480 960 1440 1920 2400 2880 3360 3840 4320 4800 5280 5760 6240 6720 7200];
% %Runway 07R	
% sa1 = [1 240 480 720 960 1200 1440 1680 1920 2160 2400 2640 2880 3120 3360 3600 3840 4080 4320 4560 4800 5040 5280 5520 5760 6000 6240 6480 6720 6960 7200]; % TKG	
% %sa2(:,randi([1,10]))=[];	
% sa2 = [40 240 480 720 960 1200 1440 1680 1920 2160 2400 2640 2880 3120 3360 3600 3840 4080 4320 4560 4800 5040 5280 5520 5760 6000 6240 6480 6720 6960 7200]; %BUNIK	
% %sa3(:,randi([1,10]))=[];	
% sa3 = [1 240 480 720 960 1200 1440 1680 1920 2160 2400 2640 2880 3120 3360 3600 3840 4080 4320 4560 4800 5040 5280 5520 5760 6000 6240 6480 6720 6960 7200]; % AMBOY	
% %sa4(:,randi([1,10]))=[];
% 
% %Runway 07L	
% sa1 = [1 360 720 1080 1440 1800 2160 2520 2880 3240 3600 3960 4320 4680 5040 5400 5760 6120 6480 6840 7200]; % GAPRI	
% %sa1(:,randi([1,10]))=[];	
	
% %Runway 07R	
% sa1 = [1 480 1200 1680  2880 4320 4800 5280 6240 7200]; % TKG	
% %sa2(:,randi([1,10]))=[];	
% sa2 = [40 480 720 1920 2400 3360 4320 5280 6240 6720 7200]; %BUNIK	
% %sa3(:,randi([1,10]))=[];	
% sa3 = [1 720 1200 1920 2400 2880 3360 4320 5280  6240]; % AMBOY	
% %sa4(:,randi([1,10]))=[];	

%% Schedule Departure %%
%Runway 07L
% sa5  =[1 840]; % TULIP 2A
% sa6 = [1680 2520]; % DOLTA 2A 
% sa7 = [3360]; % ABASA 2A
% sa8 = [4200]; % LEPAS
% sa9 = [5040 5880]; % MUTIA
% sa10 = [6720]; % PW
% 
% %Runway 07R
% sa11 = [1 840]; % TULIP 2B
% sa12 = [1680]; % DOLTA 2B
% sa13 = [2520 3360]; % ABASA 2B
% sa14 = [4200 5040]; % LEPAS
% sa15 = [5880 6720]; % PW

%jadwal = cell(1,temp1)
jadwal = {sa1 sa2 sa3};

[m1,n1]= size(sa1);
[m2,n2]= size(sa2);
[m3,n3]= size(sa3);
% [m4,n4]= size(sa4);
% [m5,n5]= size(sa5);
% [m6,n6]= size(sa6);
% [m7,n7]= size(sa7);
% [m8,n8]= size(sa8);
% [m9,n9]= size(sa9);
% [m10,n10]= size(sa10);
% [m11,n11]= size(sa11);
% [m12,n12]= size(sa12);
% [m13,n13]= size(sa13);
% [m14,n14]= size(sa14);
% [m15,n15]= size(sa15);

airplane_input = [n1 n2 n3]; 
airplane = sum(airplane_input);

% LLD = n1 ;
RLD = n1+n2+n3;

% LD = LLD+RLD;

% LTOFF = n5+n6+n7+n8+n9+n10;
% RTOFF = n11+n12+n13+n14+n15;

Jumlah_AC = RLD
sched=zeros(time,airplane);
ruteno=zeros(1,airplane);
typeac = zeros(1,airplane);
InitialPos = zeros(3,airplane);
InitialROW = zeros(2,airplane);


%% Number of Entry Point
for i = 1:temp1
NavAIP{2,i}(1,1) = airplane_input(1,i);
end
Route = cell(1,airplane);

for h=1:temp1
    if h==1 
    takum(1,h)= airplane_input(1,h);
    else
        takum(1,h)= takum(1,h-1)+ airplane_input(1,h);
    end
end

for i = 1:time
    for k = 1:n1
    if i == sa1(1,k)
        sched(i,k) = 1;
        % sched(i,takum(1,1)+k) = 1;
    end
    ruteno(1,k) = 1;
    typeac(1,k)= aircraft_type();
    end
end

for i = 1:time
    for k = 1:n2
    if i == sa2(1,k)
        sched(i,takum(1,1)+k) = 1;
    end
    ruteno(1,takum(1,1)+k) = 2;
    typeac(1,takum(1,1)+k)= aircraft_type();
    end
end
        
for i = 1:time
    for k = 1:n3
    if i == sa3(1,k)
        sched(i,takum(1,2)+k) = 1;
    end
    ruteno(1,takum(1,2)+k) = 3;
    typeac(1,takum(1,2)+k)= aircraft_type();
    end
end
% 
% for i = 1:time
%     for k = 1:n4
%     if i == sa4(1,k)
%         sched(i,takum(1,3)+k) = 1;
%     end
%     ruteno(1,takum(1,3)+k) = 4;
%     typeac(1,takum(1,3)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n5
%     if i == sa5(1,k)
%         sched(i,takum(1,4)+k) = 1;
%     end
%     ruteno(1,takum(1,4)+k) = 5;
%     typeac(1,takum(1,4)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n6
%     if i == sa6(1,k)
%         sched(i,takum(1,5)+k) = 1;
%     end
%     ruteno(i,takum(1,5)+k) = 6;
%     typeac(i,takum(1,5)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n7
%     if i == sa7(1,k)
%         sched(i,takum(1,6)+k) = 1;
%     end
%     ruteno(i,takum(1,6)+k) = 7;
%     typeac(i,takum(1,6)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n8
%     if i == sa8(1,k)
%         sched(i,takum(1,7)+k) = 1;
%     end
%     ruteno(i,takum(1,7)+k) = 8;
%     typeac(i,takum(1,7)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n9
%     if i == sa9(1,k)
%         sched(i,takum(1,8)+k) = 1;
%     end
%     ruteno(i,takum(1,8)+k) = 9;
%     typeac(i,takum(1,8)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n10
%     if i == sa10(1,k)
%         sched(i,takum(1,9)+k) = 1;
%     end
%     ruteno(i,takum(1,9)+k) = 10;
%     typeac(i,takum(1,9)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n11
%     if i == sa11(1,k)
%         sched(i,takum(1,10)+k) = 1;
%     end
%     ruteno(i,takum(1,10)+k) = 11;
%     typeac(i,takum(1,10)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n12
%     if i == sa12(1,k)
%         sched(i,takum(1,11)+k) = 1;
%     end
%     ruteno(i,takum(1,11)+k) = 12;
%     typeac(i,takum(1,11)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n13
%     if i == sa13(1,k)
%         sched(i,takum(1,12)+k) = 1;
%     end
%     ruteno(i,takum(1,12)+k) = 13;
%     typeac(i,takum(1,12)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n14
%     if i == sa14(1,k)
%         sched(i,takum(1,13)+k) = 1;
%     end
%     ruteno(i,takum(1,13)+k) = 14;
%     typeac(i,takum(1,13)+k)= aircraft_type();
%     end
% end
% 
% for i = 1:time
%     for k = 1:n15
%     if i == sa15(1,k)
%         sched(i,takum(1,14)+k) = 1;
%     end
%     ruteno(i,takum(1,14)+k) = 15;
%     typeac(i,takum(1,14)+k)= aircraft_type();
%     end
% end

% %% Airplane Route
for i = 1:airplane
    
    c = NumberWaypoint(NavAIP{1,a}(:,1)); % Check Number of Row
    
    for j = 1:c
        m = typeac(1,i);
        
        Route{1,i}(j,1) = NavData(NavAIP{1,a}(j,1),1);      % X
        Route{1,i}(j,2) = NavData(NavAIP{1,a}(j,1),2);      % Y
        Route{1,i}(j,3) = NavData(NavAIP{1,a}(j,1),2+m);    % Z(Altitude) 
        Route{1,i}(j,4) = NavData(NavAIP{1,a}(j,1),7+m);    % Lateral Speed 
        Route{1,i}(j,5) = NavData(NavAIP{1,a}(j,1),12+m);   % Vertical Speed
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        if b == NavAIP{2,a}(1,1)
                            a = a+1;
                            b = 1;
                        elseif a+1>temp1
                            a = temp1;
                            b = b+1;
                        else
                            a = a;
                            b = b + 1;
                        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
end

    InitialPos(1,1) = Route{1,1}(1,1);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*sind(Separation_Angle(1,1)); %X    
    InitialPos(2,1) = Route{1,1}(1,2);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,1)); %Y
    InitialPos(3,1) = Route{1,1}(1,3); %Altitude;
    
    for i=2:n1
    InitialPos(1,i) = InitialPos(1,i-1);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*sind(Separation_Angle(1,1)); %X    
    InitialPos(2,i) = InitialPos(2,i-1);%+ (separation_length + (nm(30)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,1)); %Y
    InitialPos(3,i) = InitialPos(3,i-1); %Altitude;
    end
    
    for k=1:(temp1-1)
        
    InitialPos(1,takum(1,k)+1) = Route{1,takum(1,k)+1}(1,1);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*sind(Separation_Angle(1,k+1)); %X
    InitialPos(2,takum(1,k)+1) = Route{1,takum(1,k)+1}(1,2);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,k+1)); %Y
    InitialPos(3,takum(1,k)+1) = Route{1,takum(1,k)+1}(1,3); %Altitude;
    
    for i=2:airplane_input(1,k+1)
    
    InitialPos(1,takum(1,k)+i) = InitialPos(1,takum(1,k)+i-1);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*sind(Separation_Angle(1,k+1)); %X    
    InitialPos(2,takum(1,k)+i) = InitialPos(2,takum(1,k)+i-1);%+ (separation_length + (nm(2)-separation_length)*rand(1,1))*cosd(Separation_Angle(1,k+1)); %Y
    InitialPos(3,takum(1,k)+i) = InitialPos(3,takum(1,k)+i-1); %Altitude;
    end
    end
    
       %% Initial ROW
a = 1;
b = 1;
for i=1:airplane
    
    InitialROW(1,i) = i;
    InitialROW(2,i) = b;

    
                        if b == NavAIP{2,a}(1,1)
                            a = a+1;
                            b = 1;
                        elseif a+1>temp1
                            a = temp1;
                            b = b+1;
                        else
                            a = a;
                            b = b + 1;
                        end
    
end
    
%% Aircraft Data t = 0
a = 1;
b = 1;

for i = 1:airplane
Time_Trigger{1,1}(1,i) = 0;
Holding_status{1,1}(1,i) = 0;

 Sim1{1,1}(1,i) = 1 ; 

if sched(1,i)==1
                                    %Num Waypoint = [1 2 3 4 5 ....]
   
    Sim1{1,1}(2,i) = InitialPos(1,i);                    %X
    Sim1{1,1}(3,i) = InitialPos(2,i);                    %Y
    Sim1{1,1}(4,i) = InitialPos(3,i);                    %Z

else
    Sim1{1,1}(2,i) = 9.0e+7;                    %X
    Sim1{1,1}(3,i) = 9.0e+7;                    %Y
    Sim1{1,1}(4,i) = 9.0e+7;                    %Z
end
    
    
    Sim1{1,1}(5,i) = Route{1,i}(1,1) - Sim1{1,1}(2,i);    %Delta X
    Sim1{1,1}(6,i) = Route{1,i}(1,2) - Sim1{1,1}(3,i);    %Delta Y
    Sim1{1,1}(7,i) = Route{1,i}(1,3) - Sim1{1,1}(4,i);    %Delta Z

    Sim1{1,1}(8,i) = InitialROW(2,i);                    %ROW
    Sim1{1,1}(9,i) = 1;                                  %Clearance
    Sim1{1,1}(10,i) = 0;                                 %Resolution

    Sim1{1,1}(11,i) = angle(Sim1{1,1}(5,i),Sim1{1,1}(6,i)); %Relative Heading
    Sim1{1,1}(12,i) = Sim1{1,1}(11,i);                     %Heading

    Sim1{1,1}(13,i) = sqrt((Sim1{1,1}(5,i))^2+(Sim1{1,1}(6,i))^2+(Sim1{1,1}(7,i))^2);      %r

    Sim1{1,1}(14,i) = 0;                                              %vz
    Sim1{1,1}(15,i) = Route{1,i}(1,4) * sind(Sim1{1,1}(12,i));        %vx
    Sim1{1,1}(16,i) = Route{1,i}(1,4) * cosd(Sim1{1,1}(12,i));        %vy
    Sim1{1,1}(17,i) = NumberWaypoint(Route{1,i});                     %Total Waypoint
    Sim1{1,1}(18,i) = 0   ;                                           %Aircraft to merging point
    Sim1{1,1}(19,i) = sqrt((Sim1{1,1}(15,i)).^2 + (Sim1{1,1}(16,i)).^2 +(Sim1{1,1}(14,i)).^2) ;  %TAS
    Sim1{1,1}(20,i) = 0;
    Sim1{1,1}(21,i) = Sim1{1,1}(15,i)+ Vw*sind(tetaw+180); %Ground Speed Sumbu x
    Sim1{1,1}(22,i) = Sim1{1,1}(16,i)+ Vw*cosd(tetaw+180); %Ground Speed Sumbu y
    Sim1{1,1}(23,i) = round(sqrt((Sim1{1,1}(21,i))^2 + (Sim1{1,1}(22,i))^2 +(Sim1{1,1}(14,i))^2)); % Ground Speed
    Sim1{1,1}(24,i) = 0;
    
    
    for j= 1:time+1
    Sim2{1,j}(1,i) = ruteno(1,i); %Ruote No.
    Sim2{1,j}(2,i) = typeac(1,i); %Aircraft Type
    end
    
    Sim1{1,1}(25,i) = holding_point(Sim1{1,1}(1,i),Sim2{1,1}(1,i)); %Holding point
    Sim1{1,1}(26,i) = sqrt((lon_RADAR-Sim1{1,1}(2,i))^2 + (lat_RADAR - Sim1{1,1}(3,i))^2); %Radius to RADAR
    Sim1{1,1}(27,i) = Sim2{1,1}(1,i); %Route No.
    Sim1{1,1}(28,i) = Sim2{1,1}(2,i); %Aircraft Type
    Sim1{1,1}(29,i) = 0; % Sector Number
    Sim1{1,1}(30,i) = 0; % Status Conflict
    
                        if b == NavAIP{2,a}(1,1)
                            a = a+1;
                            b = 1;
                        elseif a+1>temp1
                            a = temp1;
                            b = b+1;
                        else
                            a = a;
                            b = b + 1;
                        end
end

save('PlaneGenerator.mat', '-v7.3')
save('Route.mat', 'Route', '-v7.3')

de = rand();
timeElapsed_schedules1 = toc;
Te = timeElapsed_schedules1;