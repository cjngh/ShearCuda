/*
     Copyright (C) 2012  GP-you Group (http://gp-you.org)
 
     This program is free software: you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation, either version 3 of the License, or
     (at your option) any later version.
 
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License
     along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#ifdef UNIX
#include <stdint.h>
#endif
#include "mex.h"
// CUDA
#include "cuda.h"
#include "cuda_runtime.h"
#include "GPUmat.hh"
// static paramaters
static CUfunction drvfuns[4];
static int init = 0;
static GPUmat *gm;
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
  // At least 2 arguments expected
  // Input and result
  if (nrhs!=2)
     mexErrMsgTxt("Wrong number of arguments");
  if (init == 0) {
    // Initialize function
    //mexLock();
    // load GPUmat
    gm = gmGetGPUmat();
    gmCheckGPUmat(gm);
    init = 1;
  }
  // log
  gm->debug.log("> GPUasinh\n",0);
  gm->debug.logPush();
  // mex parameters are:
  // IN1
  // OUT
  GPUtype IN1  = gm->gputype.getGPUtype(prhs[0]);
  GPUtype OUT  = gm->gputype.getGPUtype(prhs[1]);
  if (gm->comp.getCompileMode() == 1) {
    gm->comp.functionStart("GPUMAT_Asinh");
    gm->comp.functionSetParamGPUtype(&OUT);
    gm->comp.functionSetParamGPUtype(&IN1);
    gm->comp.functionEnd();
  } else {
    gm->numerics.Asinh(IN1,OUT);
  }
  gm->debug.logPop();
}
