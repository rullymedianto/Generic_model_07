 %profile on 
tic
numb = 10;

compl1 = cell(numb,7);
compl2 = cell(numb,5);
compl3 = cell(numb,7);
compl4 = cell(numb,5);
% compl5 = cell(numb,5);
% compl6 = cell(numb,5);
% compl7 = cell(numb,5);
% compl8 = cell(numb,5);


n=0;
for ii=1:numb
    schedules1
    Simulation_new %Simulation
% for iii=1:10    
    Vector_Complexity
    No_conflict_plot% Calculate Complexity
   
    compl1{ii,1}= timeElapsed_Simulation_schedule;
    compl1{ii,2}= max_complexity1;
    compl1{ii,3}= average_complexity1;
    compl1{ii,4}= timeElapsed_Vector_Complexity;
    compl1{ii,5}= max_aircraftinsector1;
    compl1{ii,6}= mean_aircraftinsector1;
%     compl1{ii,7}= mean(find(Time_stamp(10,:)));
    
    compl2{ii,1}= max_complexity2;
    compl2{ii,2}= average_complexity2;
    compl2{ii,3}= max_aircraftinsector2;
    compl2{ii,4}= mean_aircraftinsector2;
%     compl2{ii,5}= mean(find(Time_stamp(11,:)));
    
    compl3{ii,1}= max_complexity3;
    compl3{ii,2}= average_complexity3;
    compl3{ii,3}= max_aircraftinsector3;
    compl3{ii,4}= mean_aircraftinsector3;
    compl3{ii,5} = average_conAPP;
    compl3{ii,6} = max_conAPP;
%     compl3{ii,5}= mean(find(Time_stamp(12,:)));

    compl4{ii,1}= max_complexity4;
    compl4{ii,2}= average_complexity4;
    compl4{ii,3}= max_aircraftinsector4;
    compl4{ii,4}= mean_aircraftinsector4;
%     compl4{ii,5}= mean(find(Time_stamp(13,:)));
% 
%     compl5{ii,1}= max_complexity5;
%     compl5{ii,2}= average_complexity5;
%     compl5{ii,3}= max_aircraftinsector5;
%     compl5{ii,4}= mean_aircraftinsector5;
%     compl5{ii,5}= mean(find(Time_stamp(14,:)));

%     compl6{ii,1}= max_complexity6;
%     compl6{ii,2}= average_complexity6;
%     compl6{ii,3}= max_aircraftinsector6;
%     compl6{ii,4}= mean_aircraftinsector6;
%     compl6{ii,5}= 0;

%     compl7{ii,1}= max_complexity7;
%     compl7{ii,2}= average_complexity7;
%     compl7{ii,3}= max_aircraftinsector7;
%     compl7{ii,4}= mean_aircraftinsector7;
%     compl7{ii,5}= mean(find(Time_stamp(15,:)));

%     compl8{ii,1}= max_complexity8;
%     compl8{ii,2}= average_complexity8;
%     compl8{ii,3}= max_aircraftinsector8;
%     compl8{ii,4}= mean_aircraftinsector8;
%     compl8{ii,5}= 0;
    
%     confl {ii,1} = average_acAPP;
%     confl {ii,2} = max_acAPP;
%     confl {ii,3} = average_conAPP;
%     confl {ii,4} = max_conAPP;
    

compl_total=[compl1 compl2 compl3 compl4];

save('Complexity_Total.mat','compl_total','-v7.3')
% end   
% end
n=n+1;
disp(n)
end
time_running = toc;
time_running = time_running/60;
%profsave