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
 X=-800e3:5e3:800e3;
 Y=-800e3:5e3:800e3;

 %Load line profile points

P = readtable('Circle_Profiles.csv');

%load raw data fields. I leave it up to participants to interpolate their
%own results onto the results grid. Required results fields, with units and
%dimensions are;

% xvelmean=X velocity field, m / a^-1, 161 by 161 by 1
% yvelmean=Y velocity field, m / a^-1, 161 by 161 by 1
% lithk=Ice thickness field, m, 161 by 161 by 1
% mask=Ice mask, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 161 by 1
% topg=Bedrock topography, m
%
% xvelmeanA=X velocity field along Profile A, m / a^-1, 161 by 1
% yvelmeanA=Y velocity field along Profile A, m / a^-1, 161 by 1
% lithkA=Ice thickness field along Profile A, m, 161 by 1
% maskA=Ice mask along Profile A, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1
% sA=distance along Profile A, 
% topg=Bedrock topography along Profile A, m
%
% xvelmeanB=X velocity field along Profile A, m / a^-1, 161 by 1
% yvelmeanB=Y velocity field along Profile A, m / a^-1, 161 by 1
% lithkB=Ice thickness field along Profile A, m, 161 by 1
% maskB=Ice mask along Profile A, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1
% sB=distance along Profile B, 
% topgB=Bedrock topography along Profile B, m
%
% xvelmeanC=X velocity field along Profile C, m / a^-1, 161 by 1
% yvelmeanC=Y velocity field along Profile C, m / a^-1, 161 by 1
% lithkC=Ice thickness field along Profile C, m, 161 by 1
% maskC=Ice mask along Profile C, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1            
% sC=distance along Profile C, 
% topgC=Bedrock topography along Profile C, m
%
% xvelmeanD=X velocity field along Profile D, m / a^-1, 161 by 1
% yvelmeanD=Y velocity field along Profile D, m / a^-1, 161 by 1
% lithkD=Ice thickness field along Profile D, m, 161 by 1
% maskD=Ice mask along Profile D, 1 for grounded, 2 for floating, 3 for open ocean, 161 by 1 
% sD=distance along Profile D, 
% topgD=Bedrock topography along Profile D, m
% calverate=Calving rate applied to move the calving front. The exact units
% of this may vary depending on the approach to calving, for example Kori
% defines a calving rate in terms of distance, whilst other approaches may
% definie a calving rate in terms of volume or mass
% iareafl= total domain wide floating ice area, m^2
% iareagr= total domain wide grounded ice area, m^2
% lim = total land ice mass in domain (grounded+floating), kg
% limnsw = total land ice mass not displacing sea level, kg
% tendlicalvf = tendency of land ice mass due to calving (total calving mass flux, given by velocity ...
%               times thickness at calving front, NOT modelled calving rate), kg a^-1
% tendligroundf = tendency of land ice mass (total mass flux over the grounding line, kg a^-1



load Exp2Kori.mat


 nccreate(ExpName,'Time1','Dimensions',{'Time1' numel(Time1)})
 nccreate(ExpName,'Time100','Dimensions',{'Time100' numel(Time100)})
 nccreate(ExpName,'X','Dimensions',{'X' 321})
 nccreate(ExpName,'Y','Dimensions',{'Y' 321})
 nccreate(ExpName,'xvelmean','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)},'FillValue',nan)
 nccreate(ExpName,'yvelmean','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)},'FillValue',nan)
 nccreate(ExpName,'lithk','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)},'FillValue',nan)
 nccreate(ExpName,'mask','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)})
 nccreate(ExpName,'calverate','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)},'FillValue',nan)
 nccreate(ExpName,'topg','Dimensions',{'X' 321 'Y' 321 'Time100' numel(Time100)})
% 
nccreate(ExpName,'iareafl','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'iareagr','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'lim','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'limnsw','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'tendlicalvf','Dimensions',{'Time1' numel(Time1)})
nccreate(ExpName,'tendligroundf','Dimensions',{'Time1' numel(Time1)})
% 
% 
nccreate(ExpName,'lithkA','Dimensions',{'Profile A' numel(lithkA),'Time1' numel(Time1)})
nccreate(ExpName,'sA','Dimensions',{'Profile A' numel(lithkA),'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanA','Dimensions',{'Profile A' numel(lithkA),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanA','Dimensions',{'Profile A' numel(lithkA),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskA','Dimensions',{'Profile A' numel(lithkA),'Time1' numel(Time1)})

nccreate(ExpName,'lithkB','Dimensions',{'Profile B' numel(lithkB),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sB','Dimensions',{'Profile B' numel(lithkB),'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanB','Dimensions',{'Profile B' numel(lithkB),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanB','Dimensions',{'Profile B' numel(lithkB),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskB','Dimensions',{'Profile B' numel(lithkB),'Time1' numel(Time1)})

nccreate(ExpName,'lithkC','Dimensions',{'Profile C' numel(lithkC),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sC','Dimensions',{'Profile C' numel(lithkC),'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanC','Dimensions',{'Profile C' numel(lithkC),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanC','Dimensions',{'Profile C' numel(lithkC),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskC','Dimensions',{'Profile C' numel(lithkC),'Time1' numel(Time1)})

nccreate(ExpName,'lithkD','Dimensions',{'Profile D' numel(lithkD),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sD','Dimensions',{'Profile D' numel(lithkD),'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanD','Dimensions',{'Profile D' numel(lithkD),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanD','Dimensions',{'Profile D' numel(lithkD),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskD','Dimensions',{'Profile D' numel(lithkD),'Time1' numel(Time1)})

nccreate(ExpName,'lithkE','Dimensions',{'Profile E' numel(lithkE),'Time1' numel(Time1)})
nccreate(ExpName,'sE','Dimensions',{'Profile E' numel(lithkE),'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanE','Dimensions',{'Profile E' numel(lithkE),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanE','Dimensions',{'Profile E' numel(lithkE),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskE','Dimensions',{'Profile E' numel(lithkE),'Time1' numel(Time1)})

nccreate(ExpName,'lithkF','Dimensions',{'Profile F' numel(lithkF),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sF','Dimensions',{'Profile F' numel(lithkF),'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanF','Dimensions',{'Profile F' numel(lithkF),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanF','Dimensions',{'Profile F' numel(lithkF),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskF','Dimensions',{'Profile F' numel(lithkF),'Time1' numel(Time1)})

nccreate(ExpName,'lithkG','Dimensions',{'Profile G' numel(lithkG),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sG','Dimensions',{'Profile G' numel(lithkG),'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanG','Dimensions',{'Profile G' numel(lithkG),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanG','Dimensions',{'Profile G' numel(lithkG),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskG','Dimensions',{'Profile G' numel(lithkG),'Time1' numel(Time1)})

nccreate(ExpName,'lithkH','Dimensions',{'Profile H' numel(lithkH),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'sH','Dimensions',{'Profile H' numel(lithkH),'Time1' numel(Time1)})
nccreate(ExpName,'xvelmeanH','Dimensions',{'Profile H' numel(lithkH),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'yvelmeanH','Dimensions',{'Profile H' numel(lithkH),'Time1' numel(Time1)},'FillValue',nan)
nccreate(ExpName,'maskH','Dimensions',{'Profile H' numel(lithkH),'Time1' numel(Time1)})



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
ncwrite(ExpName,'lithkA',lithkA)
ncwrite(ExpName,'sA',P.Circle_Profile_A_S)
ncwrite(ExpName,'xvelmeanA',xvelmeanA)
ncwrite(ExpName,'xvelmeanA',yvelmeanA)
ncwrite(ExpName,'maskA',maskA)

ncwrite(ExpName,'lithkB',lithkB)
ncwrite(ExpName,'sB',sB)
ncwrite(ExpName,'xvelmeanB',xvelmeanB)
ncwrite(ExpName,'xvelmeanB',yvelmeanB)
ncwrite(ExpName,'maskB',maskB)

ncwrite(ExpName,'lithkC',lithkC)
ncwrite(ExpName,'sC',sC)
ncwrite(ExpName,'xvelmeanC',xvelmeanC)
ncwrite(ExpName,'xvelmeanC',yvelmeanC)
ncwrite(ExpName,'maskC',maskC)

ncwrite(ExpName,'lithkD',lithkD)
ncwrite(ExpName,'sD',sD)
ncwrite(ExpName,'xvelmeanD',xvelmeanD)
ncwrite(ExpName,'xvelmeanD',yvelmeanD)
ncwrite(ExpName,'maskD',maskD)

ncwrite(ExpName,'lithkE',lithkE)
ncwrite(ExpName,'sE',sE)
ncwrite(ExpName,'xvelmeanE',xvelmeanE)
ncwrite(ExpName,'xvelmeanE',yvelmeanE)
ncwrite(ExpName,'maskE',maskE)

ncwrite(ExpName,'lithkF',lithkF)
ncwrite(ExpName,'sF',sF)
ncwrite(ExpName,'xvelmeanF',xvelmeanF)
ncwrite(ExpName,'xvelmeanF',yvelmeanF)
ncwrite(ExpName,'maskF',maskF)

ncwrite(ExpName,'lithkG',lithkG)
ncwrite(ExpName,'sG',sG)
ncwrite(ExpName,'xvelmeanG',xvelmeanG)
ncwrite(ExpName,'xvelmeanG',yvelmeanG)
ncwrite(ExpName,'maskG',maskG)

ncwrite(ExpName,'lithkH',lithkH)
ncwrite(ExpName,'sH',sH)
ncwrite(ExpName,'xvelmeanH',xvelmeanH)
ncwrite(ExpName,'xvelmeanH',yvelmeanH)
ncwrite(ExpName,'maskH',maskH)


% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
  ncwriteatt(ExpName,'Time100','units','a');
  ncwriteatt(ExpName,'Time1','units','a');
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

 ncwriteatt(ExpName,'lithkA','units','m');
 ncwriteatt(ExpName,'sA','units','m');
 ncwriteatt(ExpName,'xvelmeanA','units','m/a');
 ncwriteatt(ExpName,'yvelmeanA','units','m/a');
 
 ncwriteatt(ExpName,'lithkB','units','m');
 ncwriteatt(ExpName,'sB','units','m');
 ncwriteatt(ExpName,'xvelmeanB','units','m/a');
 ncwriteatt(ExpName,'yvelmeanB','units','m/a');
 
 ncwriteatt(ExpName,'lithkC','units','m');
 ncwriteatt(ExpName,'sC','units','m');
 ncwriteatt(ExpName,'xvelmeanC','units','m/a');
 ncwriteatt(ExpName,'yvelmeanC','units','m/a');
% 
 ncwriteatt(ExpName,'lithkD','units','m');
 ncwriteatt(ExpName,'sD','units','m');
 ncwriteatt(ExpName,'xvelmeanD','units','m/a');
 ncwriteatt(ExpName,'yvelmeanD','units','m/a');
% % 
 ncwriteatt(ExpName,'lithkE','units','m');
 ncwriteatt(ExpName,'sE','units','m');
 ncwriteatt(ExpName,'xvelmeanE','units','m/a');
 ncwriteatt(ExpName,'yvelmeanE','units','m/a');
% 
 ncwriteatt(ExpName,'lithkF','units','m');
 ncwriteatt(ExpName,'sF','units','m');
 ncwriteatt(ExpName,'xvelmeanF','units','m/a');
 ncwriteatt(ExpName,'yvelmeanF','units','m/a');
% 
 ncwriteatt(ExpName,'lithkG','units','m');
 ncwriteatt(ExpName,'sG','units','m');
 ncwriteatt(ExpName,'xvelmeanG','units','m/a');
 ncwriteatt(ExpName,'yvelmeanG','units','m/a');
% 
 ncwriteatt(ExpName,'lithkH','units','m');
 ncwriteatt(ExpName,'sH','units','m');
 ncwriteatt(ExpName,'xvelmeanH','units','m/a');
 ncwriteatt(ExpName,'yvelmeanH','units','m/a');
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

ncwriteatt(ExpName,'lithkA','Standard_name','land_ice_thickness_along_profile_A');
ncwriteatt(ExpName,'sA','Standard_name','distance_along_profile_A');
ncwriteatt(ExpName,'xvelmeanA','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_A');
ncwriteatt(ExpName,'yvelmeanA','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_A');

ncwriteatt(ExpName,'lithkB','Standard_name','land_ice_thickness_along_profile_B');
ncwriteatt(ExpName,'sB','Standard_name','distance_along_profile_B');
ncwriteatt(ExpName,'xvelmeanB','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_B');
ncwriteatt(ExpName,'yvelmeanB','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_B');

ncwriteatt(ExpName,'lithkC','Standard_name','land_ice_thickness_along_profile_C');
ncwriteatt(ExpName,'sC','Standard_name','distance_along_profile_C');
ncwriteatt(ExpName,'xvelmeanC','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_C');
ncwriteatt(ExpName,'yvelmeanC','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_C');

ncwriteatt(ExpName,'lithkD','Standard_name','land_ice_thickness_along_profile_D');
ncwriteatt(ExpName,'sD','Standard_name','distance_along_profile_D');
ncwriteatt(ExpName,'xvelmeanD','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_D');
ncwriteatt(ExpName,'yvelmeanD','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_D');

ncwriteatt(ExpName,'lithkE','Standard_name','land_ice_thickness_along_profile_E');
ncwriteatt(ExpName,'sE','Standard_name','distance_along_profile_E');
ncwriteatt(ExpName,'xvelmeanE','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_E');
ncwriteatt(ExpName,'yvelmeanE','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_E');

ncwriteatt(ExpName,'lithkF','Standard_name','land_ice_thickness_along_profile_F');
ncwriteatt(ExpName,'sF','Standard_name','distance_along_profile_F');
ncwriteatt(ExpName,'xvelmeanF','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_F');
ncwriteatt(ExpName,'yvelmeanF','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_F');

ncwriteatt(ExpName,'lithkG','Standard_name','land_ice_thickness_along_profile_G');
ncwriteatt(ExpName,'sG','Standard_name','distance_along_profile_G');
ncwriteatt(ExpName,'xvelmeanG','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_G');
ncwriteatt(ExpName,'yvelmeanG','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_G');

ncwriteatt(ExpName,'lithkH','Standard_name','land_ice_thickness_along_profile_H');
ncwriteatt(ExpName,'sH','Standard_name','distance_along_profile_H');
ncwriteatt(ExpName,'xvelmeanH','Standard_name','land_ice_vertical_mean_x_velocity_along_profile_H');
ncwriteatt(ExpName,'yvelmeanH','Standard_name','land_ice_vertical_mean_y_velocity_along_profile_H');


%%%%%%%%%%%%%%%%%%%%%%%%

ncwriteatt(ExpName,'mask','flag_values','1, 2, 3');
ncwriteatt(ExpName,'mask','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskA','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskA','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskB','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskB','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskC','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskC','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskD','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskD','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskE','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskE','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskF','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskF','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskG','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskG','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');
ncwriteatt(ExpName,'maskH','flag_values','1, 2, 3');
ncwriteatt(ExpName,'maskH','flag_meanings','1=grounded ice, 2=floating ice, 3=open ocean');


% 
 ncdisp(ExpName)
