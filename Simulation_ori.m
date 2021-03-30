%% Define Cell
%Simulation Time
%time = 1200;
tic
Sim1 = cell(1,time);
%% Import Data from PlaneGenerator
% close all
load('PlaneGenerator.mat')

lat_RADAR = -25118.4;
lon_RADAR = -71138.2;

global lim_low lim_up lim_vel sen_descent sen_climb 
lim_low = meter(3500);   % lower limit
lim_up = meter(15000);  % upper limit
lim_vel = 82;           % limit lower velocity
sen_descent = 7;        % sensitivitas sensor to desc  ent
sen_climb = 0.7;        % sensitivitas sensor to climb
t=time;
d=2;
tol_max = 0.5;
tol_min = -0.5;

%% Global Variable    
%% INPUT DESIRE SEPARATION
buffer_zone_1 = nm(15); %Above 10.000 ft
buffer_zone_2 = nm(8); %Below 10.000 ft
conflict_separation_1 = nm(5); % LOS above 10.000 ft
conflict_separation_2 = nm(3); % LOS below 10.000 ft

%Airplane-Airplane Distance cell
Distance_XY = cell(1,time);
Distance_Altitude = cell(1,time);

%rate of descent/climb
rate_descent = mpersec(1300);
rate_climb   = mpersec(800);

%Conflict Cell
Conflict = cell(1,time);
Conflict_0 = cell(1,time);
Conflict_1 = cell(1,time);
Conflict_2 = cell(1,time);
ROW = cell(1,time);
ROW_Detail = cell(1,time);
ROW_Airplane = cell(1,time);
Time_stamp = zeros(13,airplane);
Distance_XY_Plot = cell(1,time);
Separation_Minimum = zeros(1,time);

%Speed_control
speed_changes = 0.5;
deviation_angle = 15;

%%  Simulation
for i = 1:time
    
%Conflict Definition and Detection
    for c1 = 1:airplane
            for c2 = 1:airplane
                %Aircraft-Aircraft Distance_XY
                if c1 == c2
                    Distance_XY{1,i}(c1,c2) = 0;
                else
                    Distance_XY{1,i}(c1,c2) = sqrt((Sim1{1,i}(2,c1) - Sim1{1,i}(2,c2)).^2 + (Sim1{1,i}(3,c1) - Sim1{1,i}(3,c2)).^2);
                end
                
 %% For Radius 10NM-75NM
 
 if Sim1{1,i}(4,c1)> meter(10000) && Sim1{1,i}(4,c1)< 6.0e+7  
                %Aircraft-Aircraft Distance-Altitude
                if c1 == c2
                    Distance_Altitude{1,i}(c1,c2) = 0;
                else
                    Distance_Altitude{1,i}(c1,c2) = sqrt((Sim1{1,i}(4,c1) - Sim1{1,i}(4,c2)).^2);
                end
                
 %% Potential Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < buffer_zone_1 && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(2000)
                    Conflict{1,i}(c1,c2) = 1;
                else
                    Conflict{1,i}(c1,c2) = 0;
                end
                
%% Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < conflict_separation_1  && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(1000)
                    Conflict_0{1,i}(c1,c2) = 1;
                else
                    Conflict_0{1,i}(c1,c2) = 0;
                end
         
       %% For Radius 10NM
       else 
                %Aircraft-Aircraft Distance-Altitude
                if c1 == c2
                    Distance_Altitude{1,i}(c1,c2) = 0;
                else
                    Distance_Altitude{1,i}(c1,c2) = sqrt((Sim1{1,i}(4,c1) - Sim1{1,i}(4,c2)).^2);
                end
                
                %Potential Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < buffer_zone_2 && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(2000)
                    Conflict{1,i}(c1,c2) = 1;
                else
                    Conflict{1,i}(c1,c2) = 0;
                end
                  
% % Conflict Definition              
                if Distance_XY{1,i}(c1,c2) < conflict_separation_2  && Distance_XY{1,i}(c1,c2) ~= 0 && Distance_Altitude{1,i}(c1,c2) <= meter(1000)
                    Conflict_0{1,i}(c1,c2) = 1;
                else
                    Conflict_0{1,i}(c1,c2) = 0;
                end
                
