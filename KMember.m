function Ke = KMember(XY,E,A)
%This function is to calculate member stiffness marix
L = sqrt((XY(1,1)-XY(2,1))^2+(XY(1,2)-XY(2,2))^2); %Calculates Member Length
Ke = (E*A/L)*[1,0,-1,0;0,0,0,0;-1,0,1,0;0,0,0,0]; %Populates 2D Stiffness Matrix (Local)