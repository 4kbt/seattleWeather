monthAverages=zeros(12,3);
monthStd=zeros(12,3);

%Finding monthly mean and standard deviation
for m= 1:12
  monthAverages(m,:)=[mean(d(d(:,2) == m,4)), mean(d(d(:,2) == m,5)),mean(d(d(:,2) == m,6))];
  monthStd(m,:)=[std(d(d(:,2) == m,4)), std(d(d(:,2) == m,5)),...
  std(d(d(:,2) == m,6))];
end
%
%Finding the mean for each month of each year
individualMonths = [];
for y = (min(d(:,1))):(max(d(:,1))-1)
	for m = 1:12

		%Compute it
		a =  mean( d( ( d(:,1) == y & d(:,2) == m  ) , 4 ) ) ;
    aerr = std(d( ( d(:,1) == y & d(:,2) == m  ) , 4 ) ) ;
    b =  mean( d( ( d(:,1) == y & d(:,2) == m  ) , 5 ) ) ;
    berr = std(d( ( d(:,1) == y & d(:,2) == m  ) , 5 ) ) ;
    c =  mean( d( ( d(:,1) == y & d(:,2) == m  ) , 6 ) ) ;
    cerr = std(d( ( d(:,1) == y & d(:,2) == m  ) , 6 ) ) ;
    
    %Propagate errors by sum in quadrature 
    %(errors don't have dependence on each other)
    aFin = sqrt(aerr^2 + monthStd(m,1)^2);
    bFin = sqrt(berr^2 + monthStd(m,2)^2);
    cFin = sqrt(cerr^2 + monthStd(m,3)^2);
    
		
		%Aggregate it
		individualMonths = [individualMonths ; y m a aFin b bFin c cFin ];
	end
end
%
%Subtracts each monthly mean from the corresponding month
meanSubtractedMonths = individualMonths;
for m = 1:12
	mDex = individualMonths(:,2) == m;
	meanSubtractedMonths(mDex,3)  = individualMonths(mDex,3)- monthAverages(m,1);
  meanSubtractedMonths(mDex,5)  = individualMonths(mDex,5)- monthAverages(m,2);
  meanSubtractedMonths(mDex,7)  = individualMonths(mDex,7)- monthAverages(m,3);
end
%
%Plots all figures for high temp, low temp, and precipitation

%Precipitation
figure(1)
hold on
PrecipData = [];
for m=1:11
  PrecipData = [PrecipData; meanSubtractedMonths(meanSubtractedMonths(:,2)== m,3:4)...
                meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+1),3:4)];
  plot(meanSubtractedMonths(meanSubtractedMonths(:,2)== m   ,3), 
       meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+1),3),'+');
            
end
%calculation of line of best fit
finalPrecip = ols2(PrecipData(:,3),PrecipData(:,1));
finalPrecip
pearsonPrecip = mean(finalPrecip(:,5)/(meanSubtractedMonths(:,2)*meanSubtractedMonths(:,4)));
hold off

legend('Pearson Correlation =', pearsonPrecip);
title('Precipitation Comparison Between Months');
xlabel('Current Month Precipitation Anomaly');
ylabel('Next Month Precipitation Anomaly');
axis("square");
grid on

%High Temperatures
figure(2)
hold on
for m=1:11

  plot(meanSubtractedMonths(meanSubtractedMonths(:,2)== m   ,5),
       meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+1),5), '+');
            
end
%calculation of line of best fit

hold off

title('High Temperature Comparison Between Months');
xlabel('Current Month Temp Anomaly');
ylabel('Next Month Temp Anomaly');
axis("square");
grid on

%Low Temperatures
figure(3)
hold on
for m=1:11

  plot(meanSubtractedMonths(meanSubtractedMonths(:,2)==m,7),
       meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+1),7),'+');
            
end
%calculation of line of best fit

hold off

title('Low Temperature Comparison Between Months');
xlabel('Current Month Temp Anomaly');
ylabel('Next Month Temp Anomaly');
axis("square");
grid on