end
            end
    end
            
%Conflict Colour
    for j = 1:airplane
        if mean(Conflict{1,i}(:,j)) > 0 %&& mean(Conflict{1,i}(:,j)) > 0
        Conflict_1{1,i}(1,j) = 1;
%         elseif mean(Conflict_0{1,i}(:,j)) <= 0 && mean(Conflict{1,i}(:,j)) > 0  
%         Conflict_1{1,i}(1,j) = 2;
        else
        Conflict_1{1,i}(1,j) = 0;  
        end
    
        if Conflict_1{1,i}(1,j) == 1 && Conflict_0{1,i}(1,j) == 1
            Conflict_2{1,i}(j,:) = [1 0 0];
        elseif Conflict_1{1,i}(1,j) == 1 && Conflict_0{1,i}(1,j) == 0
            Conflict_2{1,i}(j,:) = [1 1 0];
        else
            Conflict_2{1,i}(j,:) = [0 1 0];
        end
    end

%ROW Definition
    for j = 1:airplane
 
        ROW{1,i}(1,j)= j;
        ROW{1,i}(2,j)= Route{1,j}(Sim1{1,i}(1,j),1);
        ROW{1,i}(3,j)= Route{1,j}(Sim1{1,i}(1,j),2);
        ROW{1,i}(4,j)= Sim1{1,i}(13,j);  
    end

