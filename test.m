clc

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
f = 0.152;

%if data points 1 through 6 are the six standard locations, (Von-Gruber points),
 %% and a foward overlap of 60% as well as 25% sidelap assumed:
  %%% initial parameters are then estimated as:

%assumed base component, BX, BY, BZ (meters) m
BX = 200
BY = 0
BZ = 0

%- aprox orientation parameters of photo 2 w.r.t photo 1 , all approximated to zero
w2 = 0  % delta omega 2 dw2
p2 = 0  % delta phi 2   dp2
k2 = 0  % delta kappa 2 dk2

%- aprox model coordinates: 
%% XI and YI to be scaled by a factor BX/92
XI = [
	0
 92
	0
 92
	0
 92
]

YI = [
  0
  0
 86.25
 86.25
-86.25
-86.25
]

ZI = [
	-f
	-f
	-f
	-f
	-f
	-f
]

%matrix of initial parameters IP
IP = [
	BX
	BY
	BZ
	XI
	YI
	ZI
];

%Rotational elements rij
r11 = cos(p2)*cos(k2);  
r12 = cos(w2)*sin(k2) + sin(w2)*sin(p2)*cos(k2);
r13 = sin(w2)*sin(k2) - cos(w2)*sin(p2)*cos(k2);

r21 = -cos(p2)*sin(k2);
r22 = cos(w2)*cos(k2) + cos(w2)*sin(p2)*sin(k2);
r23 = sin(w2)*cos(k2) + cos(w2)*sin(p2)*sin(k2);

r31 = sin(p2);
r32 = -sin(w2)*cos(p2);
r33 = cos(w2)*cos(p2);

R = [
	r11 r12 r13
	r21 r22 r23
	r31 r32 r33
];

	% replacement elements elements used for shorter code:

	a1 = cos(w2);
	a2 = cos(p2);
	a3 = cos(k2);  %cosines of rotational

	b1 = sin(w2);
	b2 = sin(p2);
	b3 = sin(k2);  %sines of rotational


%differentials of rotational elements
dr11w =  0;                  dr11p = -b2*a3;       dr11k = -a2*b3;
dr12w = -b1*b3 + a1*b2*a3;   dr12p =  b1*a2*a3;    dr12k =  a1*a3 - b1*b2*b3;
dr13w =  a1*b3 + b1*b2*a3;   dr13p = -a1*a2*a3;    dr13k =  b1*a3 + a1*b2*b3;

dr21w =  0;                  dr21p =  b2*b3;       dr21k = -a2*a3;
dr22w = -b1*a3 - a1*b2*b3;   dr22p = -b1*a2*b3;    dr22k = -a1*b3 - b1*b2*a3;
dr23w =  a1*a3 - b1*b2*b3;   dr23p =  a1*a2*b3;    dr23k = -b1*b3 + a1*b2*a3;

dr31w =  0;                  dr31p =  a2;          dr31k = 0;
dr32w = -a1*a2;              dr32p =  b1*b2;       dr32k = 0;
dr33w = -b1*a2;              dr33p = -a1*b2;       dr33k = 0;

drw = [
	dr11w dr12w dr13w
	dr21w dr22w dr23w
	dr31w dr32w dr33w
];

drp = [
	dr11p dr12p dr13p
	dr21p dr22p dr23p
	dr31p dr32p dr33p
];

drk = [
	dr11k dr12k dr13k
	dr21k dr22k dr23k
	dr31k dr32k dr33k
];

%number of data points n :
n = length(x1); %  = len(y) =len(XI) = len(YI) =len(ZI)!

A = getA(x1, y1, x2, y2, IP, R, drw, drp, drk, f);