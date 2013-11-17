//
//  photoGalleryShowImage.m
//  catzuca
//
//  Created by Thomas on 2013/11/15.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "photoGalleryShowImage.h"

@implementation photoGalleryShowImage

- (void) viewDidLoad{
    NSLog(@"in photoGalleryShowImage");
}
- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"here");
    
    self.navigationItem.hidesBackButton = NO;
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    [self.showImage setImage:[UIImage imageWithData:self.imageData]];
//    });
        
    
}


-(void)backPressed: (id)sender
{
    [self.navigationController popViewControllerAnimated: YES]; // or popToRoot... if required.
}
@end
