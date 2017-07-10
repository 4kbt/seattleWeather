function sineGen=genSineSeed(t,f)

	sineGen=[sin(2*pi*f*t) cos(2*pi*f*t) ones(length(t),1)];

endfunction

%!test
%! G = genSineSeed(0,1);
%! assert(G  == [ 0 1 1] );