%ROW Airplane
    for j = 1:airplane
        ROW_Detail{1,i} = Queueing(ROW{1,i},airplane);
        ROW_Airplane{1,i}(1,:) = ROW_Detail{1,i}(1,:);
        ROW_Airplane{1,i}(2,:) = ROW_Detail{1,i}(5,:);
        ROW_Airplane{1,i} = sortrows(ROW_Airplane{1,i}',1)';
    end
    for c1 = 1:airplane
        for c2 = 1:airplane
            if c1 == c2
            Distance_XY_Plot{1,i}(c1,c2) = 1000000;
            else
                Distance_XY_Plot{1,i}(c1,c2) = Distance_XY{1,i}(c1,c2);
            end
        end
    end

%Separation Minimum
Separation_Minimum(1,i) = min(min(Distance_XY_Plot{1,i}(:,:)));

% %Capacity
CapacityArray{1,1}(1,1) = 0;
CapacityArray{1,1}(1,i+1) = capacity(Sim1{1,i},airplane);

for j = 1:airplane
%for k = 1:LD
    
%===========================NEXT WAYPOINT==================================
wptnext = 2500; %% Distance when change to next waypoint 

if  Sim1{1,i}(13,j) < wptnext && Sim1{1,i}(1,j) ~= Sim1{1,i}(17,j) 
        Sim1{1,i+1}(1,j) = Sim1{1,i}(1,j) + 1;
    else 
        Sim1{1,i+1}(1,j) = Sim1{1,i}(1,j);
end

% POSITION     
    if sched(i,j)==1
        Sim1{1,i+1}(2,j) = InitialPos(1,j);                    %X
        Sim1{1,i+1}(3,j) = InitialPos(2,j);                    %Y
        Sim1{1,i+1}(4,j) = InitialPos(3,j);                    %Z  
        
    elseif Sim1{1,i}(1,j) == Sim1{1,i}(17,j) 
        
        Sim1{1,i+1}(2,j) = 9.0e+7;                     %X
        Sim1{1,i+1}(3,j) = 9.0e+7;                     %Y
        Sim1{1,i+1}(4,j) = 9.0e+7;                      %Z 
    
    else   
        Sim1{1,i+1}(2,j) = Sim1{1,i}(2,j) + Sim1{1,i}(21,j);                     %X
        Sim1{1,i+1}(3,j) = Sim1{1,i}(3,j) + Sim1{1,i}(22,j);                     %Y
            
        if Sim1{1,i}(1,j) < Sim1{1,i}(17,j)
            
            if  Sim1{1,i}(13,j) < wptnext
                Sim1{1,i+1}(4,j) = Route{1,j}(Sim1{1,i}(1,j)+1,3);   
              else
                Sim1{1,i+1}(4,j) = Sim1{1,i}(4,j) + Sim1{1,i}(14,j);              %Z
            end
        
        else
            
            if  Sim1{1,i}(13,j) < wptnext
                Sim1{1,i+1}(4,j) = Route{1,j}(Sim1{1,i+1}(1,j),3);   
              else
                Sim1{1,i+1}(4,j) = Sim1{1,i}(4,j) + Sim1{1,i}(14,j);              %Z
            end  
            
        end 
    end
                  
        Sim1{1,i+1}(5,j) = Route{1,j}(Sim1{1,i+1}(1,j),1) - Sim1{1,i+1}(2,j);    %Delta x
        Sim1{1,i+1}(6,j) = Route{1,j}(Sim1{1,i+1}(1,j),2) - Sim1{1,i+1}(3,j);    %Delta y
        Sim1{1,i+1}(7,j) = Route{1,j}(Sim1{1,i+1}(1,j),3) - Sim1{1,i+1}(4,j);    %Delta z

%ROW
        Sim1{1,i+1}(8,j) = ROW_Airplane{1,i}(2,j); 
        % ROW : Number (1,2,3,...., n)
%Clearance 

if Sim1{1,i}(19,j)==0
    Sim1{1,i+1}(9,j) = 1;
else
Sim1{1,i+1}(9,j) = clearance(ROW_Detail{1,i},Conflict_1{1,i},airplane,j,Distance_XY{1,i},buffer_zone_1,buffer_zone_2,Sim1{1,i+1}(4,j),Holding_status{1,i}(1,j));
        % 0 : No clearance
        % 1 : Clearance
end
%Resolution (10)
[Sim1{1,i+1}(10,j),Time_Trigger{1,i+1}(1,j)] = resolution(Sim1{1,i+1}(9,j),Sim1{1,i}(10,j),i,Time_Trigger{1,i}(1,j));
Holding_status{1,i+1}(1,j) = 0;

% Distance Measure    
Sim1{1,i+1}(13,j) = sqrt((Sim1{1,i+1}(5,j))^2+(Sim1{1,i+1}(6,j))^2+(Sim1{1,i+1}(7,j))^2);

% Total Waypoint        
        Sim1{1,i+1}(17,j) = Sim1{1,1}(17,j);

    %% Coba Cek       
        if i+d > t+1
    d=1;
else
    d=d;
end

if i==1
    d=1;
else
    d=d;
end

     if Sim1{1,i+1}(10,j) == 0
%% No Conflict & No Resolution 

% Heading & Relative Heading
        Sim1{1,i+1}(11,j) = angle(Sim1{1,i+1}(5,j),Sim1{1,i+1}(6,j)); %Relative Airplane-Waypoint Course
        if Sim1{1,i}(1,j) == Sim1{1,i}(17,j)
            Sim1{1,i+1}(12,j) = Sim1{1,i}(12,j);
        else
        Sim1{1,i+1}(12,j) = Sim1{1,i+1}(11,j);
        end
        %Airplane Heading
      
% Velocity XYZ (Air Speed)
if Sim1{1,i+1}(1,j) < Sim1{1,i+1}(17,j)
   Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j)+1,3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz      
else
%   Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j),3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz end
    Sim1{1,i+1}(14,j) = Sim1{1,i}(14,j);
end

    if Sim1{1,i+1}(1,j) < Sim1{1,i+1}(17,j)
        [Sim1{1,i+1}(15,j), Sim1{1,i+1}(16,j)] = xyspeed2( Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j)+1,4)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j));        
    else
        [Sim1{1,i+1}(15,j), Sim1{1,i+1}(16,j)] = xyspeed2( Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j));   
    end
    
% Vtotal
 Sim1{1,i+1}(19,j) = round(sqrt((Sim1{1,i+1}(15,j))^2 + (Sim1{1,i+1}(16,j))^2 +(Sim1{1,i+1}(14,j))^2));  
              
