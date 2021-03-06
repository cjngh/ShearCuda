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
#include <math.h>

#ifdef UNIX
#include <stdint.h>
#endif

#include "mex.h"



// CUDA
#include "cuda.h"
#include "cuda_runtime.h"


#include "GPUmat.hh"


// static paramaters
static CUfunction drvfunf; // float
static CUfunction drvfunc; // complex
static CUfunction drvfund; // double
static CUfunction drvfuncd;//double complex

static int init = 0;

static GPUmat *gm;



void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[]) {

  CUresult cudastatus = CUDA_SUCCESS;

  if (nrhs != 12)
    mexErrMsgTxt("Wrong number of arguments");


  if (init == 0) {
    // Initialize function
    //mexLock();

    // load GPUmat
    gm = gmGetGPUmat();


    init = 1;
  }

  // mex parameters are:

  // 1. IN1
  // 2. IN2

  //IN1 is the input GPU array
  GPUtype IN1 = gm->gputype.getGPUtype(prhs[0]);

  //IN2 is the output GPU array (result)
  GPUtype IN2 = gm->gputype.getGPUtype(prhs[1]);

  // Remaining inputs are the indexes to be used in slice.
  // Indexes are given in Matlab format, with the first
  // element = 1, but the gm->gputype.assign function
  // uses standard C notation for arrays (the first element
  // is 0)
  int idx0 = (int) mxGetScalar(prhs[2])-1;
  int idx1 = (int) mxGetScalar(prhs[3]); // stride
  int idx2 = (int) mxGetScalar(prhs[4])-1;
  int idx3 = (int) mxGetScalar(prhs[5])-1;
  int idx4 = (int) mxGetScalar(prhs[6]); // stride
  int idx5 = (int) mxGetScalar(prhs[7])-1;
  int idx6 = (int) mxGetScalar(prhs[8])-1;
  int idx7 = (int) mxGetScalar(prhs[9]); // stride
  int idx8 = (int) mxGetScalar(prhs[10])-1;

  // dir=0 -> IN1        = IN2(Range)
  // dir=1 -> IN1(Range) = IN2

  int dir  = (int) mxGetScalar(prhs[11]);




  // number of elements
  const int * sin1 = gm->gputype.getSize(IN1);
  const int * sin2 = gm->gputype.getSize(IN2);

  int nin1 = gm->gputype.getNumel(IN1);
  int nin2 = gm->gputype.getNumel(IN2);

  gpuTYPE_t tin1 = gm->gputype.getType(IN1);
  gpuTYPE_t tin2 = gm->gputype.getType(IN2);

  // check input/in2 size and type

  if (tin1!=tin2)
      mexErrMsgTxt("Input and output arguments must be of the same type.");

  // I need the pointers to GPU memory
  CUdeviceptr d_IN1  = (CUdeviceptr) (UINTPTR gm->gputype.getGPUptr(IN1));
  CUdeviceptr d_IN2 = (CUdeviceptr) (UINTPTR gm->gputype.getGPUptr(IN2));

  // The GPU kernel depends on the type of input/output
  CUfunction drvfun;
  drvfun = drvfunf;


  gm->gputype.assign(IN1, IN2,
      Range(idx0,idx1,idx2,
      Range(idx3,idx4,idx5,
      Range(idx6,idx7,idx8))),dir);



}
