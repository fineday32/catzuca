//
//  photoGalleryShowImage.h
//  catzuca
//
//  Created by Thomas on 2013/11/15.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface photoGalleryShowImage : UIViewController

@property (strong, nonatomic) NSData *imageData;
@property (strong, nonatomic) IBOutlet UIImageView *showImage;


@end
