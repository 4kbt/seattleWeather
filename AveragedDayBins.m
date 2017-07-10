%This should create bins for each day, then sort data into each bin

%Initializes output array and number of entries array
out=[];
N=[];

%Creates bins (First year includes a leap day so no casework needed)
n=1;
for i=1:12
  while (d(n,2) == i)
    out = [out; 0,0,0,0];
    N = [N; 0,0,0];
    n=n+1;
  endwhile
endfor

%Sorts data into bins
counter=1;
for indexYear=d(1,1):d(length(d),1)
  %From 1-366 (for leap day)
  daysCounter=1;
  for indexMonth=1:12
    while (d(counter,2)==indexMonth&counter<25371)
      %Adds each day to its corresponding bin, the first matrix element 
      %needs to be optimized
      out(daysCounter,:)=[(daysCounter*24*60*60),(out(daysCounter,2)+d(counter,4)),(out(daysCounter,3)+d(counter,5)), (out(daysCounter,4)+d(counter,6))];
      
      %Counts the number of elements in each bin
      N(daysCounter,:)=N(daysCounter,:)+ones(1,3);
      counter = counter+1;
      daysCounter=daysCounter+1;
    endwhile
  endfor
endfor

%This performs the average of each day
for a=1:length(out)
  out(a,2)=out(a,2)./N(a,1);
  out(a,3)=out(a,3)./N(a,2);
  out(a,4)=out(a,4)./N(a,3);
endfor

%This plots the average pressure from 1948-2017 for each day of the year
%plot(out(:,1),out(:,2));

%Average temp (high and low) on the time domain

dayFreqPressure = psd(out(:,1),out(:,2));
dayFreqTempH = psd(out(:,1),out(:,3));
dayFreqTempL = psd(out(:,1),out(:,4));

%loglog(dayFreqPressure(:,1),dayFreqPressure(:,2));
loglog(dayFreqTempH(:,1),dayFreqTempH(:,2),
       dayFreqTempL(:,1),dayFreqTempL(:,2));

