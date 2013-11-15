//
//  mainVC.h
//  catzuca
//
//  Created by Thomas on 2013/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CMTime.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVVideoComposition.h>
#import <CoreLocation/CoreLocation.h>
@class AVPlayerDemoPlaybackView;
@class AVPlayer;



@interface mainVC : UITableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>{
    AVPlayer* mPlayer;
    CLLocationManager *locationManager;
    
 
}

//@property (weak, nonatomic) IBOutlet UIImageView *upperBarImage;
//@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@property (readwrite, retain) AVPlayer* mPlayer;



//@property (weak, nonatomic) IBOutlet UIImageView *upperBarImage;
//@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@end
