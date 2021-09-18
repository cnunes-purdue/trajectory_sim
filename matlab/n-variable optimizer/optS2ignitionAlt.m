function maxAlt = optS2ignitionAlt(value,reset)
    persistent isSetup
    persistent in
    global stage2IgnitionAlt
    if isempty(isSetup)
        isSetup = true;
        modelName = 'optimizeTest1Sim';
        load_system(modelName)
        mdl = modelName;
        in = Simulink.SimulationInput(mdl);
        
         

        
    end
   
    stage2IgnitionAlt = value;
    out = sim(in);
    
    maxAlt = max(out.position);
end