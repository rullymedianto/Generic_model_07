function [sr] = vector_samerunway1(sim1)


AB = sim1(1,:);
AC = sim1(4,:);

BB = sim1(21,:); %Route No.

overtake =[0 1 3 6 9 14];
% Logic Same Runway 07L 

RWY07LL = AB >1  & AC>lim_low07LL & AC<lim_up07LL & (BB == 1 | 2 |3 | 4| 5)  ;
SR_RWY07LL = sum(RWY07LL>0);

RWY07LT = AB >1  & AC>lim_low07LT & AC<lim_up07LT & (BB == 9 | 10 |11 | 12| 13| 14 |15)  ;
SR_RWY07LT = sum(RWY07LT>0);

SR_RWY07L = SR_RWY07LL * SR_RWY07LT;

% Logic Same Runway 07R 

RWY07RL = AB >1  & AC>lim_low07RL & AC<lim_up07RL & (BB == 6| 7 |8)  ;
SR_RWY07RL = sum(RWY07RL>0);

RWY07RT = AB >1  & AC>lim_low07RT & AC<lim_up07RT & (BB == 16 | 17 | 18 | 19 | 20| 21 | 22 | 23)  ;
SR_RWY07RT = sum(RWY07RT>0);

SR_RWY07R = SR_RWY07RL * SR_RWY07RT;

sr =  SR_RWY07L + SR_RWY07R;