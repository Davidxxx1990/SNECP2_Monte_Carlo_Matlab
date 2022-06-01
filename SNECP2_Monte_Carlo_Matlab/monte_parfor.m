tic;

REP = 1000;
H = 0.01;
TSTART = 0;
TEND = 2;

K = 9000;
M = 450;
D_MIN = 800;
D_MAX = 1200;


D = rand(1,REP) * (D_MAX - D_MIN) + D_MIN; 
tvec = TSTART:H:TEND;
y0 = [0, 0.1];

y=cell(REP,1);
ysum = zeros(size(tvec));
parfor i=1:numel(D)
    
    [tout, yout] = ode45(@(t,y) dgl(t,y,K,D(i),M), tvec, y0);
	ysum = ysum + yout(:,2); 
end


ymean = ysum./REP;

t=toc;



