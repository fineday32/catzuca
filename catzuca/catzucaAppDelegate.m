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

@implementation catzucaAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"2OMcaBiI4kFBj9pSjQrYb2TGQW8vFOC1VKv41JK3"
                  clientKey:@"AETkYSf5jkSF3xo816qi4HgSyEWtIpOyTB6EnnO1"];
    
    
//    UITabBar *myTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    myTabBar.delegate=self;   //here you need import the protocol <UITabBarDelegate>
//    [self.view addSubview:myTabBar];
//    NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
//    // Assign tab bar item with titles
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    UITabBar *tabBar = tabBarController.tabBar;
//    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"list" image:[UIImage imageNamed:@"shoes-50.png"] tag:0];
//    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"pictures" image:[UIImage imageNamed:@"stack_of_photos-50.png"] tag:1];
//    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"films" image:[UIImage imageNamed:@"movie-50.png"] tag:2];
////    UITabBarItem *tabBarItem4 = [[UITabBarItem alloc] initWithTitle:@"films" image:[UIImage imageNamed:@"movie-50.png"] tag:3];
//    [tabBarItems addObject:tabBarItem1];
//    [tabBarItems addObject:tabBarItem2];
//    [tabBarItems addObject:tabBarItem3];
//    
//    myTabBar.items = tabBarItems;
//    myTabBar.selectedItem = [tabBarItems objectAtIndex:0];
    
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
