//
//  catzucaIO.m
//  catzuca
//
//  Created by cytms on 13/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "catzucaIO.h"

@implementation catzucaIO
static catzucaIO *catzuca = nil;

+ (catzucaIO *)sharedData
{
//    NSLog(@"int the sharedData");
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"merged_data" ofType:@"plist"];
//    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    @synchronized(self){
        if (catzuca==nil)
        {
            catzuca = [catzucaIO new];
        }
    }
    return catzuca;
}

- (NSDictionary *)readPlist
{
    NSLog(@"in the readPlist.");
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"merged_data" ofType:@"plist"];

//    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *dict2 = [[NSArray alloc] init];
    dict2 = [NSArray arrayWithContentsOfFile:filePath];
    
    //NSArray *array = nil;
    return dict2;
    
}
@end
