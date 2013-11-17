//
//  catzucaIO.m
//  catzuca
//
//  Created by cytms on 13/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "catzucaIO.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "videoGalleryVC.h"

static void *AVPlayerDemoPlaybackViewControllerStatusObservationContext = &AVPlayerDemoPlaybackViewControllerStatusObservationContext;

#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>
#import "catzucaAppDelegate.h"

@implementation catzucaIO
@synthesize firstAsset, secondAsset, thirdAsset, fourthAsset, fifthAsset, sixthAsset, lastAsset;
@synthesize audioAsset;
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

- (void)plusCameraImageCount{
    cameraImageCount++;
}
-(NSInteger)getCameraImageCount{
    if (cameraImageCount==0)
        cameraImageCount++;
    return cameraImageCount;
}

- (void)setAllMergeVideoCount:(NSInteger) i{
    allMergeVideoCount=i;
}
-(NSInteger)getAllMergeVideoCount{
    return allMergeVideoCount;
}


- (void)plusAllMergeVideo:(id)object{
    if (allMergeVideo == nil)
        allMergeVideo = [[NSMutableArray alloc] init];
    
    
    [allMergeVideo addObject:object];
    
}

- (NSMutableArray *)getAllMergeVideo{
    return allMergeVideo;
}

- (void)setVideoGalleryVCCount{
    videoGalleryVCCount = 0;
}
- (NSInteger)getVideoGalleryVCCount{
    return videoGalleryVCCount;
}
- (void)plusVideoGalleryVCCount{
    videoGalleryVCCount++;
}
- (void)minusVideoGalleryVCCount{
    videoGalleryVCCount--;
}

- (void)plusGalleryImageName:(NSString*) sender{
    if (galleryImageName==nil)
        galleryImageName = [[NSMutableArray alloc] init];
    [galleryImageName addObject:sender];
}
- (NSMutableArray *)getGalleryImageName{
    return galleryImageName;
}

- (NSURL *)getURLForPlayingMergeVideo{
    return URLForPlayingMergeVideo;
}

- (BOOL)getShouldPlayMergeVideo{
    return shouldPlayMergeVideo;
}

- (void)setShouldPlayMergeVideo:(BOOL)sender{
    shouldPlayMergeVideo = sender;
}



- (void)mergeAllVideo{
    NSLog(@"in mergeAllVideo!!!!!!!!!!!!!!!");
    [self createVideo];
}

- (void)createVideo{
    
//    //NSDictionary* video1 = [allMergeVideo objectAtIndex:0] ;
//    for (id asset in allMergeVideo)
//    {
//        NSLog(@"after %@",asset);
//        NSURL* info = [asset valueForProperty:ALAssetPropertyURLs];
////        NSURL* url = [asset valueForKey:UIImagePickerControllerMediaURL];
//        NSLog(@"url = %@", info);
//        //asset
//        
//    }
    
    
    id video1 = [allMergeVideo objectAtIndex:0];
    
    NSURL* url1 = [video1 valueForProperty:ALAssetPropertyAssetURL];
    NSLog(@"url1 = %@", url1);
//    AVURLAsset* firstAsset = [AVAsset assetWithURL:url1];
//    AVURLAsset* secondAsset = [AVAsset assetWithURL:url2];
    firstAsset = [AVAsset assetWithURL:url1];


    if ([allMergeVideo count] >= 2)
    {
        id video2 = [allMergeVideo objectAtIndex:1];
        NSURL* url2 = [video2 valueForProperty:ALAssetPropertyAssetURL];
        secondAsset = [AVAsset assetWithURL:url2];
    }
    
/*----------Detect 3~6 Movie----------*/
    if ([allMergeVideo count] >= 3)
    {
        id video3 = [allMergeVideo objectAtIndex:2];
        NSURL* url3 = [video3 valueForProperty:ALAssetPropertyAssetURL];
        thirdAsset = [AVAsset assetWithURL:url3];
    }

    if ([allMergeVideo count] >= 4)
    {
        id video4 = [allMergeVideo objectAtIndex:3];
        NSURL* url4 = [video4 valueForProperty:ALAssetPropertyAssetURL];
        fourthAsset = [AVAsset assetWithURL:url4];
    }

    if ([allMergeVideo count] >= 5)
    {
        id video5 = [allMergeVideo objectAtIndex:4];
        NSURL* url5 = [video5 valueForProperty:ALAssetPropertyAssetURL];
        fifthAsset = [AVAsset assetWithURL:url5];
    }

    if ([allMergeVideo count] >= 6)
    {
        id video6 = [allMergeVideo objectAtIndex:5];
        NSURL* url6 = [video6 valueForProperty:ALAssetPropertyAssetURL];
        sixthAsset = [AVAsset assetWithURL:url6];
    }

    /*-----Catzuca ending video merge-----*/
    AVURLAsset* lastAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"catzuca ending" ofType: @"mov"]] options:nil];
    
    
