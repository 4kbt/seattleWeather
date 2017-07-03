#!/bin/bash

FN=seatacTabDelimited.dat

echo "#date precip TMax Tmin" > $FN

sed 's/,/\t/g' seatacRecords.csv |
awk '{print $8, $9, $10, $11}' >> $FN

