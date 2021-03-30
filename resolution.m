function [Resolution,TimeTrigger] = resolution(clearance,past_resolution,i,past_TimeTrigger)
         if clearance == 1 && past_resolution == 0  %Normal
             Resolution = 0;
             TimeTrigger = 0;
             
         elseif clearance == 0 && past_resolution == 0  %Resolution Decision
                Resolution = resolution_type();  
                TimeTrigger = i+5;
                
         elseif clearance == 0 && past_resolution ~= 0  %Resolution Maneuver/Maintain
                Resolution = past_resolution;
                if past_TimeTrigger == i
                TimeTrigger = i+5;
                else 
                TimeTrigger = past_TimeTrigger;
                end
                                   
         elseif clearance == 1 && past_resolution ~= 0 %Change Resolution from Holding to Normal
             if past_TimeTrigger == i
                 Resolution = 0;
                 TimeTrigger = 0;
             else
                 Resolution = past_resolution;
                 TimeTrigger = past_TimeTrigger;
             end
               
         end