//    AVURLAsset* firstAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"IMG_1442" ofType: @"MOV"]] options:nil];
//    AVURLAsset * secondAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"IMG_1449" ofType: @"MOV"]] options:nil];

//    AVURLAsset* firstAsset = [AVURLAsset URLAssetWithURL:allMergeVideo[0].URLs options:nil];
//    AVURLAsset * secondAsset = [AVURLAsset URLAssetWithURL:allMergeVideo[1].URLs options:nil];
    
    /*----------Audio Alternative Choose----------*/

    switch ([allMergeVideo count]) {
        case 1:
        {
            audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"10_ab2" ofType:@"mp3"]] options:nil];
            break;
        }
        case 2:
        {
            audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"20_輕快" ofType:@"mp3"]] options:nil];
            break;
        }
        case 3:
        {
            audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"30_ab" ofType:@"mp3"]] options:nil];
            break;
        }
        case 4:
        {
            audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"40_月光" ofType:@"mp3"]] options:nil];
            break;
        }
        case 5:
        {
            audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"50_歡樂" ofType:@"mp3"]] options:nil];
            break;
        }
        case 6:
        {
            audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"60_太巴朗" ofType:@"mp3"]] options:nil];
            break;
        }
        default: break;
    }
//    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"100Point" ofType:@"mp3"]] options:nil];
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
//    if (firstAsset !=nil && secondAsset!=nil) {
        
//        [activityView startAnimating];
        // 1 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
        AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
        // 2 - Video track
        AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                            preferredTrackID:kCMPersistentTrackID_Invalid];
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, firstAsset.duration)
                            ofTrack:[[firstAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
        [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, secondAsset.duration)
                            ofTrack:[[secondAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:firstAsset.duration error:nil];
    
        CMTime totalTime = CMTimeAdd(firstAsset.duration, secondAsset.duration) ;
//        NSLog(@"totalTime %@", totalTime);
        NSLog(@"testTime 2 w/ input 0, 30: value: %lld, timescale %d, seconds: %f",
              totalTime.value, totalTime.timescale,
              (float) totalTime.value / totalTime.timescale);
        
/*----------Access 3~6 Movie----------*/
        if (thirdAsset != nil)
        {
            [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, thirdAsset.duration)
                                ofTrack:[[thirdAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:totalTime error:nil];
//            CMTime temp = totalTime;
//            totalTime = CMTimeAdd(temp, thirdAsset.duration);
            totalTime = CMTimeAdd(totalTime, thirdAsset.duration);
//            NSLog(@"totaltime3 = %@", totalTime);
            NSLog(@"testTime 3 w/ input 0, 30: value: %lld, timescale %d, seconds: %f",
                  totalTime.value, totalTime.timescale,
                  (float) totalTime.value / totalTime.timescale);

        }
        
        if (fourthAsset != nil)
        {
            [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, fourthAsset.duration)
                                ofTrack:[[fourthAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:totalTime error:nil];
//            CMTime temp = totalTime;
//            totalTime = CMTimeAdd(temp, fourthAsset.duration);
            totalTime = CMTimeAdd(totalTime, fourthAsset.duration);
            
            NSLog(@"testTime 4 w/ input 0, 30: value: %lld, timescale %d, seconds: %f",
                  totalTime.value, totalTime.timescale,
                  (float) totalTime.value / totalTime.timescale);

        }

        if (fifthAsset != nil)
        {
            [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, fifthAsset.duration)
                                ofTrack:[[fifthAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:totalTime error:nil];
//            CMTime temp = totalTime;
//            totalTime = CMTimeAdd(temp, fifthAsset.duration);
            totalTime = CMTimeAdd(totalTime, fifthAsset.duration);
            
            NSLog(@"testTime 5 w/ input 0, 30: value: %lld, timescale %d, seconds: %f",
                  totalTime.value, totalTime.timescale,
                  (float) totalTime.value / totalTime.timescale);

        }

        if (sixthAsset != nil)
        {
            [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, sixthAsset.duration)
                                ofTrack:[[sixthAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:totalTime error:nil];
//            CMTime temp = totalTime;
//            totalTime = CMTimeAdd(temp, sixthAsset.duration);
            totalTime = CMTimeAdd(totalTime, sixthAsset.duration);
            
            NSLog(@"testTime 6 w/ input 0, 30: value: %lld, timescale %d, seconds: %f",
                  totalTime.value, totalTime.timescale,
                  (float) totalTime.value / totalTime.timescale);

        }

        /*-----Catzuca last asset-----*/
    [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, lastAsset.duration)
                        ofTrack:[[lastAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:totalTime error:nil];
    //            CMTime temp = totalTime;
    //            totalTime = CMTimeAdd(temp, sixthAsset.duration);
    totalTime = CMTimeAdd(totalTime, lastAsset.duration);
    
    NSLog(@"testTime 6 w/ input 0, 30: value: %lld, timescale %d, seconds: %f",
          totalTime.value, totalTime.timescale,
          (float) totalTime.value / totalTime.timescale);
        /*----------------------------*/

    
        // 3 - Audio track
        if (audioAsset!=nil){
            AVMutableCompositionTrack *AudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                                preferredTrackID:kCMPersistentTrackID_Invalid];
//            [AudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeAdd(firstAsset.duration, secondAsset.duration))
//                                ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
            [AudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, totalTime)
                                ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
            
        }
        
        // 4 - Get path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                                 [NSString stringWithFormat:@"mergeVideo-%d.mov",arc4random() % 1000]];
        NSURL *url = [NSURL fileURLWithPath:myPathDocs];
    
        URLForPlayingMergeVideo = [NSURL URLWithString:myPathDocs];
    
        // 5 - Create exporter
        AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                          presetName:AVAssetExportPresetHighestQuality];
        exporter.outputURL=url;
        exporter.outputFileType = AVFileTypeQuickTimeMovie;
        exporter.shouldOptimizeForNetworkUse = YES;
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self exportDidFinish:exporter];
            });
        }];
//    }
    

    
    
}



