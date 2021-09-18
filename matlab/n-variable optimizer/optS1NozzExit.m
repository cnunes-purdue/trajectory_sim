function maxAlt = optS1NozzExit(value,reset)
    persistent isSetup
    persistent in
    global motor1
    if isempty(isSetup)
        isSetup = true;
        modelName = 'optimizeTest1Sim';
        load_system(modelName)
        mdl = modelName;
        in = Simulink.SimulationInput(mdl);
        
         

        
    end
   
    motor1.nozzle.exit = value;
    out = sim(in);
    
    maxAlt = max(out.position);
end