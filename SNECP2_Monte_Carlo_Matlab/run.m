function [t] = run(location,  type, n)

	if(location == "local")
		fprintf("run local with %d Worker(s)\n", n); 
		pool = parpool(n);
		if(type == "parsim")
		    monte_parsim;
		elseif(type == "parfor")
		    monte_parfor;
		else
		    monte_spmd;
		end
		delete(pool);
		
	elseif(location == "cluster")
	    fprintf("run on cluster with %d Worker(s)\n", n);
	    cluster = parcluster('Seneca');
	    if(type == "parsim")
		    job = batch(cluster,	'monte_parsim','Pool', n, ...
						'AttachedFiles', 'ddm' ,...
						'AutoAddClientPath',false);
		elseif(type == "parfor")
		    job = batch(cluster,	'monte_parfor','Pool', n, ...
						'AttachedFiles', 'dgl' ,...
						'AutoAddClientPath',false);
		else
		    job = batch(cluster,	'monte_spmd','Pool', n, ...
						'AttachedFiles', 'dgl' ,...
						'AutoAddClientPath',false);
		end
	    
		wait(job);
		load(job, 'tvec');
		load(job, 't');
		load(job, 'ymean');
		
		
		delete(job);
	end
	fprintf("Elapsed time is %f seconds\n", t);
	
	plot(tvec,ymean);
end