-(void)exportDidFinish:(AVAssetExportSession*)session {
    if (session.status == AVAssetExportSessionStatusCompleted) {
        NSURL *outputURL = session.outputURL;
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
            [library writeVideoAtPathToSavedPhotosAlbum:outputURL completionBlock:^(NSURL *assetURL, NSError *error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    } else {

                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"完成了耶" message:@"恭喜，難以忘懷的紀念影片出現摟"
                                                                       delegate:self cancelButtonTitle:@"Ya！" otherButtonTitles: nil];
                        [alert show];
                        [[catzucaIO sharedData] setShouldPlayMergeVideo:YES];                        
                    }
                });
            }];
        }
    }
    audioAsset = nil;
    firstAsset = nil;
    secondAsset = nil;
    thirdAsset = nil;
    fourthAsset = nil;
    fifthAsset = nil;
    sixthAsset = nil;
//    [activityView stopAnimating];
}

- (NSArray *)getListOfData: (CLLocation *)newLocation and: (NSString *)category
{
    [Parse setApplicationId:@"2OMcaBiI4kFBj9pSjQrYb2TGQW8vFOC1VKv41JK3"
                  clientKey:@"AETkYSf5jkSF3xo816qi4HgSyEWtIpOyTB6EnnO1"];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"OpenData"];
    if ([category isEqualToString:@"all"]) {
        // User's location
        PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        NSLog(@"%f %f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
        // Interested in locations near user.
        [query whereKey:@"GeoPoint" nearGeoPoint:userGeoPoint];
        // Limit what could be a lot of points.
        query.limit = 50;
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


//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    //cancelButton index is 0
//    switch (buttonIndex) {
//        case 0:
//            break;
//            
//        case 1: //Play the Merging Video
//        {
//            NSLog(@"Play the Merging Video");
//            sleep(1);
//            [[catzucaIO sharedData] setShouldPlayMergeVideo:YES];
//            
//            // Handle a movie capture
//            NSURL *url = [[catzucaIO sharedData] getURLForPlayingMergeVideo];
//            MPMoviePlayerViewController* theMovie =
//            [[MPMoviePlayerViewController alloc] initWithContentURL: url];
//            
//            [self presentMoviePlayerViewControllerAnimated:theMovie];
//            
//            // Register for the playback finished notification
//            [[NSNotificationCenter defaultCenter]
//             addObserver: self
//             selector: @selector(myMovieFinishedCallback:)
//             name: MPMoviePlayerPlaybackDidFinishNotification
//             object: theMovie];
//
//                
//
//            break;
//        }
//        default: break;
//    }
//}




@end
