clear;
clc;
load Inputs\NODES -ASCII;
load Inputs\MEMBERS -ASCII;
load Inputs\MATERIALS -ASCII;
load Inputs\SECTIONS -ASCII;
load Inputs\NLOADS -ASCII;
load Inputs\BOUNDS -ASCII;
NOM = size(MEMBERS,1);%Number of members
NON = size(NODES,1);%Number of Nodes
K = zeros(2*NON,2*NON);%Truss stiffness matrix
for i=1:NOM
    NID = MEMBERS(i,1:2);
    MID = MEMBERS(i,3);
    SID  = MEMBERS(i,4);
    E     = MATERIALS(MID,1);
    A     = SECTIONS(SID,1);
    XY   = NODES(NID,:);
    Ke   = KMember(XY,E,A);
    T = T2DTruss(XY);
    Kegl = T'*Ke*T;
    for j=1:2
        for l=1:2
            K(2*NID(j)-1:2*NID(j),2*NID(l)-1:2*NID(l))=K(2*NID(j)-1:2*NID(j),2*NID(l)-1:2*NID(l))+Kegl(2*j-1:2*j,2*l-1:2*l);
        end;
    end;
end;
KFull = K;
%-----Force column matrix--------------
F = zeros(2*NON,1);
NOL = size(NLOADS,1);
for i=1:NOL
    NID = NLOADS(i,1);
    Fx = NLOADS(i,2);
    Fy = NLOADS(i,3);
    F(2*NID-1,1)=Fx;
    F(2*NID,1)=Fy;
end;
%--------Boundary conditions--------------------
NOB = size(BOUNDS,1);
for i=1:NOB
    NID = BOUNDS(i,1);
    FixedX = BOUNDS(i,2);
    FixedY = BOUNDS(i,3);
    if FixedX==1% d(2*NID,1)=0;
        K(2*NID-1,:)=0;
        K(2*NID-1,2*NID-1)=1;
        F(2*NID-1,1)=0;
    end;
    if FixedY==1% d(2*NID,1)=0;
        K(2*NID,:)=0;
        K(2*NID,2*NID)=1;
        F(2*NID,1)=0;
    end;
end;
d = K\F;
dXY = reshape(d,2,NON)';
EF = KFull*d;%External Force Vector
%-------Calculate member force----------------------
MBF = zeros(NOM,1);
for i=1:NOM%For each member
    NID = MEMBERS(i,1:2);
    XY  = NODES(NID,:);
    MID = MEMBERS(i,3);
    SID = MEMBERS(i,4);
    E    = MATERIALS(MID,1);
    A    = SECTIONS(SID,1);
    Ke   = KMember(XY,E,A);
    T = T2DTruss(XY);
    de = reshape(dXY(NID,:)',4,1);
    u = T*de;
    Fe = Ke*u;
    MBF(i)=Fe(3,1);
end;
NewNODES = NODES+10*dXY;
DrawTruss(NODES,MEMBERS,'k',2.0);
DrawTruss(NewNODES,MEMBERS,'b',1.0);
