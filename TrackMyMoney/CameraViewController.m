//
//  CameraViewController.m
//  PhotoPicker
//
//  Created by he110world on 13-10-30.
//  Copyright (c) 2013年 Apple Inc. All rights reserved.
//

#import "CameraViewController.h"
//#import "Tesseract.h"

@interface CameraViewController ()
@property UIImagePickerController *imagePicker;
//@property Tesseract *tesseract;
@end

@implementation CameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Init OCR
    //self.tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
        //[self.tesseract setVariableValue:@"0123456789" forKey:@"tessedit_char_whitelist"]; //limit search
    
    // Init camera
    self.imagePicker = [[UIImagePickerController alloc] init];
    
    [self.view addSubview:self.imagePicker.view];
    
    self.imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    self.imagePicker.delegate = self;
    
    //[self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.imagePicker = nil;

    // Dispose of any resources that can be recreated.
}

- (UIImage *)resizeImage:(UIImage *)image toNewSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)doOCR:(UIImage *)image
{
    // OCR
    //[self.tesseract setImage:image]; //image to check
    //[self.tesseract recognize];
    //NSLog(@"%@", [self.tesseract recognizedText]);
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Resize the captured image to screen size
    UIImage *image = [self resizeImage:[info valueForKey:UIImagePickerControllerOriginalImage] toNewSize:[self.view bounds].size];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    [self.imagePicker.view removeFromSuperview];
    
    // Just popup a numpad
    
    //[self performSegueWithIdentifier:@"GotoOCR" sender:self];
    
    // Save image to file
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'-'HH'-'mm'-'ss'.jpg'"];

    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSData* imageData = UIImageJPEGRepresentation(image, 0.8);
    [imageData writeToFile:dateString atomically:YES];
}
@end
