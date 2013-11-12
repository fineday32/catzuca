//
//  catzucaIO.m
//  catzuca
//
//  Created by cytms on 13/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "catzucaIO.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "catzucaAppDelegate.h"

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

- (NSArray *)readPlist
{
    NSLog(@"in the readPlist.");
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"merged_data" ofType:@"plist"];

//    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    NSArray *dict2 = [[NSArray alloc] init];
    dict2 = [NSArray arrayWithContentsOfFile:filePath];
    
    //NSArray *array = nil;
    return dict2;
    
}

- (NSArray *)getListOfData: (CLLocation *)newLocation and: (NSString *)category
{
    [Parse setApplicationId:@"2OMcaBiI4kFBj9pSjQrYb2TGQW8vFOC1VKv41JK3"
                  clientKey:@"AETkYSf5jkSF3xo816qi4HgSyEWtIpOyTB6EnnO1"];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"OpenData"];
    if ([category isEqualToString:@"all"]) {
        // User's location
        PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        // Interested in locations near user.
        [query whereKey:@"GeoPoint" nearGeoPoint:userGeoPoint];
        // Limit what could be a lot of points.
        query.limit = 20;
        // Final list of objects
//        NSArray *test = [query findObjects];
//        NSLog(test[0][@"address"]);
//        NSLog(@"%@",[test description]);

    }
    else {
        PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:40.0 longitude:-30.0];
        // Interested in locations near user.
        [query whereKey:@"category" nearGeoPoint:userGeoPoint];
        // Limit what could be a lot of points.
        query.limit = 100;
        // Final list of objects
    }
    
    return [query findObjects];

}



@end
