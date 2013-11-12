//
//  detailVC.h
//  catzuca
//
//  Created by cytms on 13/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface detailVC : UIViewController <UIActionSheetDelegate, UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *takePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *makeVideo;

@property (strong, nonatomic) PFObject *spot;
@end
