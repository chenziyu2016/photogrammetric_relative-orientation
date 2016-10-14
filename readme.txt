Project Relative Orientation:
----------------------------

The code hosted in this folder executes the Photogrammetric process of relative orientation through the collinearity condition equations.

Given some set of pairs of photo coordinates (6 in this case), the objective is to compute the values for the six unknowns consisting of:
	
	The base components
	-BX, BY and BZ

	The orientation elements of photo 2 relative to photo 1
	-dw2, dp2, dk2

	The model point coordinates formed by intersection of the conjugate image rays
	-XI, YI, ZI

The process followed here aims to derive these unknowns as a step to the use of collinearity conditions for bundle method of relative orientation R.O.

_____________________________
The University of Nairobi,
Department of Geospatial and Space Technology.
FGE 442- PHOTOGRAMMETRY 2B

-----------------------------
Code by: Konuko Jodom
CC: Peter Nthei
Lec: Dr. Wakoli 