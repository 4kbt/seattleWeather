new = d(:,3:6);
for counter = 1:length(d(:,1))
  new(counter,1) = counter*24*60*60;
endfor
%newFreqP = psd(new(:,1),new(:,2));
%newTH = psd(new(:,1),new(:,3)-mean(new(:,3)));
%newTL = psd(new(:,1),new(:,4)-mean(new(:,4)));

%loglog(newTH(:,1),newTH(:,2),
%       newTL(:,1),newTL(:,2));