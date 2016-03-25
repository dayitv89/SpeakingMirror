//
//  ViewController.h
//  testmirror
//
//  Created by sandeep kumar sharma on 06/01/16.
//  Copyright © 2016 Punchh Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@interface ViewController : UIViewController {
    GPUImagePicture *sourcePicture;
    GPUImageOutput<GPUImageInput> *sepiaFilter, *sepiaFilter2;
}


@end

