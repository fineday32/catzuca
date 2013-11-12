//
//  detailVC.m
//  catzuca
//
//  Created by cytms on 13/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "detailVC.h"

@interface detailVC ()

@end

@implementation detailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.spot[@"name"];
    
    
    //Calculate the expected size based on the font and linebreak mode of your label
//    CGSize maximumLabelSize = CGSizeMake(296, CGFLOAT_MAX);
    
//    CGSize expectedLabelSize = [self.spot[@"address"] sizeWithFont:self.address.font
//                                      constrainedToSize:maximumLabelSize
//                                          lineBreakMode:self.detail.lineBreakMode];
////    NSLog(@"%@", expectedLabelSize);
//    //adjust the label the the new height.
//    CGRect newFrame = self.address.frame;
//    newFrame.size.height = expectedLabelSize.height;
//    self.detail.frame = newFrame;
//    [self.detail setNumberOfLines:0];
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat screenHeight = screenRect.size.height;
    
    NSArray *seq = [NSArray arrayWithObjects:@"name", @"ethnic", @"address", @"telephone", @"type", @"notablework", @"award", @"history", nil];
    NSDictionary *chiname = [[NSDictionary alloc] initWithObjectsAndKeys:@"名稱", @"name",
                                                                         @"地址", @"address",
                                                                         @"電話", @"telephone",
                                                                         @"作品", @"notablework",
                                                                         @"族群", @"ethnic",
                                                                         @"成就", @"award",
                                                                         @"表演類型", @"type",
                                                                         @"歷史", @"history",
                             nil];
    int y = 300;
    for( NSString *key in seq ){
        if (self.spot[key] != nil && ![[self.spot[key] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]){
            
            UILabel *label1 =  [[UILabel alloc] initWithFrame: CGRectMake(20, y, 70, 30)];
            label1.text = chiname[key];
            

            
            UILabel *label2 =  [[UILabel alloc] initWithFrame: CGRectMake(75, y+5, 225, 30)];
            label2.attributedText = self.spot[key];
            label2.text = self.spot[key];
            
            label2.numberOfLines = 0;
            
            CGSize maximumLabelSize = CGSizeMake (225,CGFLOAT_MAX);
            CGSize requiredSize = [label2 sizeThatFits:maximumLabelSize];
            CGRect labelFrame = label2.frame;
            labelFrame.size.height = requiredSize.height;
            label2.frame = labelFrame;
            
            
            [self.view addSubview:label1];
            [self.view addSubview:label2];
            
            y += label2.frame.size.height;
            if (y > screenHeight) {
                break;
            }
        }
        
    }
    
//    
//    NSArray *seq = [NSArray arrayWithObjects:@"name", @"ethnic", @"address", @"telephone", @"type", @"notablework", @"award", @"history", nil];
//    NSDictionary *chiname = [[NSDictionary alloc] initWithObjectsAndKeys:@"名稱", @"name",
//                             @"地址", @"address",
//                             @"電話", @"telephone",
//                             @"作品", @"notablework",
//                             @"族群", @"ethnic",
//                             @"成就", @"award",
//                             @"表演類型", @"type",
//                             @"歷史", @"history",
//                             nil];
//    
//    NSString *text = @"";
//    
//    for( NSString *key in seq ){
//        if (self.spot[key] != nil && ![self.spot[key] isEqualToString: @""] ){
//            
//            
//            
//            text = [text stringByAppendingString:chiname[key]];
//            text = [text stringByAppendingString:@"\t"];
//            text = [text stringByAppendingString:self.spot[key]];
//            text = [text stringByAppendingString:@"\n"];
//            
//            
//            
//            
//        }
//        
//        
//        //        self.detail.text = [self.detail.text stringByAppendingString: self.spot[keys[i]]];
//    }
//    
//    self.detail.lineBreakMode = UILineBreakModeWordWrap;
//    self.detail.numberOfLines = 0;
//    self.detail.text = text;
}

@end
