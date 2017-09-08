clear

importSeatacRecords

%Trim off 2017 to keep the math easy:
d = d( d(:,1) < 2017 , :);

%First, we'll need monthly averages for the dataset.
%There's probably a more-elegant way to go, but this is quick/understandable

for month = 1:12
	climateAverages(month,:) = mean( d( d(:,2) == month , : ) );
end
%drop the meaningless year/day information
climateAverages = climateAverages(:,[2 4:6]);

%let's see if the averages make sense
plot(d(:,2), d(:,6),'.', climateAverages(:,1), climateAverages(:,4), ';ave low;',
     d(:,2)+.1, d(:,5),'.', climateAverages(:,1)+.1,climateAverages(:,3) ,
	';ave high;');
xlabel('month');
ylabel('temperature')
%looks good

%Now, we need month-by-month averages
monthlyAverage = [];
for year = min(d(:,1)):max(d(:,1))
	for month = 1:12
		monthlyAverage = [ monthlyAverage; year month ...
			mean( d( d(:,1) == year & d(:,2) == month, 4:6) )];
	end %month
end %year

%let's see if the monthly averages look good.
plot( d(:,1) + d(:,2) / 12 + d(:,3) / 30 / 12 , d(:,5),'.', ... 
      monthlyAverage(:,1) + monthlyAverage(:,2) / 12 + 0.5/12, monthlyAverage(:,4))
%looks okay

%first chance we have to really look at precip:
plot( monthlyAverage(:,2), monthlyAverage(:,3),'.',
      climateAverages(:,1), climateAverages(:,2))
%looks okay


%%%%%%%%%%%%%
%TEMPERATURE%
%%%%%%%%%%%%%
%We need differences from average. We'll do temperature first.
TemperatureAnomaly = [monthlyAverage(:,1:2) ...
		monthlyAverage(:,4:5) - climateAverages(monthlyAverage(:,2),3:4)];

%To see that the above trickery is kosher, have a look at:
% plot(monthlyAverage(:,2),climateAverages(monthlyAverage(:,2),1))

plot(TemperatureAnomaly(:,3))

%We can already start to have some fun -- Are highs and lows correlated?
plot(TemperatureAnomaly(:,3), TemperatureAnomaly(:,4),'.');

HighLowTempCorrelation = corr(TemperatureAnomaly(:,3), TemperatureAnomaly(:,4))

%We're now in position to answer our first question. How correlated are subsequent months?

%Autocorrelation method
%A sophisticated way to do it, but it doesn't give trivial satisfying uncertainties
[ corcoeffLow  lagLow ] =xcorr(TemperatureAnomaly (:,3),'coeff');
[ corcoeffHigh lagHigh] =xcorr(TemperatureAnomaly (:,4),'coeff');

semilogx( ...
	lagLow , corcoeffLow ,'+-;Low Temperatures; ',
	lagHigh, corcoeffHigh,'+-;High Temperatures;'
    )
xlabel('month delay')
ylabel('correlation coefficient')

%Aha! It looks like there is a substantial linear component to at least the high
%temperature data that might hide shorter-term variation.
%Since we're interested in shorter-term variation...
dTemperatureAnomaly = [TemperatureAnomaly(:,1:2), detrend(TemperatureAnomaly(:,3:4))];

%Recomputing correlation coefficients
[ corcoeffLow  lagLow ] =xcorr(dTemperatureAnomaly (:,3),'coeff');
[ corcoeffHigh lagHigh] =xcorr(dTemperatureAnomaly (:,4),'coeff');

semilogx( ...
	lagLow , corcoeffLow ,'+-;Low Temperatures; ',
	lagHigh, corcoeffHigh,'+-;High Temperatures;'
    )
xlabel('month delay')
ylabel('correlation coefficient')

%Hey! The Pacific Decadal Oscillation might be visible :).

%Let's do a less-sophisticated analysis:
M0 = TemperatureAnomaly(1:end-1,3:4);
M1 = TemperatureAnomaly(2:end  ,3:4);
%plot(M0(:,1),M1(:,1),'.');

M0M1 = M0.*M1;
%plot(M0M1(:,1),'.');

mean(M0M1(:,1))
std(M0M1(:,1))/sqrt(rows(M0))
%hist(M0M1(:,1),sqrt(rows(M0)))

PrecipAnomaly = [monthlyAverage(:,1:2) ...
		monthlyAverage(:,3) - climateAverages(monthlyAverage(:,2),2)];


