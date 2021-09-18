function maxAlt = optS2NozzExit(value,reset)
    persistent isSetup
    persistent in
    global motor2
    if isempty(isSetup)
        isSetup = true;
        modelName = 'optimizeTest1Sim';
        load_system(modelName)
        mdl = modelName;
        in = Simulink.SimulationInput(mdl);
        
         

        
    end
   
    motor2.nozzle.exit = value;
    out = sim(in);
    
    maxAlt = max(out.position);
end