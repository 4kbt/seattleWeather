clear;
seatac = load('seatacTabDelimited.dat');

%do something to deal with glitches
seatac(1420,3) = mean([53 46]);
seatac(18416,2) = 0;
seatac(18417,2) = 0;
seatac(21068,2) = 0;

%Date parsing
year = floor(seatac(:,1)/10000);
month = floor( ( seatac(:,1) - year * 10000) / 100);
day = seatac(:,1) - year*10000 - month * 100;

%unit conversions
precip = seatac(:,2) * 0.0254;
temps = (seatac(:,3:4) - 32 ) * 5/9;

%aggregate dataset (there are lots of ways to do this; I'm very old-school.).
d = [year month day precip temps];

