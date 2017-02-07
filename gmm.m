%---------------------------GMM--------------------------------------------
%Ashok Sharma Paudel, Deepesh Lekhak, Keshav Bashayal, Sushma shrestha
%--------------------------------------------------------------------------
function [obj]=gmm(x,k,user,id)
obj=gmdistribution.fit(x,k);
m=obj.mu;
v=obj.Sigma;
w=obj.PComponents;
c=int2str(id);
a=['gmm/',c,'.mat'];
save(a,'m','v','w');
f=['gmm/',c,'.txt'];
fid=fopen(f,'w');
fwrite(fid,user);
fclose(fid);