% Merging Point
if Sim1{1,i+1}(1,j) == 3 || Sim1{1,i+1}(1,j) ==  9 || Sim1{1,i+1}(1,j) ==  5 || Sim1{1,i+1}(1,j) ==  8 ...
        Sim1{1,i+1}(1,j) ==  22 || Sim1{1,i+1}(1,j) ==  21 || Sim1{1,i+1}(1,j) ==  17;
Sim1{1,i+1}(18,j) = 1;
else
  Sim1{1,i+1}(18,j) = 0;
end

if i+d > t+1
    d=1;
else
    d=d;
end

if i==1
    d=1;
else
    d=d;
end

if  Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)> tol_min && Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)< tol_max
    Sim1{1,i+1}(20,j) = 0; %Cruising
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)>tol_max
    Sim1{1,i+1}(20,j) = 1; %Climbing
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)<tol_min
    Sim1{1,i+1}(20,j) = -1; %Descent
end

Sim1{1,i+1}(21,j) = Sim1{1,i+1}(15,j)+ Vw*sind(tetaw+180);
Sim1{1,i+1}(22,j) = Sim1{1,i+1}(16,j)+ Vw*cosd(tetaw+180);
Sim1{1,i+1}(23,j) = round(sqrt((Sim1{1,i+1}(21,j))^2 + (Sim1{1,i+1}(22,j))^2 +(Sim1{1,i+1}(14,j))^2));

     elseif Sim1{1,i+1}(10,j) == 1
%% Altitude Resolution

% Heading & Relative Heading
        Sim1{1,i+1}(11,j) = angle(Sim1{1,i+1}(5,j),Sim1{1,i+1}(6,j)); %Relative Airplane-Waypoint Course
        Sim1{1,i+1}(12,j) = Sim1{1,i+1}(11,j);   %Airplane Heading
      
% Distance Measure        
        Sim1{1,i+1}(13,j) = sqrt((Sim1{1,i+1}(5,j))^2+(Sim1{1,i+1}(6,j))^2+(Sim1{1,i+1}(7,j))^2);

% Velocity XYZ
if Sim1{1,i+1}(1,j) < Sim1{1,i+1}(17,j)        
    Sim1{1,i+1}(14,j) = zspeedchanges(Sim1{1,i+1}(4,j), Route{1,j}(Sim1{1,i+1}(1,j)+1,3),rate_climb, rate_descent);  %Vz
else
    Sim1{1,i+1}(14,j) = Sim1{1,i}(14,j);
end 
        Sim1{1,i+1}(15,j) = xspeed(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(12,j));
        Sim1{1,i+1}(16,j) = yspeed(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(12,j));
        
% Vtotal
        Sim1{1,i+1}(19,j) = round(sqrt((Sim1{1,i+1}(15,j))^2 + (Sim1{1,i+1}(16,j))^2+(Sim1{1,i+1}(14,j))^2));

% Total Waypoint        
        Sim1{1,i+1}(17,j) = Sim1{1,1}(17,j);    
        
% Merging Point
if Sim1{1,i+1}(1,j) ==  3 || Sim1{1,i+1}(1,j) ==  9 || Sim1{1,i+1}(1,j) ==  5 || Sim1{1,i+1}(1,j) ==  8 ...
        Sim1{1,i+1}(1,j) ==  22 || Sim1{1,i+1}(1,j) ==  21 || Sim1{1,i+1}(1,j) ==  17;
Sim1{1,i+1}(18,j) = 1;
else
  Sim1{1,i+1}(18,j) = 0;
end

if Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)> tol_min && Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)< tol_max
    Sim1{1,i+1}(20,j) = 0; %Cruising
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)>tol_max
    Sim1{1,i+1}(20,j) = 1; %Climbing
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)<tol_min
    Sim1{1,i+1}(20,j) = -1; %Descent
end

Sim1{1,i+1}(21,j) = Sim1{1,i+1}(15,j)+ Vw*sind(tetaw+180);
Sim1{1,i+1}(22,j) = Sim1{1,i+1}(16,j)+ Vw*cosd(tetaw+180);
Sim1{1,i+1}(23,j) = round(sqrt((Sim1{1,i+1}(21,j))^2 + (Sim1{1,i+1}(22,j))^2 +(Sim1{1,i+1}(14,j))^2));

     elseif Sim1{1,i+1}(10,j) == 2
