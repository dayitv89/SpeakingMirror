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
    NSLog(@"sandep");
    UIImage *inputImage = [UIImage imageNamed:@"mirrorimage.png"]; // The WID.jpg example is greater than 2048 pixels tall, so it fails on older devices
    
    stillCamera=[[GPUImageStillCamera alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    stillCamera.outputImageOrientation=UIInterfaceOrientationPortrait;
    image=[[GPUImageView alloc]initWithFrame:CGRectMake(30.0, 35.0, 260, 490)];
    image.alpha=0.7;
    [image setBackgroundColor:[UIColor redColor]];
    image.fillMode=kGPUImageFillModePreserveAspectRatioAndFill;
    filter=[[GPUImageGrayscaleFilter alloc]init];
    [self.view addSubview:image];
    //[self.view bringSubviewToFront:btnCapture];
    [stillCamera addTarget:image];
   // [filter addTarget:image];
    [stillCamera startCameraCapture];

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
