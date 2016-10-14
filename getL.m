function L = getL(x1, y1, x2, y2, BX, BY, BZ, XI, YI, ZI, R, f, n)
	% compute the L matrix 
	L = zeros(n*4,1);

	for m=1:n

		a= m*4; %matrix index navigations

		L(a-1,1) = x1(m,1)*ZI(m,1) + f*XI(m,1);
		L(a-2,1) = y1(m,1)*ZI(m,1) + f*YI(m,1);		
		L(a-3,1) = (R(1,1)*x2(m,1) + R(1,2)*y2(m,1) - R(1,3)*f )*( ZI(m,1) - BZ ) - (R(3,1)*x2(m,1) + R(3,2)*y2(m,1) - R(3,3)*f )*( XI(m,1) - BX );			
		L(a,1)   = (R(2,1)*x2(m,1) + R(2,2)*y2(m,1) - R(2,3)*f )*( ZI(m,1) - BZ ) - (R(3,1)*x2(m,1) + R(3,2)*y2(m,1) - R(3,3)*f )*( YI(m,1) - BY );	
	end
end