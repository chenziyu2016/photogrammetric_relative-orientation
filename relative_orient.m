clc

format long
% DATA MATRIX
%photo 1 coordinates
x1= [
   0.966
  -0.798
  -2.511
  92.337
  96.602
  85.156
];

y1=[
 -88.738
   1.403
  92.055
 -88.145
   3.491
  90.647
];

%photo 2 coordinates
x2=[
 -91.627
 -89.994
 -88.824
  -1.022
   0.818
   2.595
];

y2=[
 -86.419
   4.162
  95.641
 -89.392
   2.564
  90.518
];

%focal length of camera (meters) m
f = 152;


%if data points 1 through 6 are the six standard locations, (Von-Gruber points),
 %% and a foward overlap of 60% as well as 25% sidelap assumed:
  %%% initial parameters are then estimated as:

%assumed base component, BX, BY, BZ (meters) m
BX = 200;
BY = 0;
BZ = 0;

%- aprox orientation parameters of photo 2 w.r.t photo 1 , all approximated to zero
w2 = 0;  % delta omega 2 dw2
p2 = 0;  % delta phi 2   dp2
k2 = 0 ; % delta kappa 2 dk2

%- aprox model coordinates: 
%% XI and YI to be scaled by a factor BX/92
XI = [
	0
 92
	0
 92
	0
 92
] * 200/92;

YI = [
  0
  0
 86.25
 86.25
-86.25
-86.25
] * 200/92;

ZI = [
	-f
	-f
	-f
	-f
	-f
	-f
] * 200/92;

%matrix of initial parameters IP
IP = [
	BX
	BY
	BZ
	XI
	YI
	ZI
];

%rotational matrix R
R = getR(w2, p2, k2);

%differentials of rotational elements

drw = getOmegaDiff(w2, p2, k2);

drp = getPhiDiff(w2, p2, k2);

drk = getKappaDiff(w2, p2, k2);

%number of data points n :
n = length(x1); %  = len(y1) =len(XI) = len(YI) =len(ZI)!


%first iteration values

A = getA(x1, y1, x2, y2, BX, BY, BZ, XI, YI, ZI, R, drw, drp, drk, f, n);

L = getL(x1, y1, x2, y2, BX, BY, BZ, XI, YI, ZI, R, f, n);

dx = getdx(A,L)


% residual matrix v
v = - L - (A * dx);

sigma = sqrt(v' * v );

exx = sigma * inv(A' * A);

variances = diag(exx);

deviations = sqrt(variances)

% subsequent iteration to convergence
% while (dx - getdx(A,L) ~= zeros(length(dx),1))
% for i = 1:10
% 	% change in unknowns BY, BZ, Omega(w), Phi(p) and Kappa(k) respectively are:
% 	cw2 = dx(1:1);
% 	cp2 = dx(2:1);
% 	ck2 = dx(3:1);

% 	cBY = dx(4:1);
% 	cBZ = dx(5:1);

% 	% changes in the model coordinates
  
%   cXI;  cYI;  cZI;

% 	p = 6;
% 	for m = 1: 6

% 		cXI(m,1) = dx(p,1);
% 		cYI(m,1) = dx(p+1,1);
% 	  cZI(m,1) = dx(p+2,1);

% 	  p = p + 3;
% 	end

% 	%modified values:  effecting the changes:: value + change in value.

% 	%rotationals
% 	w2 = w2 + cw2
% 	p2 = p2 + cp2
% 	k2 = k2 + ck2

% 	% base components
% 	BY = BY + cBY
% 	BZ = BZ + cBZ

% 	% model coordinates
% 	XI = XI + cXI;
% 	YI = YI + cYI;
% 	ZI = ZI + cZI;

%   %rotational matrix R
%   R = getR(w2, p2, k2)

%   %differential
% 	drw = getOmegaDiff(w2, p2, k2)
% 	drp = getPhiDiff(w2, p2, k2)
% 	drk = getKappaDiff(w2, p2, k2)

% 	A = getA(x1, y1, x2, y2, BX, BY, BZ, XI, YI, ZI, R, drw, drp, drk, f, n);

% 	L = getL(x1, y1, x2, y2, BX, BY, BZ, XI, YI, ZI, R, f, n);

% 	dx = getdx(A,L)

% end
