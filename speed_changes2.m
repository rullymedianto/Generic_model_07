function [vx vy] = speed_changes2(vz,vplus,vnol,heading,ROW)
%% Calculate Vy  
    

if ROW >1
% if vplus<vnol
     vnol = vnol-0.5;

%      elseif vplus>vnol
%          if vnol==0
%              vnol = vplus;
%          else
%          vnol = vnol+0.5;
%          end
%      else
%          vnol = vnol-0.5;
% end
% else
%  if vplus<vnol
%      vnol = vnol;
% 
%      elseif vplus>vnol
%          if vnol==0
%              vnol = vplus;
%          else
%          vnol = vnol+1;
%          end
     else
         vnol = vnol+0.5;
% end
end

vy = sqrt(vnol^2 - vz^2)*cosd(heading);
vx = sqrt(vnol^2 - vz^2)*sind(heading);
end