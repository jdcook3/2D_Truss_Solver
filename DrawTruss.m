function DrawTruss(NODES,MEMBERS,CL,LW)
%CL: Color
%LW: Linewidth
NON = size(NODES,1);
NOM = size(MEMBERS,1);
for i=1:NOM
    NID = MEMBERS(i,1:2);
    XY = NODES(NID,:);
    line(XY(:,1),XY(:,2),'color',CL,'linewidth',LW);
end;
MaxX = max(NODES(:,1)); %Furthest right X coordinate
MinX = min(NODES(:,1)); %Furthest left X coordinate
Lx = MaxX-MinX; %Range on X-axis
MaxY = max(NODES(:,2)); %Highest Y coordinate
MinY = min(NODES(:,2)); %Lowest Y Coordinate
Ly = MaxY-MinY; %Range on Y-axis
axis([MinX-0.1*Lx MaxX+0.1*Lx MinY MaxY+0.1*Ly]); %widens the plot to beyond truss/frame
grid on;