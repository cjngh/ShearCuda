nvcc  -arch sm_10  -maxrregcount=32 -I"../gpumat-code/GPUmatModules/src/include" -I"%CUDA_INC_PATH%" -m32 -cubin -o  "./shear_cuda10.cubin" "./shear_cuda.cu"
nvcc  -arch sm_11  -maxrregcount=32 -I"../gpumat-code/GPUmatModules/src/include" -I"%CUDA_INC_PATH%" -m32 -cubin -o  "./shear_cuda11.cubin" "./shear_cuda.cu"
nvcc  -arch sm_12  -maxrregcount=32 -I"../gpumat-code/GPUmatModules/src/include" -I"%CUDA_INC_PATH%" -m32 -cubin -o  "./shear_cuda12.cubin" "./shear_cuda.cu"
nvcc  -arch sm_13  -maxrregcount=32 -I"../gpumat-code/GPUmatModules/src/include" -I"%CUDA_INC_PATH%" -m32 -cubin -o  "./shear_cuda13.cubin" "./shear_cuda.cu"
nvcc  -arch sm_20  -maxrregcount=32 -I"../gpumat-code/GPUmatModules/src/include" -I"%CUDA_INC_PATH%" -m32 -cubin -o  "./shear_cuda20.cubin" "./shear_cuda.cu"
nvcc  -arch sm_21  -maxrregcount=32 -I"../gpumat-code/GPUmatModules/src/include" -I"%CUDA_INC_PATH%" -m32 -cubin -o  "./shear_cuda21.cubin" "./shear_cuda.cu"
nvcc  -arch sm_30  -maxrregcount=32 -I"../gpumat-code/GPUmatModules/src/include" -I"%CUDA_INC_PATH%" -m32 -cubin -o  "./shear_cuda30.cubin" "./shear_cuda.cu"

