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
