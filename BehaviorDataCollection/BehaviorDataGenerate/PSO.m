%----------------------------------------------------------------------
% PSO algorithm
%----------------------------------------------------------------------

function PSO(save_func_name, func_num, maxFEs, initial_pop, lb, ub, NP, D, runs, savePop_step, shift_flag)

algo_name = 'PSO';
inilb = lb;
iniub = ub;

parfor run = 1:runs
    PSO_run(save_func_name, func_num, algo_name, maxFEs, run, NP, D, inilb, iniub, lb, ub, initial_pop, savePop_step, shift_flag);
end

end
