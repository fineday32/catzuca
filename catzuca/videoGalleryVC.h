//
//  videoGalleryVC.h
//  catzuca
//
//  Created by Thomas on 2013/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>

@interface videoGalleryVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
// For opening UIImagePickerController
-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate;

@property (strong, nonatomic) IBOutlet UIImageView *mergeVideoSuccess;
@property (weak, nonatomic) IBOutlet UIButton *playMergeVideoButtonOutlet;
- (IBAction)playMergeVideoButton:(id)sender;

@property (nonatomic) NSInteger viewCount;
@end
