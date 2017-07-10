%This will subtract the mean of each month from the data

freqSearch;
daysPlot;

subMean = new;
index = 1;
monthCounter=1;
while (index <= length(d))
  if (counter == 13)
    counter = 1;
  endif
  while(d(index,2)==monthCounter)
  %This takes each day and subtracts the monthly mean high 
  %and low temp
  subMean(index,3:4)=[(subMean(index,3)-r(monthCounter,2)),(subMean(index,4)-r(monthCounter,2))];
  index=index+1;
  endwhile
  monthCounter = monthCounter+1;
endwhile

plot(subMean(:,1),subMean(:,3),
     subMean(:,1),subMean(:,4));