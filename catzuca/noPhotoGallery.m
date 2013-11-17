//
//  noPhotoGallery.m
//  catzuca
//
//  Created by Thomas on 2013/11/17.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "noPhotoGallery.h"

@implementation noPhotoGallery

- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"hihihere");
    [self.imageView setImage:[UIImage imageNamed:@"noImage.png"]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *_documentsDirectory = [paths objectAtIndex:0];
    NSError * error;
    NSArray *_directoryContents = [[NSArray alloc] init];
    
    _directoryContents =  [[NSFileManager defaultManager]
                           contentsOfDirectoryAtPath:_documentsDirectory error:&error];
    if ([_directoryContents count]!=0)
        [self.navigationController popViewControllerAnimated:NO];
}
@end
