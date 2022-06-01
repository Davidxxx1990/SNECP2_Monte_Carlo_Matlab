tic;



nsim = 1000; 
k = 9000;
m = 450;
s0 = 0;
v0 = 0.1;
d = 800 + 400 * rand(nsim,1);



for i=1:nsim
    in(i) = Simulink.SimulationInput('ddm');
    in(i) = in(i).setVariable('d',d(i));
    in(i) = in(i).setVariable('k',k);
    in(i) = in(i).setVariable('m',m);
    in(i) = in(i).setVariable('s0',s0);
    in(i) = in(i).setVariable('v0',v0);
end

out = parsim(in);
tvec = out(1).tout;
ymean = zeros(size(tvec));

for i=1:nsim
    ymean=ymean+out(i).s;
end   

ymean=ymean./nsim;

t=toc;