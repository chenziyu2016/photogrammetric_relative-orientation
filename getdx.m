function dx = getdx(A,L)
	%get the matrix of the unknowns
  d = ones(24,1);
  W = diag(d);
	N = A' * W * A;%where:
		% W is the weight matrix : ones in the main diagonal

	% Matrix of coefficients Qxx = inv(N)
	qxx = inv(N);

	% The error matrix dl
	dl = A' * W * L;

	% matrix of unknowns in the order 
		%% dw2, dp2, dk2, dBX, dBY, dBZ, dXi, dYi, dZi
		  %% these unknowns in the matrix dx are computed as change values

  dx = qxx * dl
  
end
