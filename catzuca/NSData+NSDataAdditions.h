//
//  NSData.h
//  catzuca
//
//  Created by Thomas on 2013/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSDataAdditions)

- (BOOL)dataIsValidPNG:(NSData *)data;
@end
