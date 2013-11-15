//
//  detailVC.m
//  catzuca
//
//  Created by cytms on 13/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "detailVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "catzucaIO.h"

@interface detailVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (IBAction)openPhotoCamera:(id)sender;
- (IBAction)openCamcorder:(id)sender;

@end

@implementation detailVC

- (void)viewDidLoad{

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    self.navigationItem.title = self.spot[@"name"];
    NSString *tmp = [NSString stringWithFormat:@"%@_%@.jpg", self.spot[@"category"], self.spot[@"id"]];

    self.image.image = [UIImage imageNamed:tmp];
    self.takePhoto.image = [UIImage imageNamed:@"slr_camera2-50.png"];
    self.makeVideo.image = [UIImage imageNamed:@"video_camera-50.png"];
    
    
    //Calculate the expected size based on the font and linebreak mode of your label
//    CGSize maximumLabelSize = CGSizeMake(296, CGFLOAT_MAX);
    
//    CGSize expectedLabelSize = [self.spot[@"address"] sizeWithFont:self.address.font
//                                      constrainedToSize:maximumLabelSize
//                                          lineBreakMode:self.detail.lineBreakMode];
////    NSLog(@"%@", expectedLabelSize);
//    //adjust the label the the new height.
//    CGRect newFrame = self.address.frame;
//    newFrame.size.height = expectedLabelSize.height;
//    self.detail.frame = newFrame;
//    [self.detail setNumberOfLines:0];
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat screenHeight = screenRect.size.height;
    
    NSArray *seq = [NSArray arrayWithObjects:@"name", @"ethnic", @"address", @"telephone", @"type", @"notablework", @"award", @"history", nil];
    NSDictionary *chiname = [[NSDictionary alloc] initWithObjectsAndKeys:@"名稱", @"name",
                                                                         @"地址", @"address",
                                                                         @"電話", @"telephone",
                                                                         @"作品", @"notablework",
                                                                         @"族群", @"ethnic",
                                                                         @"成就", @"award",
                                                                         @"表演類型", @"type",
                                                                         @"歷史", @"history",
                             nil];
    
    int y = 300;
    for( NSString *key in seq ){
        if (self.spot[key] != nil && ![[self.spot[key] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]){
            
            UILabel *label1 =  [[UILabel alloc] initWithFrame: CGRectMake(20, y, 70, 30)];
            label1.text = chiname[key];
            


            
            UILabel *label2 =  [[UILabel alloc] initWithFrame: CGRectMake(75, y+5, 225, 30)];
            label2.attributedText = self.spot[key];
            label2.text = self.spot[key];
            
            label2.numberOfLines = 0;
            
            CGSize maximumLabelSize = CGSizeMake (225,CGFLOAT_MAX);
            CGSize requiredSize = [label2 sizeThatFits:maximumLabelSize];
            CGRect labelFrame = label2.frame;
            labelFrame.size.height = requiredSize.height;
            label2.frame = labelFrame;
            
            
            [self.view addSubview:label1];
            [self.view addSubview:label2];
            
            y += label2.frame.size.height;
            if (y > screenHeight) {
                break;
            }
        }
        
    }
    
//    
//    NSArray *seq = [NSArray arrayWithObjects:@"name", @"ethnic", @"address", @"telephone", @"type", @"notablework", @"award", @"history", nil];
//    NSDictionary *chiname = [[NSDictionary alloc] initWithObjectsAndKeys:@"名稱", @"name",
//                             @"地址", @"address",
//                             @"電話", @"telephone",
//                             @"作品", @"notablework",
//                             @"族群", @"ethnic",
//                             @"成就", @"award",
//                             @"表演類型", @"type",
//                             @"歷史", @"history",
//                             nil];
//    
//    NSString *text = @"";
//    
//    for( NSString *key in seq ){
//        if (self.spot[key] != nil && ![self.spot[key] isEqualToString: @""] ){
//            
//            
//            
//            text = [text stringByAppendingString:chiname[key]];
//            text = [text stringByAppendingString:@"\t"];
//            text = [text stringByAppendingString:self.spot[key]];
//            text = [text stringByAppendingString:@"\n"];
//            
//            
//            
//            
//        }
//        
//        
//        //        self.detail.text = [self.detail.text stringByAppendingString: self.spot[keys[i]]];
//    }
//    
//    self.detail.lineBreakMode = UILineBreakModeWordWrap;
//    self.detail.numberOfLines = 0;
//    self.detail.text = text;
}



- (IBAction)openPhotoCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message: @"Camera is not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

- (IBAction)openCamcorder:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //    //original type
    //    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    //    //
    //    //not to use this method
    //    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    //    //
    picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, nil];
    picker.videoMaximumDuration = 10;
    picker.delegate = self;
    [self presentViewController:picker animated:NO completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    NSLog(@"%@", info);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{    
        if ([mediaType isEqualToString:@"public.image"])
        {
            /*-----save to document file-----*/
            UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            //UIImagePickerControllerEditedImage
            NSData *data = UIImagePNGRepresentation(pickedImage);
            
            NSInteger count = [[catzucaIO sharedData] getCameraImageCount];
            
            NSString *FileName = [NSString stringWithFormat:@"testImageSave%d.png", count];
            NSLog(@"save image name =  testImageSave%d", count);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *tempPath = [documentsDirectory stringByAppendingPathComponent:FileName];
            BOOL success = [data writeToFile:tempPath atomically:YES];
            

            [[catzucaIO sharedData] plusGalleryImageName:[self.spot objectForKey:@"name"]];
            [[catzucaIO sharedData] plusCameraImageCount];
            
            NSLog(@"photo save to document file success ? %d", success);
            
            /*-----save to album-----*/
            UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil);
            NSLog(@"finish Image saving");

            /*-----save the place name where picture taking-----*/
//            [[catzucaIO sharedData] plusGalleryImageName:<#(NSString *)#>];
        }
        else if ([mediaType isEqualToString:@"public.movie"])
        {
            
            /*-----save to document file-----*/
            NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
            
            NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *tempPath = [documentsDirectory stringByAppendingPathComponent:@"testMovieSave1.mp4"];
            
            BOOL success = [videoData writeToFile:tempPath atomically:NO];
            NSLog(@"movie save to document file success ? %d", success);
            
            /*-----save to album-----*/
            NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] relativePath];
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
                UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self,
                                                    @selector(video:didFinishSavingWithError:contextInfo:), nil);
                
                NSLog(@"finish Video saving");
            }
        }
    });
}


-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


@end