%% Vectoring Resolution
        % Heading & Relative Heading
                Sim1{1,i+1}(11,j) = angle(Sim1{1,i+1}(5,j),Sim1{1,i+1}(6,j)); %Relative Airplane-Waypoint Course
        if Sim1{1,1}(11,j) <= 180
                Sim1{1,i+1}(12,j) = Sim1{1,1}(11,j) + deviation_angle;   %Airplane Heading
        else
                Sim1{1,i+1}(12,j) = Sim1{1,1}(11,j) - deviation_angle;
        end
% Distance Measure        
                Sim1{1,i+1}(13,j) = sqrt((Sim1{1,i+1}(5,j))^2+(Sim1{1,i+1}(6,j))^2+(Sim1{1,i+1}(7,j))^2);

% Velocity XYZ
if Sim1{1,i+1}(1,j) < Sim1{1,i+1}(17,j)
   Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j)+1,3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz      
   else
   Sim1{1,i+1}(14,j) = Sim1{1,i}(14,j);
end
                Sim1{1,i+1}(15,j) = xspeed(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(12,j));
                Sim1{1,i+1}(16,j) = yspeed(Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i+1}(12,j));
                
% Vtotal
        Sim1{1,i+1}(19,j) = round(sqrt((Sim1{1,i+1}(15,j))^2 + (Sim1{1,i+1}(16,j))^2+(Sim1{1,i+1}(14,j))^2));
% Total Waypoint        
        Sim1{1,i+1}(17,j) = Sim1{1,1}(17,j);   
        
 % Merging Point
if Sim1{1,i+1}(1,j) ==  3 || Sim1{1,i+1}(1,j) ==  9 || Sim1{1,i+1}(1,j) ==  5 || Sim1{1,i+1}(1,j) ==  8 ...
        Sim1{1,i+1}(1,j) ==  22 || Sim1{1,i+1}(1,j) ==  21 || Sim1{1,i+1}(1,j) ==  17;
Sim1{1,i+1}(18,j) = 1;
else
  Sim1{1,i+1}(18,j) = 0;
end

if i+d > t+1
    d=1;
else
    d=d;
end

if i==1
    d=1;
else
    d=d;
end

if Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)> tol_min && Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)< tol_max
    Sim1{1,i+1}(20,j) = 0; %Cruising
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)>tol_max
    Sim1{1,i+1}(20,j) = 1; %Climbing
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)<tol_min
    Sim1{1,i+1}(20,j) = -1; %Descent
end

Sim1{1,i+1}(21,j) = Sim1{1,i+1}(15,j)+ Vw*sind(tetaw+180);
Sim1{1,i+1}(22,j) = Sim1{1,i+1}(16,j)+ Vw*cosd(tetaw+180);
Sim1{1,i+1}(23,j) = round(sqrt((Sim1{1,i+1}(21,j))^2 + (Sim1{1,i+1}(22,j))^2 +(Sim1{1,i+1}(14,j))^2));

     elseif Sim1{1,i+1}(10,j) == 3
%% Speed Resolution

        Sim1{1,i+1}(11,j) = angle(Sim1{1,i+1}(5,j),Sim1{1,i+1}(6,j)); %Relative Airplane-Waypoint Course
        if Sim1{1,i}(1,j) == Sim1{1,i}(17,j)
            Sim1{1,i+1}(12,j) = Sim1{1,i}(12,j);
        else
        Sim1{1,i+1}(12,j) = Sim1{1,i+1}(11,j);
        end
% Distance Measure        
                Sim1{1,i+1}(13,j) = sqrt((Sim1{1,i+1}(5,j))^2+(Sim1{1,i+1}(6,j))^2+(Sim1{1,i+1}(7,j))^2);
% Total Waypoint        
    Sim1{1,i+1}(17,j) = Sim1{1,1}(17,j);  
    
%Velocity XYZ

if Sim1{1,i+1}(1,j) < Sim1{1,i}(17,j)
    Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j)+1,3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz      
else
    Sim1{1,i+1}(14,j) = Sim1{1,i}(14,j);  %Vz end
end               

