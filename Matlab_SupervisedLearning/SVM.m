%------------------------------------------------------------------------%
%(b): SVM
lambda = 0.1;
gamma = 0.01;
T = 20000;
W2 = [0,0,0]'; %start from [0,0,0]'
W1 = W2 + 1;   
%w1 = zeros([100 1]); %component 1 of wt
%w2 = zeros([100 1]); %component 2 of wt
%w3 = zeros([100 1]); %component 3 of wt
for k = 1:T
    W1 = W2;  %kth iteration
    gradient = 0;
    for i = 1:100
        if (y(i)*X(i,:)*W1 <= 1)
            %soft threshreshold
            gradient = gradient + (-y(i)*X(i,:)'); 
        end
    end
    %penalty for component 1 & component 2
    gradient(1) = gradient(1) + lambda*2*(W1(1));
    gradient(2) = gradient(2) + lambda*2*(W1(2)); 
    %the updated (k+1) iteration
    W2 = W1 - gamma*gradient; 
    %w1(k) = W2(1); %record component 1
    %w2(k) = W2(2); %record component 2
    %w3(k) = W2(3); %record component 3
end


