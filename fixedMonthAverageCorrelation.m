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
%Plots all figures for high temp, low temp, and precipitation:
%This is the difference between months 1<=diff<=11
diff = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Precipitation
figure(1)
hold on
PrecipData = [];
for m=1:(12-diff)
  PrecipData = [PrecipData; meanSubtractedMonths(meanSubtractedMonths(:,2)== m,3:4)...
                meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+diff),3:4)];
  plot(meanSubtractedMonths(meanSubtractedMonths(:,2)== m   ,3), 
       meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+diff),3),'+');
            
end
%Covariance
covarP = sum(PrecipData(:,1).*PrecipData(:,3))/length(PrecipData(:,1));

%pearson correlation: covariance/mean(sigma_x*sigma_y)
pearsonPrecip = mean(covarP/(PrecipData(:,2).*PrecipData(:,4)))

%calculation of line of best fit
[betaP sigmaP arrP errP covP] = ols2(PrecipData(:,3),PrecipData(:,1));
timeP = -.01:.001:.01;
errorbar(timeP,betaP*timeP,errP,'k');

%Start plotting figure 1
hold off

%Labels
legend('Colored dots: monthly anomaly','black line: ols fit');
title(strcat('Precipitation Comparison Between Months, Month diff =',num2str(diff)));
xlabel('Current Month Precipitation Anomaly');
ylabel('Next Month Precipitation Anomaly');
axis("square");
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%High Temperatures
figure(2)
hold on
HighTData = [];
for m=1:(12-diff)
  HighTData = [HighTData; meanSubtractedMonths(meanSubtractedMonths(:,2)== m,5:6)...
                meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+diff),5:6)];
  plot(meanSubtractedMonths(meanSubtractedMonths(:,2)== m   ,5),
       meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+diff),5), '+');
            
end
%Covariance
covarH = sum(HighTData(:,1).*HighTData(:,3))/length(HighTData(:,1));

%pearson correlation: covariance/mean(sigma_x*sigma_y)
pearsonHigh = (covarH*length(HighTData(:,1)))/sum(HighTData(:,2).*HighTData(:,4))

%calculation of line of best fit
[betaH sigmaH arrH errH covH] = ols2(HighTData(:,3),HighTData(:,1));
timeH = -10:1:10;
errorbar(timeH,betaH*timeH,errH,'k');

%Start plotting figure 2
hold off

%Labels
legend('Colored dots: monthly anomaly','black line: ols fit');
title(strcat('High Temperature Comparison Between Months, Month diff =',num2str(diff)));
xlabel('Current Month Temp Anomaly');
ylabel('Next Month Temp Anomaly');
axis("square");
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Low Temperatures
figure(3)
hold on
LowTData = [];
for m=1:(12-diff)
  LowTData = [LowTData; meanSubtractedMonths(meanSubtractedMonths(:,2)== m,7:8)...
                meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+diff),7:8)];
  plot(meanSubtractedMonths(meanSubtractedMonths(:,2)==m,7),
       meanSubtractedMonths(meanSubtractedMonths(:,2)==(m+diff),7),'+');
            
end
%Covariance
covarL = sum(LowTData(:,1).*LowTData(:,3))/length(LowTData(:,1));

%pearson correlation: covariance/mean(sigma_x*sigma_y)
pearsonLow = (covarL*length(LowTData(:,1)))/sum(LowTData(:,2).*LowTData(:,4))

%calculation of line of best fit
[betaL sigmaL arrL errL covL] = ols2(LowTData(:,3),LowTData(:,1));
timeL = -10:1:10;
errorbar(timeL,betaL*timeL,errL,'k');

%Start plotting figure 3
hold off

%Labels
legend('Colored dots: monthly anomaly','black line: ols fit');
title(strcat('Low Temperature Comparison Between MonthsMonth diff =',num2str(diff)));
xlabel('Current Month Temp Anomaly');
ylabel('Next Month Temp Anomaly');
axis("square");
grid on