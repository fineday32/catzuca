//
//  catzucaIO.h
//  catzuca
//
//  Created by cytms on 13/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface catzucaIO : NSObject{
    NSDictionary * originData;
}
+ (catzucaIO *)sharedData;
- (NSDictionary *)readPlist;
@end
