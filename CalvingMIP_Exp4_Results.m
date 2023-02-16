%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process CalvingMIP-Experiment-3 results into NETcdf format
% Any errors, improvements or criticisms to be directed to james.rowan.jordan@ulb.be

close all
clear all

% File name for the NETcdf file. Format is CalvingMIP-Exp4-MODELNAME-INSTITUTION.nc
ExpName='CalvingMIP-Exp4-Kori-ULB.nc';

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

P = readtable('Caprona_Profiles.csv');
Q = readtable('Halbrane_Profiles.csv');

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

load Exp4Kori.mat

nccreate(ExpName,'VX','Dimensions',{'X' 161 'Y' 161 'Time100' numel(Time100)})
nccreate(ExpName,'VY','Dimensions',{'X' 161 'Y' 161 'Time100' numel(Time100)})
nccreate(ExpName,'H','Dimensions',{'X' 161 'Y' 161 'Time100' numel(Time100)})
nccreate(ExpName,'Mask','Dimensions',{'X' 161 'Y' 161 'Time100' numel(Time100)})

nccreate(ExpName,'Time1','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'Time100','Dimensions',{'Time100' numel(Time100)})
nccreate(ExpName,'X','Dimensions',{'X' 161})
nccreate(ExpName,'Y','Dimensions',{'Y' 161})

nccreate(ExpName,'Caprona_A_H','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_A_S','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_A_VX','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_A_VY','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_A_Mask','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X) 'Time1' numel(Time1)})

nccreate(ExpName,'Caprona_B_H','Dimensions',{'Caprona B' numel(P.Caprona_Profile_B_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_B_S','Dimensions',{'Caprona B' numel(P.Caprona_Profile_B_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_B_VX','Dimensions',{'Caprona B' numel(P.Caprona_Profile_B_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_B_VY','Dimensions',{'Caprona B' numel(P.Caprona_Profile_B_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_B_Mask','Dimensions',{'Caprona B' numel(P.Caprona_Profile_B_X) 'Time1' numel(Time1)})

nccreate(ExpName,'Caprona_C_H','Dimensions',{'Caprona C' numel(P.Caprona_Profile_C_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_C_S','Dimensions',{'Caprona C' numel(P.Caprona_Profile_C_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_C_VX','Dimensions',{'Caprona C' numel(P.Caprona_Profile_C_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_C_VY','Dimensions',{'Caprona C' numel(P.Caprona_Profile_C_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_C_Mask','Dimensions',{'Caprona C' numel(P.Caprona_Profile_C_X) 'Time1' numel(Time1)})

nccreate(ExpName,'Caprona_D_H','Dimensions',{'Caprona D' numel(P.Caprona_Profile_D_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_D_S','Dimensions',{'Caprona D' numel(P.Caprona_Profile_D_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_D_VX','Dimensions',{'Caprona D' numel(P.Caprona_Profile_D_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_D_VY','Dimensions',{'Caprona D' numel(P.Caprona_Profile_D_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Caprona_D_Mask','Dimensions',{'Caprona D' numel(P.Caprona_Profile_D_X) 'Time1' numel(Time1)})

nccreate(ExpName,'Halbrane_A_H','Dimensions',{'Halbrane A' numel(Q.Halbrane_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_A_S','Dimensions',{'Halbrane A' numel(Q.Halbrane_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_A_VX','Dimensions',{'Halbrane A' numel(Q.Halbrane_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_A_VY','Dimensions',{'Halbrane A' numel(Q.Halbrane_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_A_Mask','Dimensions',{'Halbrane A' numel(Q.Halbrane_Profile_A_X) 'Time1' numel(Time1)})

nccreate(ExpName,'Halbrane_B_H','Dimensions',{'Halbrane B' numel(Q.Halbrane_Profile_B_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_B_S','Dimensions',{'Halbrane B' numel(Q.Halbrane_Profile_B_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_B_VX','Dimensions',{'Halbrane B' numel(Q.Halbrane_Profile_B_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_B_VY','Dimensions',{'Halbrane B' numel(Q.Halbrane_Profile_B_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_B_Mask','Dimensions',{'Halbrane B' numel(Q.Halbrane_Profile_B_X) 'Time1' numel(Time1)})

nccreate(ExpName,'Halbrane_C_H','Dimensions',{'Halbrane C' numel(Q.Halbrane_Profile_C_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_C_S','Dimensions',{'Halbrane C' numel(Q.Halbrane_Profile_C_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_C_VX','Dimensions',{'Halbrane C' numel(Q.Halbrane_Profile_C_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_C_VY','Dimensions',{'Halbrane C' numel(Q.Halbrane_Profile_C_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_C_Mask','Dimensions',{'Halbrane C' numel(Q.Halbrane_Profile_C_X) 'Time1' numel(Time1)})

nccreate(ExpName,'Halbrane_D_H','Dimensions',{'Halbrane D' numel(Q.Halbrane_Profile_D_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_D_S','Dimensions',{'Halbrane D' numel(Q.Halbrane_Profile_D_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_D_VX','Dimensions',{'Halbrane D' numel(Q.Halbrane_Profile_D_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_D_VY','Dimensions',{'Halbrane D' numel(Q.Halbrane_Profile_D_X) 'Time1' numel(Time1)})
nccreate(ExpName,'Halbrane_D_Mask','Dimensions',{'Halbrane D' numel(Q.Halbrane_Profile_D_X) 'Time1' numel(Time1)})


ncwrite(ExpName,'X',X)
ncwrite(ExpName,'Y',Y)
ncwrite(ExpName,'VX',VX)
ncwrite(ExpName,'VY',VY)
ncwrite(ExpName,'H',H)
ncwrite(ExpName,'Mask',Mask)


ncwrite(ExpName,'Halbrane_A_H',HHALA)
ncwrite(ExpName,'Halbrane_A_S',Q.Halbrane_Profile_A_S)
ncwrite(ExpName,'Halbrane_A_VX',VXHALA)
ncwrite(ExpName,'Halbrane_A_VY',VYHALA)
ncwrite(ExpName,'Halbrane_A_Mask',MHALA)

ncwrite(ExpName,'Halbrane_B_H',HHALB)
ncwrite(ExpName,'Halbrane_B_S',Q.Halbrane_Profile_B_S)
ncwrite(ExpName,'Halbrane_B_VX',VXHALB)
ncwrite(ExpName,'Halbrane_B_VY',VYHALB)
ncwrite(ExpName,'Halbrane_B_Mask',MHALB)

ncwrite(ExpName,'Halbrane_C_H',HHALC)
ncwrite(ExpName,'Halbrane_C_S',Q.Halbrane_Profile_C_S)
ncwrite(ExpName,'Halbrane_C_VX',VXHALC)
ncwrite(ExpName,'Halbrane_C_VY',VYHALC)
ncwrite(ExpName,'Halbrane_C_Mask',MHALC)

ncwrite(ExpName,'Halbrane_D_H',HHALD)
ncwrite(ExpName,'Halbrane_D_S',Q.Halbrane_Profile_D_S)
ncwrite(ExpName,'Halbrane_D_VX',VXHALD)
ncwrite(ExpName,'Halbrane_D_VY',VYHALD)
ncwrite(ExpName,'Halbrane_D_Mask',MHALD)

ncwrite(ExpName,'Caprona_A_H',HCAPA)
ncwrite(ExpName,'Caprona_A_S',P.Caprona_Profile_A_S)
ncwrite(ExpName,'Caprona_A_VX',VXCAPA)
ncwrite(ExpName,'Caprona_A_VY',VYCAPA)
ncwrite(ExpName,'Caprona_A_Mask',MCAPA)

ncwrite(ExpName,'Caprona_B_H',HCAPB)
ncwrite(ExpName,'Caprona_B_S',P.Caprona_Profile_B_S)
ncwrite(ExpName,'Caprona_B_VX',VXCAPB)
ncwrite(ExpName,'Caprona_B_VY',VYCAPB)
ncwrite(ExpName,'Caprona_B_Mask',MCAPB)

ncwrite(ExpName,'Caprona_C_H',HCAPC)
ncwrite(ExpName,'Caprona_C_S',P.Caprona_Profile_C_S)
ncwrite(ExpName,'Caprona_C_VX',VXCAPC)
ncwrite(ExpName,'Caprona_C_VY',VYCAPC)
ncwrite(ExpName,'Caprona_C_Mask',MCAPC)

ncwrite(ExpName,'Caprona_D_H',HCAPD)
ncwrite(ExpName,'Caprona_D_S',P.Caprona_Profile_D_S)
ncwrite(ExpName,'Caprona_D_VX',VXCAPD)
ncwrite(ExpName,'Caprona_D_VY',VYCAPD)
ncwrite(ExpName,'Caprona_D_Mask',MCAPD)

ncwriteatt(ExpName,'Caprona_A_H','Units','m');
ncwriteatt(ExpName,'Caprona_A_S','Units','m');
ncwriteatt(ExpName,'Caprona_A_VX','Units','m a-1');
ncwriteatt(ExpName,'Caprona_A_VY','Units','m a-1');

ncwriteatt(ExpName,'Caprona_B_H','Units','m');
ncwriteatt(ExpName,'Caprona_B_S','Units','m');
ncwriteatt(ExpName,'Caprona_B_VX','Units','m a-1');
ncwriteatt(ExpName,'Caprona_B_VY','Units','m a-1');

ncwriteatt(ExpName,'Caprona_C_H','Units','m');
ncwriteatt(ExpName,'Caprona_C_S','Units','m');
ncwriteatt(ExpName,'Caprona_C_VX','Units','m a-1');
ncwriteatt(ExpName,'Caprona_C_VY','Units','m a-1');

ncwriteatt(ExpName,'Caprona_D_H','Units','m');
ncwriteatt(ExpName,'Caprona_D_S','Units','m');
ncwriteatt(ExpName,'Caprona_D_VX','Units','m a-1');
ncwriteatt(ExpName,'Caprona_D_VY','Units','m a-1');

ncwriteatt(ExpName,'Halbrane_A_H','Units','m');
ncwriteatt(ExpName,'Halbrane_A_S','Units','m');
ncwriteatt(ExpName,'Halbrane_A_VX','Units','m a-1');
ncwriteatt(ExpName,'Halbrane_A_VY','Units','m a-1');

ncwriteatt(ExpName,'Halbrane_B_H','Units','m');
ncwriteatt(ExpName,'Halbrane_B_S','Units','m');
ncwriteatt(ExpName,'Halbrane_B_VX','Units','m a-1');
ncwriteatt(ExpName,'Halbrane_B_VY','Units','m a-1');

ncwriteatt(ExpName,'Halbrane_C_H','Units','m');
ncwriteatt(ExpName,'Halbrane_C_S','Units','m');
ncwriteatt(ExpName,'Halbrane_C_VX','Units','m a-1');
ncwriteatt(ExpName,'Halbrane_C_VY','Units','m a-1');

ncwriteatt(ExpName,'Halbrane_D_H','Units','m');
ncwriteatt(ExpName,'Halbrane_D_S','Units','m');
ncwriteatt(ExpName,'Halbrane_D_VX','Units','m a-1');
ncwriteatt(ExpName,'Halbrane_D_VY','Units','m a-1');


ncdisp(ExpName)





