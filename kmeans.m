%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CENG 465 Machine Learning - Project          %
%         - K-Means Algorithm  -               %
% Group Members:                               %
% Talha Akko�        150444023                 %  
% Meva Akkaya        150444024                 %
% O�uzcan Turan      150444043                 %
% Dilek Dil�ah �zkan 150444068                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%resulting in a clear screen
clc;
clear all;

%To load a data set into the workspace
 load('KmeanW.mat')

%data
% X = [1, 4; 1, 1; 7,1; 8,1] for manual testing
X = MallCustomers;

% get row number and column number from used data size
% number of vectors in X
[numberofvector, dim] = size(X);

%number of cluster (only 1-5)
% K=2;
K = input(sprintf('\nEnter the value of K between 1 to 5 :')); 

        %ask untill get 1to5 K number
      while  K>=5 | K<=1
          %cont. ask to user until user write the true value
        K = input(sprintf('\n Please enter only 1 to 5 value of K:')); 
      end 


% initialise empty vector for centroids
% C= [7,1; 8,1] for manual testing
C = zeros(K,dim);

% compute a random permutation of all input vectors
R = randperm(numberofvector);

% take the first K points in the random permutation as the center sead
for k=1:K
    C(k,:) = X(R(k),:);
end
 
% Maximum number of attempts
maxIter = input(sprintf('\nEnter the value of Max Iteration number:')); 

% temporary vector for cluster
I = zeros(numberofvector, 1);

%take inital iteration number
iter = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Euclidean distance %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while true % until !converged
  display('***************************')
  display(['Iteration ',num2str(iter)])
  display(' ')
  display('***** Distance Calculation for All Points with Centroids ********')
  
  
  % find closest point
    for n=1:numberofvector
        % find minimum distance of all points to the nearest centroid
        minIdx = 1;
        minVal = norm(X(n,:) - C(minIdx,:), 1);
        
        %display distance
        for j=1:K
            dist = norm(C(j,:) - X(n,:), 1);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            display (['Min Distance between  P',num2str(n),' and C',num2str(j), ' => ', num2str(dist) ])
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            if dist < minVal
                minIdx = j;
                minVal = dist;
            end

  end
  
        I(n) = minIdx;
        

    end
    
%show which point belong which centroid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
display('  ')
display('***** Assign All Points The Closest Centroid ********')
for n=1:numberofvector
 display (['P',num2str(n),' in C',num2str(I(n)) ])
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
%%%%%%%%%%%%%%% Compute Centroids %%%%%%%%%%%%%

    display(' ')
    display('***** Recompute Centroids ********')

    
    %Iteration and centroid no
    for k=1:K
          display([' Centroid ', num2str(k), ': X1 = ', num2str(C(k, 1)), '; X2 = ', num2str(C(k, 2))])
          C(k, :) = sum(X(find(I == k), :));
          C(k, :) = C(k, :) / length(find(I == k));
    end
    
    iter = iter + 1;
   
    if iter > maxIter
        iter = iter - 1;
        break;
    end
    
end


%%%%%%%%%%%%%%%%Result%%%%%%%%%%%%%%%

display(' ')
disp(['K-Means took ' int2str(iter) ' iteration to converge']);


display(' ')
display('***** Final Part ********')

%give the centroids for each iteration
for i=1:size(C, 1)
    display(['Centroid ', num2str(i), ': X1 = ', num2str(C(i, 1)), '; X2 = ', num2str(C(i, 2))]);
end

disp(['k-means instance took ' int2str(iter) ' iterations to complete']);


%%%%%%%%%%%%%%%% Graph %%%%%%%%%%%%

%for points color
colors = {'red', 'green','blue','yellow','orange'};
figure;
%title of graph
title('K-Means Cluster Assignments and Centroids')


for i=1:K
  hold on,
  plot(X(find(I == i), 1), X(find(I == i), 2), '.', 'color', colors{i}, 'MarkerSize',20);
   Legend{i} = ['Cluster', num2str(i)];   
end
%to mark centroids
plot(C(:,1),C(:,2),'x','MarkerSize',10,'LineWidth',3);
Legend{(K+1)} = ('Centroids');
legend(Legend)
