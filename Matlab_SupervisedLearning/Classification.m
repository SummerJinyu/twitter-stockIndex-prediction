data = load('Mar_to_Aug');
A = data(:,1:5);
%A = [A';B']';
b = data(:,11);
x = linsolve (A,b);

s = 0;
%Divide 117 cases into 9 folders, each of size 13
i = 8               %use the last folder as test data
startIndex = 13*i+1;
stopIndex = 13*i+13;
testInd = false(1,117);
testInd(startIndex:stopIndex) = true;

test_A = A(testInd,:);
test_b = b(testInd,:);
train_A = A(~testInd,:);
train_b = b(~testInd,:);

result = int8(test_A*linsolve(train_A,train_b)>0);
result(result==0)=-1;

error_rate = sum(test_b ~= result)/13 %13 is folder size
error_rate




timeseries_error_rate = zeros([1 8]);
for i = 1:8    
    startIndex = 1;
    endIndex = 13*(i-1)+13;
    trainIndex = false(1,(i+1)*13);
    trainIndex(startIndex:endIndex) = true;
    
    train_A = A(trainIndex,:)
    train_b = b(trainIndex,:)
    test_A = A(~trainIndex,:)
    test_b = b(~trainIndex,:)
    
    result = int8(test_A*linsolve(train_A,train_b)>0);
    result(result==0)=-1; 
    timeseries_error_rate(i) = sum(test_b ~= result)/13 %13 is folder size
end







