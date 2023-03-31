%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process CalvingMIP-Experiment-3 results into NETcdf format
% Any errors, improvements or criticisms to be directed to james.rowan.jordan@ulb.be

close all
clear all

% File name for the NETcdf file. Format is CalvingMIP-Exp5-MODELNAME-INSTITUTION.nc
ExpName='CalvingMIP-Exp5-Kori-ULB.nc';

%Delete old file
 if exist(ExpName,'file')==2
   delete(ExpName);
 end

% Common results dimensions
Time1=0:1:3000; %Time for 1 year profiles
Time100=0:100:3000; %Time for 100 year snapshots
 X=-800e3:10e3:800e3;
 Y=-800e3:10e3:800e3;

 %Load line profile points

P = readtable('Caprona_Profiles.csv');
Q = readtable('Halbrane_Profiles.csv');

%load raw data fields. I leave it up to participants to interpolate their
%own results onto the results grid. Note that for Experiment 5 we do not 
%specify a total model run time, only that the results should reach a new steady state.
% For Kori, this was achieved after a period of 3000 years. Adjust time as needed. 
% Required results fields, with units and
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
load Exp5Kori.mat


P = readtable('Caprona_Profiles.csv');

 nccreate(ExpName,'Time1','Dimensions',{'Time1' numel(Time1)})
 nccreate(ExpName,'Time100','Dimensions',{'Time100' numel(Time100)})
 nccreate(ExpName,'X','Dimensions',{'X' 321})
 nccreate(ExpName,'Y','Dimensions',{'Y' 321})
 nccreate(ExpName,'xvelmean','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)},'FillValue',nan)
 nccreate(ExpName,'yvelmean','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)},'FillValue',nan)
 nccreate(ExpName,'lithk','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)},'FillValue',nan)
 nccreate(ExpName,'mask','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)})
 nccreate(ExpName,'calverate','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)},'FillValue',nan)
 nccreate(ExpName,'topg','Dimensions',{'X' 321 'Y' 321})
% 
nccreate(ExpName,'iareafl','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'iareagr','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'lim','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'limnsw','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'tendlicalvf','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'tendligroundf','Dimensions',{'Time1' numel(Time1)})
% 
% 
nccreate(ExpName,'lithkCapA','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)})
nccreate(ExpName,'sCapA','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X)   'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanCapA','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanCapA','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskCapA','Dimensions',{'Caprona A' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)})

nccreate(ExpName,'lithkCapB','Dimensions',{'Caprona B' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sCapB','Dimensions',{'Caprona B' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanCapB','Dimensions',{'Caprona B' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanCapB','Dimensions',{'Caprona B' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskCapB','Dimensions',{'Caprona B' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)})

nccreate(ExpName,'lithkCapC','Dimensions',{'Caprona C' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sCapC','Dimensions',{'Caprona C' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanCapC','Dimensions',{'Caprona C' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanCapC','Dimensions',{'Caprona C' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskCapC','Dimensions',{'Caprona C' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)})

nccreate(ExpName,'lithkCapD','Dimensions',{'Caprona D' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sCapD','Dimensions',{'Caprona D' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanCapD','Dimensions',{'Caprona D' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanCapD','Dimensions',{'Caprona D' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskCapD','Dimensions',{'Caprona D' numel(P.Caprona_Profile_A_X)  'Time1' numel(Time1)})

P = readtable('Halbrane_Profiles.csv');

nccreate(ExpName,'lithkHalA','Dimensions',{'Halbrane A' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)})
nccreate(ExpName,'sHalA','Dimensions',{'Halbrane A' numel(P.Halbrane_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanHalA','Dimensions',{'Halbrane A' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanHalA','Dimensions',{'Halbrane A' numel(P.Halbrane_Profile_A_X) 'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskHalA','Dimensions',{'Halbrane A' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)})

nccreate(ExpName,'lithkHalB','Dimensions',{'Halbrane B' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sHalB','Dimensions',{'Halbrane B' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanHalB','Dimensions',{'Halbrane B' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanHalB','Dimensions',{'Halbrane B' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskHalB','Dimensions',{'Halbrane B' numel(P.Halbrane_Profile_A_X) 'Time1' numel(Time1)})

nccreate(ExpName,'lithkHalC','Dimensions',{'Halbrane C' numel(P.Halbrane_Profile_A_X) 'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sHalC','Dimensions',{'Halbrane C' numel(P.Halbrane_Profile_A_X) 'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanHalC','Dimensions',{'Halbrane C' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanHalC','Dimensions',{'Halbrane C' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskHalC','Dimensions',{'Halbrane C' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)})

nccreate(ExpName,'lithkHalD','Dimensions',{'Halbrane D' numel(P.Halbrane_Profile_A_X) 'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sHalD','Dimensions',{'Halbrane D' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanHalD','Dimensions',{'Halbrane D' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanHalD','Dimensions',{'Halbrane D' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskHalD','Dimensions',{'Halbrane D' numel(P.Halbrane_Profile_A_X)  'Time1' numel(Time1)})



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ncwrite(ExpName,'Time100',Time100)
ncwrite(ExpName,'Time1',Time1)
  ncwrite(ExpName,'X',X)
  ncwrite(ExpName,'Y',Y)
   ncwrite(ExpName,'xvelmean',xvelmean)
  ncwrite(ExpName,'yvelmean',yvelmean)
  ncwrite(ExpName,'lithk',lithk)
  ncwrite(ExpName,'mask',mask)
  ncwrite(ExpName,'topg', topg)
  ncwrite(ExpName,'calverate', calverate)
% % 
ncwrite(ExpName,'iareafl',iareafl)
ncwrite(ExpName,'iareagr',iareagr)
ncwrite(ExpName,'lim',lim)
ncwrite(ExpName,'limnsw',limnsw)
ncwrite(ExpName,'tendlicalvf',tendlicalvf)
ncwrite(ExpName,'tendligroundf', tendligroundf)
% 
ncwrite(ExpName,'lithkCapA',lithkCapA)
ncwrite(ExpName,'sCapA',sCapA)
ncwrite(ExpName,'xvelmeanCapA',xvelmeanCapA)
ncwrite(ExpName,'xvelmeanCapA',yvelmeanCapA)
ncwrite(ExpName,'maskCapA',maskCapA)

ncwrite(ExpName,'lithkCapB',lithkCapB)
ncwrite(ExpName,'sCapB',sCapB)
ncwrite(ExpName,'xvelmeanCapB',xvelmeanCapB)
ncwrite(ExpName,'xvelmeanCapB',yvelmeanCapB)
ncwrite(ExpName,'maskCapB',maskCapB)

ncwrite(ExpName,'lithkCapC',lithkCapC)
ncwrite(ExpName,'sCapC',sCapC)
ncwrite(ExpName,'xvelmeanCapC',xvelmeanCapC)
ncwrite(ExpName,'xvelmeanCapC',yvelmeanCapC)
ncwrite(ExpName,'maskCapC',maskCapC)

ncwrite(ExpName,'lithkCapD',lithkCapD)
ncwrite(ExpName,'sCapD',sCapD)
ncwrite(ExpName,'xvelmeanCapD',xvelmeanCapD)
ncwrite(ExpName,'xvelmeanCapD',yvelmeanCapD)
ncwrite(ExpName,'maskCapD',maskCapD)

ncwrite(ExpName,'lithkHalA',lithkHalA)
ncwrite(ExpName,'sHalA',sHalA)
ncwrite(ExpName,'xvelmeanHalA',xvelmeanHalA)
ncwrite(ExpName,'xvelmeanHalA',yvelmeanHalA)
ncwrite(ExpName,'maskHalA',maskHalA)

ncwrite(ExpName,'lithkHalB',lithkHalB)
ncwrite(ExpName,'sHalB',sHalB)
ncwrite(ExpName,'xvelmeanHalB',xvelmeanHalB)
ncwrite(ExpName,'xvelmeanHalB',yvelmeanHalB)
ncwrite(ExpName,'maskHalB',maskHalB)

ncwrite(ExpName,'lithkHalC',lithkHalC)
ncwrite(ExpName,'sHalC',sHalC)
ncwrite(ExpName,'xvelmeanHalC',xvelmeanHalC)
ncwrite(ExpName,'xvelmeanHalC',yvelmeanHalC)
ncwrite(ExpName,'maskHalC',maskHalC)

ncwrite(ExpName,'lithkHalD',lithkHalD)
ncwrite(ExpName,'sHalD',sHalD)
ncwrite(ExpName,'xvelmeanHalD',xvelmeanHalD)
ncwrite(ExpName,'xvelmeanHalD',yvelmeanHalD)
ncwrite(ExpName,'maskHalD',maskHalD)


% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
  ncwriteatt(ExpName,'Time1','units','a');
  ncwriteatt(ExpName,'Time100','units','a');
  ncwriteatt(ExpName,'X','units','m')
  ncwriteatt(ExpName,'Y','units','m')
  ncwriteatt(ExpName,'xvelmean','units','m/a')
  ncwriteatt(ExpName,'yvelmean','units','m/a')
   ncwriteatt(ExpName,'lithk','units','m');
  ncwriteatt(ExpName,'topg','units','m');
  ncwriteatt(ExpName,'calverate','units','m/a');
% 
 ncwriteatt(ExpName,'iareafl','units','m^2')
 ncwriteatt(ExpName,'iareagr','units','m^2')
 ncwriteatt(ExpName,'lim','units','kg')
 ncwriteatt(ExpName,'limnsw','units','kg')
 ncwriteatt(ExpName,'tendlicalvf','units','kg/a');
 ncwriteatt(ExpName,'tendligroundf','units','kg/a');

 ncwriteatt(ExpName,'lithkCapA','units','m');
 ncwriteatt(ExpName,'sCapA','units','m');
 ncwriteatt(ExpName,'xvelmeanCapA','units','m/a');
 ncwriteatt(ExpName,'yvelmeanCapA','units','m/a');
 
 ncwriteatt(ExpName,'lithkCapB','units','m');
 ncwriteatt(ExpName,'sCapB','units','m');
 ncwriteatt(ExpName,'xvelmeanCapB','units','m/a');
 ncwriteatt(ExpName,'yvelmeanCapB','units','m/a');
 
 ncwriteatt(ExpName,'lithkCapC','units','m');
 ncwriteatt(ExpName,'sCapC','units','m');
 ncwriteatt(ExpName,'xvelmeanCapC','units','m/a');
 ncwriteatt(ExpName,'yvelmeanCapC','units','m/a');
% 
 ncwriteatt(ExpName,'lithkCapD','units','m');
 ncwriteatt(ExpName,'sCapD','units','m');
 ncwriteatt(ExpName,'xvelmeanCapD','units','m/a');
 ncwriteatt(ExpName,'yvelmeanCapD','units','m/a');
% % 
ncwriteatt(ExpName,'lithkHalA','units','m');
 ncwriteatt(ExpName,'sHalA','units','m');
 ncwriteatt(ExpName,'xvelmeanHalA','units','m/a');
 ncwriteatt(ExpName,'yvelmeanHalA','units','m/a');
 
 ncwriteatt(ExpName,'lithkHalB','units','m');
 ncwriteatt(ExpName,'sHalB','units','m');
 ncwriteatt(ExpName,'xvelmeanHalB','units','m/a');
 ncwriteatt(ExpName,'yvelmeanHalB','units','m/a');
 
 ncwriteatt(ExpName,'lithkHalC','units','m');
 ncwriteatt(ExpName,'sHalC','units','m');
 ncwriteatt(ExpName,'xvelmeanHalC','units','m/a');
 ncwriteatt(ExpName,'yvelmeanHalC','units','m/a');
% 
 ncwriteatt(ExpName,'lithkHalD','units','m');
 ncwriteatt(ExpName,'sHalD','units','m');
 ncwriteatt(ExpName,'xvelmeanHalD','units','m/a');
 ncwriteatt(ExpName,'yvelmeanHalD','units','m/a');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 ncwriteatt(ExpName,'xvelmean','Standard_name','land_ice_vertical_mean_x_velocity')
 ncwriteatt(ExpName,'yvelmean','Standard_name','land_ice_vertical_mean_y_velocity')
 ncwriteatt(ExpName,'lithk','Standard_name','land_ice_thickness');
 ncwriteatt(ExpName,'topg','Standard_name','bedrock_altitude');
 ncwriteatt(ExpName,'calverate','Standard_name','calving_rate');
% 
ncwriteatt(ExpName,'iareafl','Standard_name','grounded_ice_sheet_area')
ncwriteatt(ExpName,'iareagr','Standard_name','floating_ice_shelf_area')
ncwriteatt(ExpName,'lim','Standard_name','land_ice_mass')
ncwriteatt(ExpName,'limnsw','Standard_name','land_ice_mass_not_displacing_sea_water')
ncwriteatt(ExpName,'tendlicalvf','Standard_name','tendency_of_land_ice_mass_due_to_calving');
ncwriteatt(ExpName,'tendligroundf','Standard_name','tendency_of_grounded_ice_mass');

ncwriteatt(ExpName,'lithkCapA','Standard_name','land_ice_thickness_along_profile_A');
ncwriteatt(ExpName,'sCapA','Standard_name','distance_along_profile_A');
ncwriteatt(ExpName,'xvelmeanCapA','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_A');
ncwriteatt(ExpName,'yvelmeanCapA','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_A');

ncwriteatt(ExpName,'lithkCapB','Standard_name','land_ice_thickness_along_profile_B');
ncwriteatt(ExpName,'sCapB','Standard_name','distance_along_profile_B');
ncwriteatt(ExpName,'xvelmeanCapB','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_B');
ncwriteatt(ExpName,'yvelmeanCapB','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_B');

ncwriteatt(ExpName,'lithkCapC','Standard_name','land_ice_thickness_along_profile_C');
ncwriteatt(ExpName,'sCapC','Standard_name','distance_along_profile_C');
ncwriteatt(ExpName,'xvelmeanCapC','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_C');
ncwriteatt(ExpName,'yvelmeanCapC','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_C');

ncwriteatt(ExpName,'lithkCapD','Standard_name','land_ice_thickness_along_profile_D');
ncwriteatt(ExpName,'sCapD','Standard_name','distance_along_profile_D');
ncwriteatt(ExpName,'xvelmeanCapD','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_D');
ncwriteatt(ExpName,'yvelmeanCapD','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_D');

ncwriteatt(ExpName,'lithkHalA','Standard_name','land_ice_thickness_along_profile_A');
ncwriteatt(ExpName,'sHalA','Standard_name','distance_along_profile_A');
ncwriteatt(ExpName,'xvelmeanHalA','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_A');
ncwriteatt(ExpName,'yvelmeanHalA','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_A');

ncwriteatt(ExpName,'lithkHalB','Standard_name','land_ice_thickness_along_profile_B');
ncwriteatt(ExpName,'sHalB','Standard_name','distance_along_profile_B');
ncwriteatt(ExpName,'xvelmeanHalB','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_B');
ncwriteatt(ExpName,'yvelmeanHalB','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_B');

ncwriteatt(ExpName,'lithkHalC','Standard_name','land_ice_thickness_along_profile_C');
ncwriteatt(ExpName,'sHalC','Standard_name','distance_along_profile_C');
ncwriteatt(ExpName,'xvelmeanHalC','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_C');
ncwriteatt(ExpName,'yvelmeanHalC','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_C');

ncwriteatt(ExpName,'lithkHalD','Standard_name','land_ice_thickness_along_profile_D');
ncwriteatt(ExpName,'sHalD','Standard_name','distance_along_profile_D');
ncwriteatt(ExpName,'xvelmeanHalD','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_D');
ncwriteatt(ExpName,'yvelmeanHalD','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_D');


%%%%%%%%%%%%%%%%%%%%%%%%

ncwriteatt(ExpName,'mask','flag_values','1, 2, 3');
ncwriteatt(ExpName,'mask','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskCapA','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskCapA','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskCapB','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskCapB','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskCapC','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskCapC','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskCapD','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskCapD','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskHalA','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskHalA','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskHalB','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskHalB','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskHalC','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskHalC','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskHalD','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskHalD','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');


% 
 ncdisp(ExpName)
% 
% 
% 
% 
% 
% 

% 
% 