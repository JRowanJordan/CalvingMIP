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

nccreate(ExpName,'Profile_A_H','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_A_S','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_A_VX','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_A_VY','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_A_Mask','Dimensions',{'Profile A' numel(HA) 'Time1' numel(Time1)})

nccreate(ExpName,'Profile_B_H','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_B_S','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_B_VX','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_B_VY','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_B_Mask','Dimensions',{'Profile B' numel(HB) 'Time1' numel(Time1)})

nccreate(ExpName,'Profile_C_H','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_C_S','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_C_VX','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_C_VY','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_C_Mask','Dimensions',{'Profile C' numel(HC) 'Time1' numel(Time1)})

nccreate(ExpName,'Profile_D_H','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_D_S','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_D_VX','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_D_VY','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})
nccreate(ExpName,'Profile_D_Mask','Dimensions',{'Profile D' numel(HD) 'Time1' numel(Time1)})

ncwrite(ExpName,'Time1',Time1)
ncwrite(ExpName,'Time100',Time100)
ncwrite(ExpName,'X',X)
ncwrite(ExpName,'Y',Y)
ncwrite(ExpName,'VX',VX)
ncwrite(ExpName,'VY',VY)
ncwrite(ExpName,'H',H)
ncwrite(ExpName,'Mask',Mask)

ncwrite(ExpName,'Profile_A_H',HA)
ncwrite(ExpName,'Profile_A_S',P.Circle_Profile_A_S)
ncwrite(ExpName,'Profile_A_VX',VXA)
ncwrite(ExpName,'Profile_A_VY',VYA)
ncwrite(ExpName,'Profile_A_Mask',MA)

ncwrite(ExpName,'Profile_B_H',HB)
ncwrite(ExpName,'Profile_B_S',P.Circle_Profile_B_S)
ncwrite(ExpName,'Profile_B_VX',VXB)
ncwrite(ExpName,'Profile_B_VY',VYB)
ncwrite(ExpName,'Profile_B_Mask',MB)

ncwrite(ExpName,'Profile_C_H',HC)
ncwrite(ExpName,'Profile_C_S',P.Circle_Profile_C_S)
ncwrite(ExpName,'Profile_C_VX',VXC)
ncwrite(ExpName,'Profile_C_VY',VYC)
ncwrite(ExpName,'Profile_C_Mask',MC)

ncwrite(ExpName,'Profile_D_H',HD)
ncwrite(ExpName,'Profile_D_S',P.Circle_Profile_D_S)
ncwrite(ExpName,'Profile_D_VX',VXD)
ncwrite(ExpName,'Profile_D_VY',VYD)
ncwrite(ExpName,'Profile_D_Mask',MD)

ncwriteatt(ExpName,'Profile_A_H','Units','m');
ncwriteatt(ExpName,'Profile_A_S','Units','m');
ncwriteatt(ExpName,'Profile_A_VX','Units','m a-1');
ncwriteatt(ExpName,'Profile_A_VY','Units','m a-1');

ncwriteatt(ExpName,'Profile_B_H','Units','m');
ncwriteatt(ExpName,'Profile_B_S','Units','m');
ncwriteatt(ExpName,'Profile_B_VX','Units','m a-1');
ncwriteatt(ExpName,'Profile_B_VY','Units','m a-1');

ncwriteatt(ExpName,'Profile_C_H','Units','m');
ncwriteatt(ExpName,'Profile_C_S','Units','m');
ncwriteatt(ExpName,'Profile_C_VX','Units','m a-1');
ncwriteatt(ExpName,'Profile_C_VY','Units','m a-1');

ncwriteatt(ExpName,'Profile_D_H','Units','m');
ncwriteatt(ExpName,'Profile_D_S','Units','m');
ncwriteatt(ExpName,'Profile_D_VX','Units','m a-1');
ncwriteatt(ExpName,'Profile_D_VY','Units','m a-1');

ncdisp(ExpName)
