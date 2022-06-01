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



spmd
    l_rep = fix(REP / numlabs);
    if(mod(REP,numlabs) > 0 && (numlabs-mod(REP,numlabs) <labindex))
	   l_rep = l_rep+1;
    end
    y = zeros(numel(tvec),1);
    for i=1:l_rep
		[t, y_temp] = dglcall(tvec, y0,K,D(i),M);
		y = y + y_temp(:,2);
    end
    ysum = gop(@plus,y,1);
end


ymean = ysum{1}./REP;

t=toc;



function [t,y] = dglcall(tvec,y0,K,D,M)
	[t, y] = ode45(@(t,y) dgl(t,y,K,D,M), tvec, y0);
end