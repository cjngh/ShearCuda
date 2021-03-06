function test_GPUrand

global GPUtest

try
  type = GPUtest.type;
catch
  error('GPUtest not initialized. Please use GPUtestInit.');
end

%%
GPUtestLOG('***********************************************',0);
if (GPUtest.checkCompiler==1)
  A = zeros(5,GPUsingle); % dummy
  
  GPUcompileStart('comp_GPUrand','-f','-verbose0',A)
  GPUrand(A);
  GPUcompileStop
  
end

%% test
gpufun = GPUtest.gpufun;
cpufun = GPUtest.cpufun;
txtfun = GPUtest.txtfun;
type = GPUtest.type;
type = 2;
rangei = 0;
if (type == 1)
  rangei = [0 1];
end

% repeat test many times
for iter=1:10
  for t=rangei
    if (t==0)
      type1= 'real';
    else
      type1 = 'complex';
    end
    for f=1:length(cpufun)
      GPUtestLOG(sprintf('**** Testing GPUrand (%s,%s)  ',txtfun{f},type1),0);
      %%
      Ah = rand(1000,10000,txtfun{f});
      A = ones(1000,10000,feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      
      %%compareCPUGPU(Ah,A);
      %%
      Ah = rand(1000,1000,txtfun{f});
      A = ones(1000,1000,feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      
      %%compareCPUGPU(Ah,A);
      
      %%
      Ah = rand(2000,1000,txtfun{f});
      A = ones(2000,1000,feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      
      %%compareCPUGPU(Ah,A);
      
      %%
      Ah = rand(3000,1000,txtfun{f});
      A = ones(3000,1000,feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      
      %%compareCPUGPU(Ah,A);
      
      %%
      Ah = rand(4000,1000,txtfun{f});
      A = ones(4000,1000,feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      
      %%compareCPUGPU(Ah,A);
      
      %%
      Ah = rand(10,10,txtfun{f});
      A = ones(10,10,feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      %%compareCPUGPU(Ah,A);
      
      %%
      Ah = rand([10,10],txtfun{f});
      A = ones([10,10],feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      %%compareCPUGPU(Ah,A);
      
      %%
      Ah = rand([10,10,40],txtfun{f});
      A = ones([10,10,40],feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      %%compareCPUGPU(Ah,A);
      
      
      
      %%
      Ah = rand(10,20,1000,txtfun{f});
      A = ones(10,20,1000,feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      %%compareCPUGPU(Ah,A);
      
      %%
      Ah = rand(3,10,20,1000,txtfun{f});
      A = ones(3,10,20,1000,feval(gpufun{f}))+1;
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
      else
        GPUrand(A);
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      err = abs(mean(Ah(:))-0.5);
      if err>0.05
        GPUtestLOG(sprintf('Error in tolerance test is %g',err),1);
      end
      %%compareCPUGPU(Ah,A);
      
      %% Check if consecutive runs give exaclty the same results
      
      Ah = rand(3000,1000,txtfun{f});
      Bh = rand(3000,1000,txtfun{f});
      A = ones(3000,1000,feval(gpufun{f}))+1;
      B = ones(3000,1000,feval(gpufun{f}))+1;
      
      if (GPUtest.checkCompiler==1)
        comp_GPUrand(A);
        comp_GPUrand(B);
      else
        GPUrand(A);
        GPUrand(B);
        
      end
      
      Ah(:) = feval(cpufun{f},(A(:)));
      Bh(:) = feval(cpufun{f},(B(:)));
      
      
      if mean(Ah)==mean(Bh)
        GPUtestLOG('Error same mean',1);
      end
      
      %%compareCPUGPU(Ah,A);
      
      
      
      
    end
  end
  GPUtestLOG('***********************************************',0);
end
end