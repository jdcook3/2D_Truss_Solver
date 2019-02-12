function T = T2DTruss(XY)
L = sqrt((XY(2,1)-XY(1,1))^2+(XY(2,2)-XY(1,2))^2); %Calculates Member Length
C = (XY(2,1)-XY(1,1))/L; %cos(theta)=(X2-X1)/L
S = (XY(2,2)-XY(1,2))/L; %sin(theta)=(Y2-Y1)/L
T = [C,S,0,0;-S,C,0,0;0,0,C,S;0,0,-S,C]; %Populates 2D Transformation Matrix