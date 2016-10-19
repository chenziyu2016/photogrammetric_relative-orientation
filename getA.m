function A = getA(x1, y1, x2, y2, BX, BY, BZ, XI, YI, ZI, R, drw, drp, drk, f, n)
	% compute the matrix of coefficients of the unknowns, the A matrix.
	format short

	A = zeros(n*4,8+3*(n-1));  %dynamically calculate the size of A matrix.
	%in this case A will be of size (24 by 23) ==> 24 by 8+3*5
	p=6; %initialize column count for model coords
	
	for m = 1:n
		
		%index navigations
		a = m*4;

		% 8 unknowns for the first pair of conjugates			        
    %%elements from differentials of F1
		A(a-3,1) = 0;
		A(a-3,2) = 0;
		A(a-3,3) = 0;	        
		A(a-3,4) = 0;
		A(a-3,5) = 0;
		A(a-3,p) = f;
		A(a-3,p+1) = 0;
		A(a-3,p+2) = x1(m,1);
	
		%%elements from differentials of F2
		A(a-2,1) = 0;
		A(a-2,2) = 0;
		A(a-2,3) = 0;	        
		A(a-2,4) = 0;	        
		A(a-2,5) = 0;
		A(a-2,p) = 0;
		A(a-2,p+1) = f;
		A(a-2,p+2) = y1(m,1);

    %%elements from differentials of F3
		A(a-1,1) = ( drw(1,1)*x2(m,1) + drw(1,2)*y2(m,1) - drw(1,3)*f )*( ZI(m,1) - BZ ) - ( drw(3,1)*x2(m,1) + drw(3,2)*y2(m,1) - drw(3,3)*f )*( XI(m,1) - BX );
        
		A(a-1,2) = ( drp(1,1)*x2(m,1) + drp(1,2)*y2(m,1) - drp(1,3)*f )*( ZI(m,1) - BZ ) - ( drp(3,1)*x2(m,1) + drp(3,2)*y2(m,1) - drp(3,3)*f )*( XI(m,1) - BX );
        
		A(a-1,3) = ( drk(1,1)*x2(m,1) + drk(1,2)*y2(m,1) - drk(1,3)*f )*( ZI(m,1) - BZ ) - ( drk(3,1)*x2(m,1) + drk(3,2)*y2(m,1) - drk(3,3)*f )*( XI(m,1) - BX ); 
    
    A(a-1,4) = 0;
		A(a-1,5) = -( R(1,1)*x2(m,1) + R(1,2)*y2(m,1) - R(1,3)*f );

		A(a-1,p) = -( R(3,1)*x2(m,1) + R(3,2)*y2(m,1) - R(3,3)*f );
		A(a-1,p+1) = 0;		
		A(a-1,p+2) = R(1,1)*x2(m,1) + R(1,2)*y2(m,1) - R(1,3)*f;

    %%elements from differentials of F4
		A(a,1) = ( drw(2,1)*x2(m,1) + drw(2,2)*y2(m,1) - drw(2,3)*f )*( ZI(m,1) - BZ ) - ( drw(3,1)*x2(m,1) + drw(3,2)*y2(m,1) - drw(3,3)*f )*( YI(m,1) - BY );
        
		A(a,2) = ( drp(2,1)*x2(m,1) + drp(2,2)*y2(m,1) - drp(2,3)*f )*( ZI(m,1) - BZ ) - ( drp(3,1)*x2(m,1) + drp(3,2)*y2(m,1) - drp(3,3)*f )*( YI(m,1) - BY );
        
		A(a,3) = ( drk(2,1)*x2(m,1) + drk(2,2)*y2(m,1) - drk(2,3)*f )*( ZI(m,1) - BZ ) - ( drk(3,1)*x2(m,1) + drk(3,2)*y2(m,1) - drk(3,3)*f )*( YI(m,1) - BY );
    
    A(a,4) = R(3,1)*x2(m,1) + R(3,2)*y2(m,1) - R(3,3)*f;
		A(a,5) = -( R(2,1)*x2(m,1) + R(2,2)*y2(m,1) - R(2,3)*f );

		A(a,p) = 0;
		A(a,p+1) = -( R(3,1)*x2(m,1) + R(3,2)*y2(m,1) - R(3,3)*f );		
		A(a,p+2) = R(2,1)*x2(m,1) + R(2,2)*y2(m,1) - R(2,3)*f;

		p=p+3;  %increment column positioning for model coordinate coefficients in A
		
    end		
end
