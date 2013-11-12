//
//  catzucaIO.h
//  catzuca
//
//  Created by cytms on 13/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface catzucaIO : NSObject{
    NSArray * originData;
}
+ (catzucaIO *)sharedData;
- (NSArray *)readPlist;
- (NSArray *)getListOfData: (CLLocation *)newLocation and: (NSString *)category;

@end
