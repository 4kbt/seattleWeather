%This will subtract the mean of each month from the data

freqSearch;
daysPlot;

subMean = new;
monthCounter=1;
for i = 1:length(d(:,1))
  if (counter == 13)
    counter = 1;
  endif
  i=1;
  while(d(i,2)==monthCounter)
  %This takes each day and subtracts the monthly mean high 
  %and low temp
  subMean(i,3:4)=[(subMean(i,3)-r(monthCounter,2)),(subMean(i,4)-r(monthCounter,2))];
  i=i+1;
  endwhile
  monthCounter = monthCounter+1;
endfor

figure(1);
plot(subMean(:,1),subMean(:,3),
     subMean(:,1),subMean(:,4));