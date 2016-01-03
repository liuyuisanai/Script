#include "mex.h"
#include <omp.h>
#include <opencv2/opencv.hpp>
#include <math.h>
#include <stdlib.h>

using namespace std;
using namespace cv;

#define MEX_ARGS int nlhs, mxArray **plhs, int nrhs, const mxArray **prhs

void mexFunction(MEX_ARGS) {
	if ( nrhs != 3 ) {
		mexErrMsgTxt("Use: imgread_mex( PATHCELL(N*1), RECTMAT(N*4 xywh), SIZEDOUBLE )");
		return;
	}
	if ( mxGetM(prhs[ 1 ]) != 4 )
	{
		mexErrMsgTxt("Rect should be N*4 size and with xywh order.");
		return;
	}

	//path
	int status;
	const mxArray *cell_ele_ptr;
	const mwSize *dims = mxGetDimensions(prhs[ 0 ]);
	if ( dims[ 0 ] != mxGetN(prhs[ 1 ]) )
	{
		mexErrMsgTxt("List size != Rect size!");
		return;
	}
	mwSize buflen;
	mwIndex icell;
	//rect
	double* rect = mxGetPr(prhs[ 1 ]);
	int num = dims[ 0 ];
	//size
	int dsize = mxGetScalar(prhs[ 2 ]);

	//output blob
	unsigned char* blob = (unsigned char*)mxCalloc(dsize*dsize * 3 * num, sizeof( char ));
	mwSize blobsize[ 4 ] = { 3, dsize, dsize, num };
	plhs[ 0 ] = mxCreateNumericArray(4, blobsize, mxUINT8_CLASS, mxREAL);
	unsigned char* ptr = (unsigned char*)mxGetData(plhs[ 0 ]);
#pragma omp parallel for
	Mat img, roi_img;
    int l, r, u, d;
    unsigned char* imgdata = nullptr;
	for ( icell = 0; icell < num; icell++ )
	{
		cell_ele_ptr = mxGetCell(prhs[ 0 ], icell);
		char* path = mxArrayToString(cell_ele_ptr);
		try{
			img = imread(path, IMREAD_COLOR);
            if (img.data == nullptr)
                throw "Image not exist!";
            l = max(rect[ icell * 4 ] - 1, 0.0);
            u = max(rect[ icell * 4 + 1 ] - 1, 0.0);
            r = min(l + rect[ icell * 4 + 2 ], img.cols - 1.0);
            d = min(u + rect[ icell * 4 + 3 ], img.rows - 1.0);
            roi_img = img(Range(u, d), Range(l, r));
            resize(roi_img, roi_img, Size(dsize, dsize));
            imgdata = (unsigned char*)( roi_img.data );
            memcpy(blob + icell*dsize*dsize * 3, imgdata, sizeof(char)*dsize*dsize * 3);
		}
		catch ( ... ){
			char warnmsg[ 255 ];
			sprintf_s(warnmsg, "Cannot read %s", path);
			mexWarnMsgTxt(warnmsg);
            memcpy(blob + icell*dsize*dsize * 3, imgdata, sizeof(char)*dsize*dsize * 3);
		}
		mxFree(path);
	}
	memcpy(ptr, blob, num*dsize*dsize * 3 * mxGetElementSize(plhs[ 0 ]));
}
//>> mex -g imread_mex.cpp -I'C:\opencv\build\include' -L'C:\opencv\build\x64\vc12\lib' -lopencv_core2411.lib -lopencv_highgui2411.lib -lopencv_imgproc2411.lib