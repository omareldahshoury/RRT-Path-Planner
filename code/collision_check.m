function [boolean_collision, sample_point] = collision_check (sample_point,closest_point,obstacles,r)

if sample_point(1,2:3) == closest_point(1,2:3)
    boolean_collision = 2;
    return;
end
boolean_collision = 0;

%y = ax + b
a = (sample_point(1,3)-closest_point(1,3))/(sample_point(1,2)-closest_point(1,2));
b = sample_point(1,3) - (a * sample_point(1,2));
rand_segment = sort(rand(20,1),'descend');
rand_segment(1,1) = 1;

%choose 20 random points along the line and check if they are inside any of
%the obstacles boundary    
for j = 1:20
        
        if boolean_collision == 0
            
            x = ((sample_point(1,2) - closest_point(1,2))*rand_segment(j,1))+(closest_point(1,2));  
            y = (a*x) + b;

            for i=1:length(obstacles)
                x_obst_min = obstacles(i,1) - (obstacles(i,3)*0.5+r); %center of circle minus both radii of circle and robot
                x_obst_max = obstacles(i,1) + (obstacles(i,3)*0.5+r);
                y_obst_min = obstacles(i,2) - (obstacles(i,3)*0.5+r);
                y_obst_max = obstacles(i,2) + (obstacles(i,3)*0.5+r);
                
                if (x_obst_min < x) && (x < x_obst_max) && (y_obst_min < y) && (y < y_obst_max)
                    
                    boolean_collision = 1;
                   
                    break;
                   
                else
                    
                    sample_point(1,2:3) = sample_point(1,2:3);
                   boolean_collision = 0; 
                       
                      
                end
            end
        end

    end
end