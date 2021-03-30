
tic
%% Weighting factor for each parameter %%
w2 = 0.1129  ; % Weighting factor for aircraft type
w3 = 0.1430  ; % Weighting factor for speed ratio
w4 = 0.02288  ; % Weighting factor for number of cruising A/C 
w5 = 0.03287 ; % Weighting factor  for number of descending A/C
w6 = 0.05215  ; % Weighting factor for number of climbing A/C
w11 = 0.3973; % Weighting for RTF represented by potential conflict (overtaking and crossing)


[acs1 acs2 acs3 acs4] = cellfun(@vector_acinsector1,Sim1);
vector_acinsectorArray1 = [acs1' acs2' acs3' acs4'];
%vector_acinsectorArray1 = movmedian(vector_acinsectorArray1,5);
A1 = vector_acinsectorArray1;

%% Aircraft Type %%
[at1 at2 at3 at4] = cellfun(@vector_aircrafttype1,Sim1);
vector_aircrafttypeArray1 = [at1' at2' at3' at4'];
%vector_aircrafttypeArray1 = movmedian(vector_aircrafttypeArray1,5);
A2 = vector_aircrafttypeArray1;

%% Speed Ratio %%              
[sr1 sr2 sr3 sr4] = cellfun(@vector_speedratio1,Sim1);
vector_speedratioArray2 = [sr1' sr2' sr3' sr4'];
%vector_speedratioArray2 = movmedian(vector_speedratioArray2,5);
A3 = vector_speedratioArray2;

%% Aircraft Cruise %%
[cruis1 cruis2 cruis3 cruis4] = cellfun(@vector_cruise1,Sim1);
vector_cruiseArray1 = [cruis1' cruis2' cruis3' cruis4'];
%vector_cruiseArray1 = movmedian(vector_cruiseArray1,5);
A4 = vector_cruiseArray1;      

%% Aircraft Descent %%        
[tr1 tr2 tr3 tr4] = cellfun(@vector_descent1,Sim1);
vector_descentArray1 = [tr1' tr2' tr3' tr4'];
%vector_descentArray1 = movmedian(vector_descentArray1,5);
A5 = vector_descentArray1;

%% Aircraft Climb %%
[cl1 cl2 cl3 cl4]  = cellfun(@vector_climb1,Sim1);
vector_climbArray1 = [cl1' cl2' cl3' cl4'];
%vector_climbArray1 = movmedian(vector_climbArray1,5);
A6 = vector_climbArray1;

%% Number of Overtaking Conflict %%
[ot1 ot2 ot3 ot4] = cellfun(@vector_overtakingconflict1,Sim1);
vector_overtakingconflictArray1 = [ot1' ot2' ot3' ot4'];
%vector_overtakingconflictArray1 = movmedian(vector_overtakingconflictArray1,5);
A7 = vector_overtakingconflictArray1;

%% Number of Crossing Conflict %%
[noc1 noc2 noc3 noc4] = cellfun(@vector_crossingconflict1,Sim1);
vector_crossingconflictArray1 = [noc1' noc2' noc3' noc4'];
%vector_crossingconflictArray1 = movmedian(vector_crossingconflictArray1,5);
A8 = vector_crossingconflictArray1;

%% Number of Complexity Lower North (LN)%%
numofcomplexityArray1 = w2*A2(:,1) + w3*A3(:,1) + w4*A4(:,1) + w5*A5(:,1) + w6*A6(:,1) +(w11*(A7(:,1) + A8(:,1))/2);
CA1 = numofcomplexityArray1;
%CA1 = movmedian(numofcomplexityArray1,5);
plotnumofcomplexity1 = plot(CA1,'r');       

max_complexity1 = max(CA1);
% min_complexity1 = min(CA1);
average_complexity1 = mean(CA1);
max_aircraftinsector1 = max(A1(:,1));
mean_aircraftinsector1 = mean(A1(:,1));
% 
% Max_Complexity1 = max(CA1);
% Min_Complexity1 = min(CA1);
% 
% Complexity_param1 = [Max_Complexity1 Min_Complexity1];

%% Number of Complexity Lower Centre (LC)%%
numofcomplexityArray2 = w2*A2(:,2) + w3*A3(:,2) + w4*A4(:,2) + w5*A5(:,2) + w6*A6(:,2) +(w11*(A7(:,2) + A8(:,2))/2);
CA2 = numofcomplexityArray2;
%CA2 = movmedian(numofcomplexityArray2,5);
plotnumofcomplexity2 = plot(CA2,'r');       

max_complexity2 = max(CA2);
% min_complexity2 = min(CA2);
average_complexity2 = mean(CA2);
max_aircraftinsector2 = max(A1(:,2));
mean_aircraftinsector2 = mean(A1(:,2));
% 
% Max_Complexity2 = max(CA2);
% Min_Complexity2 = min(CA2);
% 
% Complexity_param2 = [Max_Complexity2 Min_Complexity2];

%% Number of Complexity Terminal West (TW)%%
numofcomplexityArray3 = w2*A2(:,3) + w3*A3(:,3) + w4*A4(:,3) + w5*A5(:,3) + w6*A6(:,3) +(w11*(A7(:,3) + A8(:,3))/2);
CA3 = numofcomplexityArray3;
%CA3 = movmedian(numofcomplexityArray3,5);
plotnumofcomplexity3 = plot(CA3,'r');       

max_complexity3 = max(CA3);
% min_complexity3 = min(CA3);
average_complexity3 = mean(CA3);
max_aircraftinsector3 = max(A1(:,3));
mean_aircraftinsector3 = mean(A1(:,3));
% 
% Max_Complexity3 = max(CA3);
% Min_Complexity3 = min(CA3);
% 
% Complexity_param3 = [Max_Complexity3 Min_Complexity3];

%% Number of Complexity Arrival North (AN)%%
numofcomplexityArray4 = w2*A2(:,4) + w3*A3(:,4) + w4*A4(:,4) + w5*A5(:,4) + w6*A6(:,4) +(w11*(A7(:,4) + A8(:,4))/2);

CA4 = movmedian(numofcomplexityArray4,5);
plotnumofcomplexity4 = plot(CA4,'r');       

max_complexity4 = max(CA4);
min_complexity4 = min(CA4);
average_complexity4 = mean(CA4);
max_aircraftinsector4 = max(A1(:,4));
mean_aircraftinsector4 = mean(A1(:,4));

CATOT = [CA1 CA2 CA3 CA4];

%legend('12NM','15NM')
% plot(CA3,'r')       
%  xlim([0 t])
%  ylim([0 10])
%  xlabel('time')
%  ylabel('Complexity')
%  title("Air Traffic Complexity")  


hold on


% plot(CA2,'b')
% plot(CA1,'g')
% plot(CA4,'c')



hold off
timeElapsed_Vector_Complexity = toc;

%saveas (plotnumofcomplexity2,'Air_Traffic_Complexity.jpg');         
save('Complexity_.mat', 'CATOT') 
