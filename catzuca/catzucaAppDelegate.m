//
//  catzucaAppDelegate.m
//  catzuca
//
//  Created by Thomas on 13/10/22.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//
#import <Parse/Parse.h>
#import "catzucaAppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
//#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@implementation catzucaAppDelegate
+ (void)Generalstyle {
    //navigationbar
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *btn = [UIBarButtonItem appearance];
//    [btn setTintColor:[UIColor whiteColor]];
//    UIImage *bg = [[UIImage imageNamed:@"search_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIView *view = [btn valueForKey:@"view"];
//    if (view)
//        [view frame].size.width = (CGFloat)4.0;
    
    [btn setBackgroundImage:[[UIImage imageNamed:@"search_button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    UIButton *button = [[UIButton alloc] init];
//    NSLog(@"Button Tag is %d", button.tag);
//    //[button setBackgroundImage:[UIImage imageNamed:@"search_button.png"] forState:UIControlStateNormal];
//        UIImage *buttonImage = [UIImage imageNamed:@"search_button.png"];
//        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//        button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:button];

    
    
//    UIBarButtonItem *btn = [UIBarButtonItem appearance];
//    btn=barbutton;
    //barbutton.customView = button;
    
    
    // Initialize the UIButton
//    UIImage *buttonImage = [UIImage imageNamed:@"search_button.png"];
//    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [aButton setImage:buttonImage forState:UIControlStateNormal];
//    aButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    

    
    
//    UITableViewCell *cell = [UITableViewCell appearance];
//    [cell setBackgroundColor:[UIColor colorWithRed:227.0/255 green:103.0/255 blue:103.0/255 alpha:0.3]];
    
//    UITabBar *tab = [UITabBar appearance];
//    [tab setBackgroundImage:[UIImage imageNamed:@"tab.png"]];
//    UITableView *tableView = [UITableView appearance];
//    [tableView setBackgroundColor:[UIColor colorWithRed:227.0/255 green:103.0/255 blue:103.0/255 alpha:0.1]];
//    UITableViewCell *cell = [UITableViewCell appearance];
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"cell.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
    
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[self class] Generalstyle];

    // Override point for customization after application launch.
//    [Parse setApplicationId:@"2OMcaBiI4kFBj9pSjQrYb2TGQW8vFOC1VKv41JK3"
//                  clientKey:@"AETkYSf5jkSF3xo816qi4HgSyEWtIpOyTB6EnnO1"];
//    
//    PFObject *testObject = [PFObject objectWithClassName:@"OpenData"];
//    PFQuery *query = [PFQuery queryWithClassName:@"OpenData"];
//    [query whereKey:@"alsoknownas" equalTo:@"原舞者"];
//    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//        if (!object) {
//            NSLog(@"The getFirstObject request failed.");
//        } else {
//            // The find succeeded.
//            NSLog(@"Successfully retrieved the object.");
//        }
//    }];
//    NSLog(@"___________");
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
