%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process CalvingMIP-Experiment-1 results into NETcdf format
% Any errors, improvements or criticisms to be directed to james.rowan.jordan@ulb.be

close all
clear all

% File name for the NETcdf file. Format is CalvingMIP-Exp1-MODELNAME-INSTITUTION.nc
ExpName='CalvingMIP-Exp1-Kori-ULB.nc';

%Delete old file
 if exist(ExpName,'file')==2
   delete(ExpName);
 end

% Common results dimensions
Time=0;
 X=-800e3:10e3:800e3;
 Y=-800e3:10e3:800e3;

 %Load line profile points

P = readtable('Circle_Profiles.csv');

%load raw data fields. I leave it up to participants to interpolate their
%own results onto the results grid. Required results fields, with units and
%dimensions are;

% VX=X velocity field, m / a^-1, 161 by 161 by 1
% VY=Y velocity field, m / a^-1, 161 by 161 by 1
% H=Ice thickness field, m, 161 by 161 by 1
% Mask=Ice mask, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 161 by 1
% 
% VXA=X velocity field along Profile A, m / a^-1, 161 by 1
% VYA=Y velocity field along Profile A, m / a^-1, 161 by 1
% HA=Ice thickness field along Profile A, m, 161 by 1
% MaskA=Ice mask along Profile A, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1
% 
% VXB=X velocity field along Profile A, m / a^-1, 161 by 1
% VYB=Y velocity field along Profile A, m / a^-1, 161 by 1
% HB=Ice thickness field along Profile A, m, 161 by 1
% MaskB=Ice mask along Profile A, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1
% 
% VXC=X velocity field along Profile C, m / a^-1, 161 by 1
% VYC=Y velocity field along Profile C, m / a^-1, 161 by 1
% HC=Ice thickness field along Profile C, m, 161 by 1
% MaskC=Ice mask along Profile C, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1            
% 
% VXD=X velocity field along Profile D, m / a^-1, 161 by 1
% VYD=Y velocity field along Profile D, m / a^-1, 161 by 1
% HD=Ice thickness field along Profile D, m, 161 by 1
% MaskD=Ice mask along Profile D, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1 

 load Exp1Kori.mat

nccreate(ExpName,'VX','Dimensions',{'X' 161 'Y' 161 'Time' numel(Time)})
nccreate(ExpName,'VY','Dimensions',{'X' 161 'Y' 161 'Time' numel(Time)})
nccreate(ExpName,'H','Dimensions',{'X' 161 'Y' 161 'Time' numel(Time)})
nccreate(ExpName,'Mask','Dimensions',{'X' 161 'Y' 161 'Time' numel(Time)})

nccreate(ExpName,'Time','Dimensions',{'Time' numel(Time)})
nccreate(ExpName,'X','Dimensions',{'X' 161})
nccreate(ExpName,'Y','Dimensions',{'Y' 161})

nccreate(ExpName,'Profile_A_H','Dimensions',{'Profile A' numel(HA)})
nccreate(ExpName,'Profile_A_S','Dimensions',{'Profile A' numel(HA)})
nccreate(ExpName,'Profile_A_UVel','Dimensions',{'Profile A' numel(HA)})
nccreate(ExpName,'Profile_A_VVel','Dimensions',{'Profile A' numel(HA)})
nccreate(ExpName,'Profile_A_Mask','Dimensions',{'Profile A' numel(HA)})

nccreate(ExpName,'Profile_B_H','Dimensions',{'Profile B' numel(HB)})
nccreate(ExpName,'Profile_B_S','Dimensions',{'Profile B' numel(HB)})
nccreate(ExpName,'Profile_B_UVel','Dimensions',{'Profile B' numel(HB)})
nccreate(ExpName,'Profile_B_VVel','Dimensions',{'Profile B' numel(HB)})
nccreate(ExpName,'Profile_B_Mask','Dimensions',{'Profile B' numel(HB)})

