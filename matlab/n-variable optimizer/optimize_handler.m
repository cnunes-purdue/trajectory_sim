global motor1
global motor2
global tStep
global stage2IgnitionAlt

motor1 = Motor('P8175(SL).ric');
motor2 = Motor('P8175(SL).ric');

tStep = 0.03;

[points, optimal] = optimizer([0.15, 7.5e3, 0.15], [0.01, 500, 0.01]);

% [bestNoz1Exit,alt] = optimizeFun('optS1NozzExit',0.15,-0.05);
% motor1.nozzle.exit = bestNoz1Exit;
% 
% tStep = 0.1;
% [bestIgnitionAlt,alt] = optimizeFun('optS2ignitionAlt',alt,-1000);
% 
% stage2IgnitionAlt = bestIgnitionAlt;
% 
% tStep = 0.03;
% [bestNoz2Exit,alt] = optimizeFun('optS2NozzExit',0.15,-0.05);
% motor2.nozzle.exit = bestNoz2Exit;