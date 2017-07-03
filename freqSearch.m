%I need to average each of the days of the month, 
%then find a sine fit for the month data.
%If the months regress to the mean, there will be a
%frequency of a month/2 present in the FFT

%preliminary search, should see peak at 
%30.42days in month*24hours*60minutes*60seconds/2 = omega
%=(7.6095e-7 Hz)
%dayTemp =[d(:,3) d(:,5)-mean(d(:,5)) d(:,6)-mean(d(:,6))];
%PHighTemp= psd(dayTemp(:,1),dayTemp(:,2));
%PLowTemp = psd(dayTemp(:,1),dayTemp(:,3));
%loglog(PHighTemp(:,1),sqrt(PHighTemp(:,2)),
%       PLowTemp(:,1) , sqrt(PLowTemp(:,2)));

SumH=0;
SumL=0;
r=[];
NumMonths=0;
for counter = 1:length(d(:,3))
  if(d(counter,3)==1)
  NumMonths = NumMonths+1;
  r=[r;NumMonths mean(SumH) mean(SumL)];
  SumH=0;
  SumL=0;
  endif
SumH = SumH+d(counter,5);
SumL = SumL+d(counter,6);
endfor

%This is averaging the temperatures of all the days for each month
%multiplying by 30.42*24*60*60=2628288 seconds in a month
monthTemp = [r(:,1)*2628288 r(:,2)-mean(r(:,2)) r(:,3)-mean(r(:,3))];
PmHT = psd(monthTemp(:,1),monthTemp(:,2));
PmLT = psd(monthTemp(:,1),monthTemp(:,3));
loglog(PmHT(:,1),sqrt(PmHT(:,2)),
       PmLT(:,1),sqrt(PmLT(:,2)));
       
%There is not high enough frequency to search for the target
%data too sparse, will have to take bins for each day