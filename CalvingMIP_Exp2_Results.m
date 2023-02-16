%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process CalvingMIP-Experiment-2 results into NETcdf format
% Any errors, improvements or criticisms to be directed to james.rowan.jordan@ulb.be

close all
clear all

% File name for the NETcdf file. Format is CalvingMIP-Exp2-MODELNAME-INSTITUTION.nc
ExpName='CalvingMIP-Exp2-Kori-ULB.nc';

%Delete old file
 if exist(ExpName,'file')==2
   delete(ExpName);
 end

% Common results dimensions
Time1=0:1:1000; %Time for 1 year profiles
Time100=0:100:1000; %Time for 100 year snapshots
 X=-800e3:10e3:800e3;
 Y=-800e3:10e3:800e3;

 %Load line profile points

P = readtable('Circle_Profiles.csv');

%load raw data fields. I leave it up to participants to interpolate their
%own results onto the results grid. Required results fields, with units and
%dimensions are;

% VX=X velocity field, m / a^-1, 161 by 161 by 1001
% VY=Y velocity field, m / a^-1, 161 by 161 by 1001
% H=Ice thickness field, m, 161 by 161 by 1001
% Mask=Ice mask, 1 for grounded, 2 for floating, 3 for open ocean, 161 by
% 161 by 1001
% 
% VXA=X velocity field along Profile A, m / a^-1, 161 by 1001
% VYA=Y velocity field along Profile A, m / a^-1, 161 by 1001
% HA=Ice thickness field along Profile A, m, 161 by 1001
% MaskA=Ice mask along Profile A, 1 for grounded, 2 for floating, 3 for
% open ocean, 161 by 1001
% 
% VXB=X velocity field along Profile A, m / a^-1, 161 by 1001
% VYB=Y velocity field along Profile A, m / a^-1, 161 by 1001
% HB=Ice thickness field along Profile A, m, 161 by 1001
% MaskB=Ice mask along Profile A, 1 for grounded, 2 for floating, 3 for
% open ocean, 161 by 1001
% 
% VXC=X velocity field along Profile C, m / a^-1, 161 by 1
% VYC=Y velocity field along Profile C, m / a^-1, 161 by 1
% HC=Ice thickness field along Profile C, m, 161 by 1
% MaskC=Ice mask along Profile C, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1001            
% 
% VXD=X velocity field along Profile D, m / a^-1, 161 by 1001
% VYD=Y velocity field along Profile D, m / a^-1, 161 by 1001
% HD=Ice thickness field along Profile D, m, 161 by 1001
% MaskD=Ice mask along Profile D, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1001 

load Exp2Kori.mat

nccreate(ExpName,'VX','Dimensions',{'X' 161 'Y' 161 'Time100' numel(Time100)})
nccreate(ExpName,'VY','Dimensions',{'X' 161 'Y' 161 'Time100' numel(Time100)})
nccreate(ExpName,'H','Dimensions',{'X' 161 'Y' 161 'Time100' numel(Time100)})
nccreate(ExpName,'Mask','Dimensions',{'X' 161 'Y' 161 'Time100' numel(Time100)})

nccreate(ExpName,'Time1','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'Time100','Dimensions',{'Time100' numel(Time100)})
nccreate(ExpName,'X','Dimensions',{'X' 161})
nccreate(ExpName,'Y','Dimensions',{'Y' 161})

nccreate(ExpName,'Profile_A_Thickness','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_A_Distance','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_A_UVel','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_A_VVel','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_A_Mask','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})

nccreate(ExpName,'Profile_B_Thickness','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_B_Distance','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_B_UVel','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_B_VVel','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_B_Mask','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})

nccreate(ExpName,'Profile_C_Thickness','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_C_Distance','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_C_UVel','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_C_VVel','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_C_Mask','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})

nccreate(ExpName,'Profile_D_Thickness','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_D_Distance','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_D_UVel','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_D_VVel','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_D_Mask','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})

ncwrite(ExpName,'X',X)
ncwrite(ExpName,'Y',Y)
ncwrite(ExpName,'VX',VX)
ncwrite(ExpName,'VY',VY)
ncwrite(ExpName,'H',Hice)
ncwrite(ExpName,'Mask',Mask)


ncwrite(ExpName,'Profile_A_Thickness',H1)
ncwrite(ExpName,'Profile_A_Distance',P.Circle_Profile_A_S)
ncwrite(ExpName,'Profile_A_UVel',VX1)
ncwrite(ExpName,'Profile_A_VVel',VY1)
ncwrite(ExpName,'Profile_A_VVel',M1)

ncwrite(ExpName,'Profile_B_Thickness',H2)
ncwrite(ExpName,'Profile_B_Distance',P.Circle_Profile_B_S)
ncwrite(ExpName,'Profile_B_UVel',VX2)
ncwrite(ExpName,'Profile_B_VVel',VY2)
ncwrite(ExpName,'Profile_B_VVel',M2)

ncwrite(ExpName,'Profile_C_Thickness',H3)
ncwrite(ExpName,'Profile_C_Distance',P.Circle_Profile_C_S)
ncwrite(ExpName,'Profile_C_UVel',VX3)
ncwrite(ExpName,'Profile_C_VVel',VY3)
ncwrite(ExpName,'Profile_C_VVel',M3)

ncwrite(ExpName,'Profile_D_Thickness',H4)
ncwrite(ExpName,'Profile_D_Distance',P.Circle_Profile_D_S)
ncwrite(ExpName,'Profile_D_UVel',VX4)
ncwrite(ExpName,'Profile_D_VVel',VY4)
ncwrite(ExpName,'Profile_D_VVel',M4)

ncwriteatt(ExpName,'Profile_A_Thickness','Units','m');
ncwriteatt(ExpName,'Profile_A_Distance','Units','m');
ncwriteatt(ExpName,'Profile_A_UVel','Units','m a-1');
ncwriteatt(ExpName,'Profile_A_VVel','Units','m a-1');

ncwriteatt(ExpName,'Profile_B_Thickness','Units','m');
ncwriteatt(ExpName,'Profile_B_Distance','Units','m');
ncwriteatt(ExpName,'Profile_B_UVel','Units','m a-1');
ncwriteatt(ExpName,'Profile_B_VVel','Units','m a-1');

ncwriteatt(ExpName,'Profile_C_Thickness','Units','m');
ncwriteatt(ExpName,'Profile_C_Distance','Units','m');
ncwriteatt(ExpName,'Profile_C_UVel','Units','m a-1');
ncwriteatt(ExpName,'Profile_C_VVel','Units','m a-1');

ncwriteatt(ExpName,'Profile_D_Thickness','Units','m');
ncwriteatt(ExpName,'Profile_D_Distance','Units','m');
ncwriteatt(ExpName,'Profile_D_UVel','Units','m a-1');
ncwriteatt(ExpName,'Profile_D_VVel','Units','m a-1');


ncdisp(ExpName)