%Sim1{1,i+1}(14,j) = zspeed(Sim1{1,i+1}(4,j),Route{1,j}(Sim1{1,i+1}(1,j),3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)));  %Vz
   
                
     if  Sim1{1,i}(19,j)== 0
       Sim1{1,i+1}(15,j)= 0;
       Sim1{1,i+1}(16,j)= 0;
   else
if Sim1{1,i+1}(1,j) < Sim1{1,i+1}(17,j)
        
        [Sim1{1,i+1}(15,j) Sim1{1,i+1}(16,j)] = speed_changes2( Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j)+1,4)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j),Sim1{1,i+1}(8,j));
         
else
         [Sim1{1,i+1}(15,j) Sim1{1,i+1}(16,j)] = speed_changes2( Sim1{1,i+1}(14,j),mps(Route{1,j}(Sim1{1,i+1}(1,j),4)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j),Sim1{1,i+1}(8,j));
         
 end
   end            
% Velocity XYZ
%                 [Sim1{1,i+1}(14,j),Sim1{1,i+1}(15,j),Sim1{1,i+1}(16,j)] = speedchanges(Sim1{1,i+1}(4,j), Route{1,j}(Sim1{1,i+1}(1,j),3),mpersec(Route{1,j}(Sim1{1,i+1}(1,j),5)),Sim1{1,i}(19,j),Sim1{1,i+1}(12,j),speed_changes);

% Vtotal
        Sim1{1,i+1}(19,j) = round(sqrt((Sim1{1,i+1}(15,j))^2 + (Sim1{1,i+1}(16,j))^2 +(Sim1{1,i+1}(14,j))^2));
              
 % Merging Point
if Sim1{1,i+1}(1,j) ==  3 || Sim1{1,i+1}(1,j) ==  9 || Sim1{1,i+1}(1,j) ==  5 || Sim1{1,i+1}(1,j) ==  8 ...
        Sim1{1,i+1}(1,j) ==  22 || Sim1{1,i+1}(1,j) ==  21 || Sim1{1,i+1}(1,j) ==  17;
Sim1{1,i+1}(18,j) = 1;
else
  Sim1{1,i+1}(18,j) = 0;
end

if Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)> tol_min && Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)< tol_max
    Sim1{1,i+1}(20,j) = 0; %Cruising
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)>tol_max
    Sim1{1,i+1}(20,j) = 1; %Climbing
elseif Sim1{1,i+d}(4,j)- Sim1{1,i}(4,j)<tol_min
    Sim1{1,i+1}(20,j) = -1; %Descent
end
   
Sim1{1,i+1}(21,j) = Sim1{1,i+1}(15,j)+ Vw*sind(tetaw+180);
Sim1{1,i+1}(22,j) = Sim1{1,i+1}(16,j)+ Vw*cosd(tetaw+180);
Sim1{1,i+1}(23,j) = round(sqrt((Sim1{1,i+1}(21,j))^2 + (Sim1{1,i+1}(22,j))^2 +(Sim1{1,i+1}(14,j))^2));

     end

