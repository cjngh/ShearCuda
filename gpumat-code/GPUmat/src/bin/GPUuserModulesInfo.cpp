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

#ifdef UNIX
#include <stdint.h>
#endif

#include "mex.h"
#ifndef MATLAB
#define MATLAB
#endif


//#include "cutil.h"
#include "cublas.h"
#include "cuda_runtime.h"
#include "cuda.h"

#include "cudalib_common.h"
#include "cudalib_error.h"
#include "cudalib.h"

#include "GPUcommon.hh"
#include "GPUerror.hh"
#include "Queue.hh"
#include "GPUstream.hh"
#include "GPUmanager.hh"
#include "GPUtype.hh"
#include "GPUop.hh"

#include "GPUtypeMat.hh"


void
mexFunction( int nlhs, mxArray *plhs[],
            int nrhs,  const mxArray *prhs[] )
{

  // Garbage collector
  MyGC mygc = MyGC();

  if (nrhs!=0)
    mexErrMsgTxt("Wrong number of arguments");

  // tmp
  mxArray *lhs[2];

  mexCallMATLAB(1, &lhs[0], 0, &lhs[0], "GPUmanager");\
    GPUmanager * GPUman = (GPUmanager *) (UINTPTR mxGetScalar(lhs[0]));
  mxDestroyArray(lhs[0]);


  if (GPUman->getCompileMode()==1) {
    GPUman->compAbort(ERROR_GPUMANAGER_COMPNOTIMPLEMENTED);
  }


  int nModules = GPUman->getNModules();
  mexPrintf("- User modules summary\n");
  mexPrintf(" * Found %d modules\n", nModules);

  int index =0;
  struct userModule **userModules = GPUman->getUserModules();
  for (int i=0;i<MAXMODULES;i++) {
    if (userModules[i]!=0) {
      mexPrintf(" * Module %d -> %s\n", index, GPUman->getModuleName(i));
      index++;
    }
  }

}
