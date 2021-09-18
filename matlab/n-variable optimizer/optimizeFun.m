function [bestX,bestY] = optimizeFun(targetFunctionStr,initialGuess,initialStep,maxReductions,doPrint,doPlot)
    load_system('optimizeSim');
    mdl = 'optimizeSim';
    
    in = Simulink.SimulationInput(mdl);
    
    
    if ~strcmp([targetFunctionStr(1),targetFunctionStr(end)],'""')
        targetFunctionStr = sprintf('"%s"',targetFunctionStr);
    end
    
    in = in.setBlockParameter('optimizeSim/targetFunction/funName','String',targetFunctionStr);
    in = in.setBlockParameter('optimizeSim/initialGuess','Value',num2str(initialGuess));
    in = in.setBlockParameter('optimizeSim/initialStep','Value',num2str(initialStep));
    
    if nargin > 3
        in = in.setBlockParameter('optimizeSim/maxReductions','Value',num2str(maxReductions));
    end
    
    if nargin > 4
        in = in.setBlockParameter('optimizeSim/doPrint','Value',num2str(logical(doPrint)));
    end
    
    if nargin > 5
        if doPlot
            in = in.setBlockParameter('optimizeSim/XY','Commented','off');
        else
            in = in.setBlockParameter('optimizeSim/XY','Commented','on');
        end
    end
    
    out = sim(in);
    bestX = out.bestX;
    bestY = out.bestY;