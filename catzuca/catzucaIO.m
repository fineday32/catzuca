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

static void *AVPlayerDemoPlaybackViewControllerStatusObservationContext = &AVPlayerDemoPlaybackViewControllerStatusObservationContext;

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

- (void)mergeAllVideo{
    NSLog(@"in mergeAllVideo!!!!!!!!!!!!!!!");
    
    NSMutableArray *allVideo = [[catzucaIO sharedData] getAllMergeVideo];
    switch ([allMergeVideo count]) {
        case 1:
            break;
        case 2:
        {
            [self createVideo];
            break;
        }
//        case 3:
//            <#statements#>
//            break;
//        case 4:
//            <#statements#>
//            break;
//        case 5:
//            <#statements#>
//            break;
//        case 6:
//            <#statements#>
//            break;
        default: break;
    }
    
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
    id video2 = [allMergeVideo objectAtIndex:1];
    NSURL* url1 = [video1 valueForProperty:ALAssetPropertyURLs];
    NSURL* url2 = [video2 valueForProperty:ALAssetPropertyURLs];

    NSLog(@"url1 = %@", url1);
    NSLog(@"url2 = %@", url2);
    
//    AVURLAsset* firstAsset = [AVURLAsset URLAssetWithURL:url1 options:nil];
//    AVURLAsset * secondAsset = [AVURLAsset URLAssetWithURL:url2 options:nil];


    
    
    AVURLAsset* firstAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"IMG_1442" ofType: @"MOV"]] options:nil];
    AVURLAsset * secondAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"IMG_1449" ofType: @"MOV"]] options:nil];

//    AVURLAsset* firstAsset = [AVURLAsset URLAssetWithURL:allMergeVideo[0].URLs options:nil];
//    AVURLAsset * secondAsset = [AVURLAsset URLAssetWithURL:allMergeVideo[1].URLs options:nil];
    
    
    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"100Point" ofType:@"mp3"]] options:nil];
    
    
    
    
    AVMutableComposition* mixComposition = [[AVMutableComposition alloc] init];
    
    
    AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, firstAsset.duration) ofTrack:[[firstAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    
    
    AVMutableCompositionTrack *secondTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    [secondTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, secondAsset.duration) ofTrack:[[secondAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:firstAsset.duration error:nil];
    
    
    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeAdd(firstAsset.duration, secondAsset.duration)) ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    
    
    AVMutableVideoCompositionInstruction * MainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    
    
    MainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero,  CMTimeAdd(firstAsset.duration, secondAsset.duration));
    
    
    AVMutableVideoCompositionLayerInstruction *FirstlayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:firstTrack];
    //    CGAffineTransform Scale = CGAffineTransformMakeScale(1.2f,1.5f);
    //    CGAffineTransform Move = CGAffineTransformMakeTranslation(0,0);
    
    CGAffineTransform Scale = CGAffineTransformMakeScale(1.2f,1.5f);
    CGAffineTransform Scale2 = CGAffineTransformMakeScale(0.0f,0.0f);
    CGAffineTransform Move = CGAffineTransformMakeTranslation(50,50);
    
    
    [FirstlayerInstruction setTransform:CGAffineTransformConcat(Scale,Move) atTime:kCMTimeZero];
    [FirstlayerInstruction setTransform:CGAffineTransformConcat(Scale2,Move) atTime:firstAsset.duration];
    
    
    
    
    AVMutableVideoCompositionLayerInstruction *SecondlayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:secondTrack];
    //track2 set
    
    CGAffineTransform SecondScale = CGAffineTransformMakeScale(1.2f,1.5f);
    CGAffineTransform SecondMove = CGAffineTransformMakeTranslation(0,0);
    [SecondlayerInstruction setTransform:CGAffineTransformConcat(SecondScale,SecondMove) atTime:kCMTimeZero];
    
    
    MainInstruction.layerInstructions = [NSArray arrayWithObjects:FirstlayerInstruction,SecondlayerInstruction,nil];;
    
    
    AVMutableVideoComposition *MainCompositionInst = [AVMutableVideoComposition videoComposition];
    
    MainCompositionInst.instructions = [NSArray arrayWithObject:MainInstruction];
    MainCompositionInst.frameDuration = CMTimeMake(1, 30);
    MainCompositionInst.renderSize = CGSizeMake(640, 480);
    
    //Finally just add the newly created AVMutableComposition with multiple tracks to an AVPlayerItem and play it using AVPlayer.
    AVPlayerItem * newPlayerItem = [AVPlayerItem playerItemWithAsset:mixComposition];
    
    newPlayerItem.videoComposition = MainCompositionInst;
    self.mPlayer = [AVPlayer playerWithPlayerItem:newPlayerItem];
    [mPlayer addObserver:self forKeyPath:@"status" options:0 context:AVPlayerDemoPlaybackViewControllerStatusObservationContext];
    
    
    
    //write to Document
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:@"mergeVideo.mov"];
    
    NSURL *url = [NSURL fileURLWithPath:myPathDocs];
	
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL=url;
    [exporter setVideoComposition:MainCompositionInst];
    exporter.outputFileType = AVFileTypeQuickTimeMovie;
	
	[exporter exportAsynchronouslyWithCompletionHandler:^
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [self exportDidFinish:exporter];
         });
     }];
}
- (void)exportDidFinish:(AVAssetExportSession*)session
{
	NSURL *outputURL = session.outputURL;
	ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
	if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:outputURL]) {
        [library writeVideoAtPathToSavedPhotosAlbum:outputURL
									completionBlock:^(NSURL *assetURL, NSError *error){
                                        dispatch_async(dispatch_get_main_queue(), ^{
											if (error) {
												NSLog(@"writeVideoToAssestsLibrary failed: %@", error);
											}else{
                                                NSLog(@"Finish merge movie!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                                            }
											
										});
										
									}];
	}
    
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
