%This should create bins for each day, then sort data into each bin

%Initializes output array and number of entries array
out=[];
N=[];

%Creates bins (First year includes a leap day so no casework needed)
n=1;
for i=1:12
  while (d(n,2) == i)
    out = [out; d(n,2),d(n,3),0,0,0];
    N = [N; 0,0,0];
    n=n+1;
  endwhile
endfor

%Sorts data into bins
counter=1;
for indexYear=d(1,1):d(length(d),1)
  daysCounter=1;
  for indexMonth=1:12
    while (d(counter,2)==indexMonth&counter<25371)
      out(daysCounter,3:5)=[(out(daysCounter,3)+d(counter,4)), (out(daysCounter,4)
                            +d(counter,5)), (out(daysCounter,5)+d(counter,6))];
      N(daysCounter,:)=N(daysCounter,:)+ones(1,3);
      counter = counter+1;
      daysCounter=daysCounter+1;
    endwhile
  endfor
endfor

%This performs the average of each day
for a=1:length(out)
  out(a,3)=out(a,3)/N(a,1);
  out(a,4)=out(a,4)/N(a,2);
  out(a,5)=out(a,5)/N(a,3);
endfor

plot(out(:,2),out(:,3));