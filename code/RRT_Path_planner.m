%General inputs needed for the set-up
xy_goal = [0.5,0.5];
xy_start = [-0.5 -0.5];
n = 65; % number of random samples
r = 0.03; %robot radius = 3 cm -- to be used in collision detection
rand_nodes = (1* rand(n,2) )-0.5;
nodes = transpose([1:n+1]); % assigning IDs of nodes
edges = double.empty;

nodes(1,2:3) = [xy_start]; %adding starting node to nodes matrix
nodes (2:end,2:3) = rand_nodes; %adding the random nodes to nodes matrix
nodes (end:end,2:3) = xy_goal;
path =  int16.empty;
Tree(1,:) = [1 xy_start];
obstacles = csvread('obstacles.csv',5,0);

%converting 10% of the random sample nodes to be the goal node
rand_goal = randi([2 n],1,ceil(n*0.1));

for i=1:(n*0.1)
    row_no = rand_goal(:,i);
    nodes(row_no,2:3) = xy_goal;
    
end

%start of the RRt algorithm
while length(Tree) < n  
 
        %picking a random sample point
        sample_point = nodes(randi([2 n],1),:);
        closest_point = dsearchn(Tree(:,2:3),sample_point(1,2:3)); %returning the row of nearest point in the tree
        closest_point = Tree(closest_point,:);
        

         %checking collision
         [boolean_collision, sample_point] = collision_check (sample_point,closest_point,obstacles,r);
         
         if boolean_collision == 0

            Tree = [Tree; sample_point]; %adding the sample node to the tree
            edge_initial = sqrt((sample_point(1,2)-closest_point(1,2))^2+(sample_point(1,3)-closest_point(1,3))^2);
            edges = [edges; closest_point(1,1) sample_point(1,1) edge_initial];%creating the edges matrix
            parent_node(sample_point(1,1),1) = closest_point(1,1); %defining the parent node
            
            %finding the path
            if sample_point(1,2:3) == xy_goal

                last_node = sample_point(1,1);
                path = last_node;
                while last_node ~= nodes(1,1)
                    
                    path = [parent_node(last_node,1) path];
                    last_node = parent_node(last_node,1);

                end

                csvwrite('edges.csv',edges,0,0);
                csvwrite('nodes.csv',nodes,0,0);
                csvwrite('Path.csv',path,0,0);
                path
                display('Success!')
                break;    
            end 
         end  
  end

