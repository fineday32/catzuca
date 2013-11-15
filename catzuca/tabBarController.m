//
//  tabBarController.m
//  catzuca
//
//  Created by Chuya on 13/11/15.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "tabBarController.h"

@interface tabBarController ()

@end

@implementation tabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
//        for (UITabBarItem *tbi in self.tabBar.items) {
//            [tbi set
//        }
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UITabBarController *tbc = [sb instantiateInitialViewController];
//        UITabBar *tb = tbc.tabBar;
//        
//        NSArray *items = tb.items;
//        
//        for (UITabBarItem *tbi in items) {
//            UIImage *image = tbi.image;
//            tbi.selectedImage = image;
//            
//            tbi.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[UITabBar appearance] setTintColor:[UIColor redColor]];
//    [[UITabBar appearance] setTintColor:[UIColor grayColor]]; // for unselected items that are gray
//    [[UITabBar appearance] setSelectedImageTintColor:[UIColor greenColor]]; // for selected items that are green


//    //  修改tab bar的顏色
//    [[UITabBar appearance] setBarTintColor:[UIColor yellowColor]];
    
    
////    更改文字的顏色
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]
//                                             forState:UIControlStateNormal];

    
////    使用原本圖的顏色
//    NSArray *items = self.tabBar.items;
//    for (UITabBarItem *tbi in items) {
//        UIImage *image = tbi.image;
//        tbi.selectedImage = image;
//        tbi.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
