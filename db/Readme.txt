0-DatabaseInfo[struct]
    1-root[string]
    1-listf[string]
    1-rectf[string]
    1-bboxOrder[string]:    'luwh' or 'lurb' or 'lrtb'
    1-labelf[string]
    *1-fliped[n*1 double]
    *1-needflip[double]

0-Classdb[struct]
    1-root[string]:         Root dir shared by all dir
    1-dir[n*1 cell]:        Dir of each instance
    1-bbox[n*4 double]:     Bounding box of each instance, one box per img.
    1-class[n*1 double]:    Class of each instance.
    1-nchannel[n*1 double]: 1 for gray imgs and 3 for RGB imgs
    1-Order[string]:        'rgb_nchw' or 'bgr_whcn'
    1-bboxOrder[string]:    'ltwh' or 'ltrb' or 'lrtb'

0-Regdb[struct]
	1-dir[string]
	1-largebox[n*4]
	1-targetbox[n*4]
	1-order_bbox[string]