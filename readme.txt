2D-Truss ReadMe File
CE 432 Project

Program Explained
	Phase 1 - Variable Creation
		Loads Data Input Files
		Defines Values for MEMBERS count and NODES count
		Creates Blank Global Stiffness Matrix for system (S)
	Phase 2 - Global Stiffness Matrix
		For Loop
			Defines Nodes, MoE, and Area of designated member (dm)
			Creates Nodal Coordinate Matrix for dm
			Calls FUNCTION (Ke = KMember(XY,E,A); --> See "Adjacent Functions
			Calls FUNCTION (T = T2DTruss(XY); --> See Adjacent Functions
			Creates Global Stiffness Matrix for dm (Kegl)
			For Loop (row and column counter)
				Time to Populate the System Stiffness Matrix!
					K(ij) = K(ij) + Kegl(i,j)
	Phase 3 - Force Column Matrix
	Phase 4 - Boundary Conditions
	Phase 5 - Calculate Member Force
	Phase 6 - Draw Truss

Called Functions
	
	
	
Data Input:
	NODES
		Column 1: 	X Coordinate
		Column 2: 	Y Coordinate
	MEMBERS
		Column 1: 	Node 1
		Column 2: 	Node 2
		Column 3: 	Material ID (row number for modulus of elasticity)
		Column 4: 	Section ID (row number for Area)
	MATERIALS
		Row 1:		Modulus of Elasticity (called in MEMBERS(:,3))
	SECTIONS
		Row 1:		Section Area (called in MEMBERS(:,4))
	NLOADS
		Column 1:	Node ID that force is acting on
		Column 2:	Force (kips) in X direction, Right is positive
		Column 3:	Force (kips) in Y direction, Up is positive
	BOUNDS
		Column 1:	Node ID that for support
		Column 2:	Fixed in X? (1 for yes, 0 for no)
		Column 3:	Fixed in Y? (1 for yes, 0 for no)