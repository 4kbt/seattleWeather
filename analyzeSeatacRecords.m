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
plot(d(:,2), d(:,6),'.', climateAverages(:,1), climateAverages(:,4),
     d(:,2)+.1, d(:,5),'.', climateAverages(:,1)+.1,climateAverages(:,3) );
%looks good

%Now, we need month-by-month averages
monthlyAverage = []
for year = min(d(:,1)):max(d(:,1))
	for month = 1:12
		monthlyAverage = [ monthlyAverage; year month ...
			mean( d( d(:,1) == year & d(:,2) == month, 4:6) )];
	end %month
end %year

