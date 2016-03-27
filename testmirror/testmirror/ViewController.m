//
//  ViewController.m
//  testmirror
//
//  Created by sandeep kumar sharma on 06/01/16.
//  Copyright © 2016 Punchh Inc. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"

@interface ViewController () {
    GPUImageStillCamera *stillCamera;
    GPUImageView *image;
    GPUImageGrayscaleFilter *filter;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    stillCamera=[[GPUImageStillCamera alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    stillCamera.outputImageOrientation=UIInterfaceOrientationPortrait;
    image=[[GPUImageView alloc]initWithFrame:self.view.frame];
    image.alpha=0.6;
    [image setBackgroundColor:[UIColor redColor]];
    image.fillMode=kGPUImageFillModePreserveAspectRatioAndFill;
    filter=[[GPUImageGrayscaleFilter alloc]init];
    [self.view addSubview:image];
//    [self.view bringSubviewToFront:btnCapture];
    [stillCamera addTarget:image];
    [filter addTarget:image];
    [stillCamera startCameraCapture];
    
    if (stillCamera.cameraPosition == AVCaptureDevicePositionFront) {
        [image setInputRotation:kGPUImageRotate180 atIndex:0];
    }
    

    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = @[(id)[[UIColor lightGrayColor] CGColor],
                        (id)[[UIColor darkGrayColor] CGColor]];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (IBAction)btnCaptureClicked:(id)sender
{
    [stillCamera capturePhotoAsImageProcessedUpToFilter:nil withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        UIImageWriteToSavedPhotosAlbum(processedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    if (!error)
    {
        alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Your image successfully saved to gallary." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    }
    else
    {
        alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Your iamge has not been saved." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    }
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
