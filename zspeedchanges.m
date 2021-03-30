function [x] = zspeedchanges(h_aircraft,h_desire,rate_climb,rate_descent)
if h_aircraft > h_desire + meter(2000)
    x = -1*rate_descent;
elseif h_aircraft < h_desire + meter(2000)
    x = 1*rate_climb;
else
    x = 0;
end