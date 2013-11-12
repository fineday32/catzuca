//
//  fadeInSegue.m
//  catzuca
//
//  Created by cytms on 13/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "fadeInSegue.h"

@implementation fadeInSegue
- (void)perform
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2;
    transition.type = kCATransitionFade;
    
    [[[[[self sourceViewController] view] window] layer] addAnimation:transition
                                                               forKey:kCATransitionFade];
    
    [[self sourceViewController]
     presentViewController:[self destinationViewController]
     animated:NO completion:NULL];
}

@end