if Sim1{1,i+1}(2,j) > 9000000
    Sim1{1,i+1}(19,j)= 0;
  end   
 Sim1{1,i+1}(24,j)= LOS(ROW_Detail{1,i},Conflict_1{1,i},airplane,j,Distance_XY{1,i},conflict_separation_1,conflict_separation_2,Sim1{1,i+1}(4,j)); % Lost of Separation
            % 0 : No LOS
            % 1 : LOS
 
   Sim1{1,i+1}(25,j)= holding_point(Sim1{1,i+1}(1,j),Sim2{1,i+1}(1,j));
   Sim1{1,i+1}(26,j)= sqrt((lon_RADAR-Sim1{1,i+1}(2,j))^2 + (lat_RADAR - Sim1{1,i+1}(3,j))^2); %Radius dari Radar
   Sim1{1,i+1}(27,j) = Sim1{1,i}(27,j) ;
   Sim1{1,i+1}(28,j) = Sim1{1,i}(28,j);

   if Time_stamp(1,j) == 0
       if Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(15000) & Sim1{1,i+1}(4,j) < meter(24500) & Sim1{1,i+1}(26,j) > nm(75) & Sim1{1,i+1}(26,j) < nm(150) & (Sim1{1,i+1}(27,j) == 2 | Sim1{1,i+1}(27,j) == 3 | Sim1{1,i+1}(27,j) == 1 | Sim1{1,i+1}(27,j) == 12) ; % Lower North (LN)
           Time_stamp(1,j) = i+1;
       else
           Time_stamp(1,j) = 0;
       end
   else
       Time_stamp(1,j) = Time_stamp(1,j);
   end
       
   if Time_stamp(2,j) == 0
       if Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(15000) & Sim1{1,i+1}(4,j) < meter(24500) & Sim1{1,i+1}(26,j) > nm(75) & Sim1{1,i+1}(26,j) < nm(150) & (Sim1{1,i+1}(27,j) == 4 | Sim1{1,i+1}(27,j) == 7 | Sim1{1,i+1}(27,j) == 8 | Sim1{1,i+1}(27,j) == 13 | Sim1{1,i+1}(27,j) == 14); % Lower Centre (LC)
           Time_stamp(2,j) = i+1;
       else
           Time_stamp(2,j) = 0;
       end
   else
       Time_stamp(2,j) = Time_stamp(2,j);
   end        
   
   if Time_stamp(3,j) == 0
       if Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(15000) & Sim1{1,i+1}(4,j) < meter(24500) & Sim1{1,i+1}(26,j) > nm(75) & Sim1{1,i+1}(26,j) < nm(150) & (Sim1{1,i+1}(27,j) == 1 | Sim1{1,i+1}(27,j) == 9 | Sim1{1,i+1}(27,j) == 10 | Sim1{1,i+1}(27,j) == 15); % Lower East (LE)
           Time_stamp(3,j) = i+1;
       else
           Time_stamp(3,j) = 0;
       end
   else
       Time_stamp(3,j) = Time_stamp(3,j);
   end
   
   if Time_stamp(4,j) == 0
       if Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(6000) & Sim1{1,i+1}(4,j) < meter(15000) & Sim1{1,i+1}(26,j) > nm(30) & Sim1{1,i+1}(26,j) < nm(75) & (Sim1{1,i+1}(27,j) == 2 | Sim1{1,i+1}(27,j) == 3 | Sim1{1,i+1}(27,j) == 4 | Sim1{1,i+1}(27,j) == 5 | Sim1{1,i+1}(27,j) == 6 | Sim1{1,i+1}(27,j) == 11 | Sim1{1,i+1}(27,j) == 12) ; % Terminal West (TW)
           Time_stamp(4,j) = i+1;
       else
           Time_stamp(4,j) = 0;
       end
   else
       Time_stamp(4,j) = Time_stamp(4,j);
   end
 
   if Time_stamp(5,j) == 0
       if Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(6000) & Sim1{1,i+1}(4,j) < meter(15000) & Sim1{1,i+1}(26,j) > nm(30) & Sim1{1,i+1}(26,j) < nm(75) & (Sim1{1,i+1}(27,j) == 1 | Sim1{1,i+1}(27,j) == 7 | Sim1{1,i+1}(27,j) == 8 | Sim1{1,i+1}(27,j) == 13 | Sim1{1,i+1}(27,j) == 14); % Terminal East (TE)
           Time_stamp(5,j) = i+1;
       else
           Time_stamp(5,j) = 0;
       end
   else
       Time_stamp(5,j) = Time_stamp(5,j);
   end
       
   if Time_stamp(6,j) == 0
       if Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(6000) & Sim1{1,i+1}(4,j) < meter(15000) & Sim1{1,i+1}(26,j) > nm(30) & Sim1{1,i+1}(26,j) < nm(75) & (Sim1{1,i+1}(27,j) == 9 | Sim1{1,i+1}(27,j) == 10 | Sim1{1,i+1}(27,j) == 15); % Terminal South (TS)
           Time_stamp(6,j) = i+1;
       else
           Time_stamp(6,j) = 0;
       end
   else
       Time_stamp(6,j) = Time_stamp(6,j);
   end        
   
   if Time_stamp(7,j) == 0
       if Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(2500) & Sim1{1,i+1}(4,j) < meter(6000) & Sim1{1,i+1}(26,j) > nm(12) & Sim1{1,i+1}(26,j) < nm(30) & (Sim1{1,i+1}(27,j) == 1 | Sim1{1,i+1}(27,j) == 2 | Sim1{1,i+1}(27,j) == 3 | Sim1{1,i+1}(27,j) == 4 | Sim1{1,i+1}(27,j) == 5 | Sim1{1,i+1}(27,j) == 6 | Sim1{1,i+1}(27,j) == 7 | Sim1{1,i+1}(27,j) == 11 | Sim1{1,i+1}(27,j) == 12 | Sim1{1,i+1}(27,j) == 13); % Arrival North (AN)
           Time_stamp(7,j) = i+1;
       else
           Time_stamp(7,j) = 0;
       end
   else
       Time_stamp(7,j) = Time_stamp(7,j);
   end
   
   if Time_stamp(8,j) == 0
       if Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) > meter(2500) & Sim1{1,i+1}(4,j) < meter(6000) & Sim1{1,i+1}(26,j) > nm(12) & Sim1{1,i+1}(26,j) < nm(30) & (Sim1{1,i+1}(27,j) == 7 || Sim1{1,i+1}(27,j) == 8 || Sim1{1,i+1}(27,j) == 9 || Sim1{1,i+1}(27,j) == 10 || Sim1{1,i+1}(27,j) == 13 || Sim1{1,i+1}(27,j) == 14 || Sim1{1,i+1}(27,j) == 15); % Arrival East (AE)
           Time_stamp(8,j) = i+1;
       else
           Time_stamp(8,j) = 0;
       end
   else
       Time_stamp(8,j) = Time_stamp(8,j);
   end
   
   if Time_stamp(9,j) == 0
       if Sim1{1,i+1}(1,j)>1 & Sim1{1,i+1}(4,j) < meter(2500) & Sim1{1,i+1}(26,j) < nm(12) & (Sim1{1,i+1}(27,j) == 1 || Sim1{1,i+1}(27,j) == 2 || Sim1{1,i+1}(27,j) == 3 || Sim1{1,i+1}(27,j) == 4); % Landing 07
           Time_stamp(9,j) = i+1;
       else
           Time_stamp(9,j) = 0;
       end
   else
       Time_stamp(9,j) = Time_stamp(9,j);
   end
   
   if Sim1{1,i+1}(27,j) == 2 || Sim1{1,i+1}(27,j) == 3
       Time_stamp(10,j) = Time_stamp(4,j)-Time_stamp(1,j) ;
   else
       Time_stamp(10,j) = 0;
   end
   
   if Sim1{1,i+1}(27,j) ==1 
        Time_stamp(11,j) = Time_stamp(4,j)-Time_stamp(2,j) ;
   else
       Time_stamp(11,j) = 0;
   end
   
   if Sim1{1,i+1}(27,j) ==4
        Time_stamp(12,j) = Time_stamp(5,j)-Time_stamp(3,j) ;
   else
       Time_stamp(12,j) = 0;
   end
   
   if Sim1{1,i+1}(27,j) == 2 || Sim1{1,i+1}(27,j) == 3 || Sim1{1,i+1}(27,j) == 4
        Time_stamp(13,j) = Time_stamp(7,j)-Time_stamp(4,j) ;
   else
        Time_stamp(13,j) = 0;
   end
   
   if Sim1{1,i+1}(27,j) ==1 
        Time_stamp(14,j) = Time_stamp(7,j)-Time_stamp(5,j) ;
   else
       Time_stamp(14,j) = 0;
   end
   
    if Sim1{1,i+1}(27,j) ==1 
        Time_stamp(15,j) = Time_stamp(9,j)-Time_stamp(7,j) ;
   else
       Time_stamp(15,j) = 0;
   end
   
end
end

    save('Result1.mat','NavData','Sim1','Conflict','Conflict_1','Conflict_2','-v7.3')
    %save('Result1.mat','NavData','Sim1')
    
    timeElapsed_Simulation_schedule = toc