//
//  NSData.m
//  catzuca
//
//  Created by Thomas on 2013/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "NSData+NSDataAdditions.h"

@implementation NSData (NSDataAdditions)

- (BOOL)dataIsValidPNG:(NSData *)data
{
    if (!data || data.length < 12)
    {
        return NO;
    }
    
    NSInteger totalBytes = data.length;
    const char *bytes = (const char *)[data bytes];
    
    return (bytes[0] == (char)0x89 && // PNG
            bytes[1] == (char)0x50 &&
            bytes[2] == (char)0x4e &&
            bytes[3] == (char)0x47 &&
            bytes[4] == (char)0x0d &&
            bytes[5] == (char)0x0a &&
            bytes[6] == (char)0x1a &&
            bytes[7] == (char)0x0a &&
            
            bytes[totalBytes - 12] == (char)0x00 && // IEND
            bytes[totalBytes - 11] == (char)0x00 &&
            bytes[totalBytes - 10] == (char)0x00 &&
            bytes[totalBytes - 9] == (char)0x00 &&
            bytes[totalBytes - 8] == (char)0x49 &&
            bytes[totalBytes - 7] == (char)0x45 &&
            bytes[totalBytes - 6] == (char)0x4e &&
            bytes[totalBytes - 5] == (char)0x44 &&
            bytes[totalBytes - 4] == (char)0xae &&
            bytes[totalBytes - 3] == (char)0x42 &&
            bytes[totalBytes - 2] == (char)0x60 &&
            bytes[totalBytes - 1] == (char)0x82);
}

@end
