function [model_info] = impose_symmetry_MTparameters(S,model_info)
% --------------------------------------------------------------------------
% impose_symmetry_MTparameters
%   Makes the muscle-tendon parameters symmetric by using values from the 
%   right side to overwrite those from the left side.
%   
% 
% INPUT:
%   - S -
%   * setting structure S
%
%   - model_info -
%   * structure with all the model information based on the OpenSim model
% 
% OUTPUT:
%   - model_info -
%   * structure with all the model information based on the OpenSim model
% 
% Original author: Lars D'Hondt
% Original date: 18/March/2022
%
% Last edit by: 
% Last edit date: 
% --------------------------------------------------------------------------

muscleNames = model_info.muscle_info.muscle_names;
NMuscle = model_info.muscle_info.NMuscle;

%% find indices
% left side
is_left = zeros(NMuscle,1);
for i=1:NMuscle
    is_left(i) = muscleNames{i}(end)=='l';
end
idx_left = find(is_left)';

% right side
idx_right = model_info.ExtFunIO.symQs.orderMusInv(idx_left);


%% loop over muscle-tendon properties to impose symmetry on parameter values
MTproperties = {'FMo','lMo','lTs','alphao','vMmax','aTendon','tensions',...
    'pctsts','muscle_strength','muscle_stiffness'};

for i=1:length(MTproperties)
    MTparam_sym = model_info.muscle_info.(MTproperties{i});
    MTparam_sym(idx_left) = MTparam_sym(idx_right);
    model_info.muscle_info.(MTproperties{i}) = MTparam_sym;
end





end