nccreate(ExpName,'Profile_C_H','Dimensions',{'Profile C' numel(HC)})
nccreate(ExpName,'Profile_C_S','Dimensions',{'Profile C' numel(HC)})
nccreate(ExpName,'Profile_C_UVel','Dimensions',{'Profile C' numel(HC)})
nccreate(ExpName,'Profile_C_VVel','Dimensions',{'Profile C' numel(HC)})
nccreate(ExpName,'Profile_C_Mask','Dimensions',{'Profile C' numel(HC)})

nccreate(ExpName,'Profile_D_H','Dimensions',{'Profile D' numel(HD)})
nccreate(ExpName,'Profile_D_S','Dimensions',{'Profile D' numel(HD)})
nccreate(ExpName,'Profile_D_UVel','Dimensions',{'Profile D' numel(HD)})
nccreate(ExpName,'Profile_D_VVel','Dimensions',{'Profile D' numel(HD)})
nccreate(ExpName,'Profile_D_Mask','Dimensions',{'Profile D' numel(HD)})

ncwrite(ExpName,'Time',Time)
ncwrite(ExpName,'X',X)
ncwrite(ExpName,'Y',Y)
ncwrite(ExpName,'VX',VX)
ncwrite(ExpName,'VY',VY)
ncwrite(ExpName,'H',H)
ncwrite(ExpName,'Mask',Mask)

ncwrite(ExpName,'Profile_A_H',HA)
ncwrite(ExpName,'Profile_A_S',P.Circle_Profile_A_S)
ncwrite(ExpName,'Profile_A_UVel',VXA)
ncwrite(ExpName,'Profile_A_VVel',VYA)
ncwrite(ExpName,'Profile_A_VVel',MA)

ncwrite(ExpName,'Profile_B_H',HB)
ncwrite(ExpName,'Profile_B_S',P.Circle_Profile_B_S)
ncwrite(ExpName,'Profile_B_UVel',VXB)
ncwrite(ExpName,'Profile_B_VVel',VYB)
ncwrite(ExpName,'Profile_B_VVel',MB)

ncwrite(ExpName,'Profile_C_H',HC)
ncwrite(ExpName,'Profile_C_S',P.Circle_Profile_C_S)
ncwrite(ExpName,'Profile_C_UVel',VXC)
ncwrite(ExpName,'Profile_C_VVel',VYC)
ncwrite(ExpName,'Profile_C_VVel',MC)

ncwrite(ExpName,'Profile_D_H',HD)
ncwrite(ExpName,'Profile_D_S',P.Circle_Profile_D_S)
ncwrite(ExpName,'Profile_D_UVel',VXD)
ncwrite(ExpName,'Profile_D_VVel',VYD)
ncwrite(ExpName,'Profile_D_VVel',MD)

ncwriteatt(ExpName,'Profile_A_H','Units','m');
ncwriteatt(ExpName,'Profile_A_S','Units','m');
ncwriteatt(ExpName,'Profile_A_UVel','Units','m a-1');
ncwriteatt(ExpName,'Profile_A_VVel','Units','m a-1');

ncwriteatt(ExpName,'Profile_B_H','Units','m');
ncwriteatt(ExpName,'Profile_B_S','Units','m');
ncwriteatt(ExpName,'Profile_B_UVel','Units','m a-1');
ncwriteatt(ExpName,'Profile_B_VVel','Units','m a-1');

ncwriteatt(ExpName,'Profile_C_H','Units','m');
ncwriteatt(ExpName,'Profile_C_S','Units','m');
ncwriteatt(ExpName,'Profile_C_UVel','Units','m a-1');
ncwriteatt(ExpName,'Profile_C_VVel','Units','m a-1');

ncwriteatt(ExpName,'Profile_D_H','Units','m');
ncwriteatt(ExpName,'Profile_D_S','Units','m');
ncwriteatt(ExpName,'Profile_D_UVel','Units','m a-1');
ncwriteatt(ExpName,'Profile_D_VVel','Units','m a-1');

ncdisp(ExpName)






