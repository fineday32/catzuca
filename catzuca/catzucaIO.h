//
//  catzucaIO.h
//  catzuca
//
//  Created by cytms on 13/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CMTime.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVVideoComposition.h>

@class AVPlayerDemoPlaybackView;
@class AVPlayer;
typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);
#import <Parse/Parse.h>


@interface catzucaIO : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    NSArray * originData;
    NSInteger cameraImageCount;
    NSInteger allMergeVideoCount;
    NSMutableArray *allMergeVideo;
    NSInteger videoGalleryVCCount;
    AVPlayer* mPlayer;
    NSMutableArray* galleryImageName;
    NSURL* URLForPlayingMergeVideo;
    BOOL shouldPlayMergeVideo;
}

+ (catzucaIO *)sharedData;
- (NSArray *)readPlist;

- (void)plusCameraImageCount;
-(NSInteger)getCameraImageCount;

- (void)setAllMergeVideoCount:(NSInteger)i;
-(NSInteger)getAllMergeVideoCount;

- (void)plusAllMergeVideo:(id)object;
- (NSMutableArray *)getAllMergeVideo;

- (void)setVideoGalleryVCCount;
- (NSInteger)getVideoGalleryVCCount;
- (void)plusVideoGalleryVCCount;
- (void)minusVideoGalleryVCCount;

- (void)mergeAllVideo;

- (void)plusGalleryImageName:(NSString*) sender;
- (NSMutableArray *)getGalleryImageName;

- (NSURL *)getURLForPlayingMergeVideo;

- (BOOL)getShouldPlayMergeVideo;
- (void)setShouldPlayMergeVideo:(BOOL)sender;

@property (readwrite, retain) AVPlayer* mPlayer;
- (NSArray *)getListOfData: (CLLocation *)newLocation and: (NSString *)category;

@property (nonatomic, strong) AVAsset* firstAsset;
@property (nonatomic, strong) AVAsset* secondAsset;
@property (nonatomic, strong) AVAsset* thirdAsset;
@property (nonatomic, strong) AVAsset* fourthAsset;
@property (nonatomic, strong) AVAsset* fifthAsset;
@property (nonatomic, strong) AVAsset* sixthAsset;
@property(nonatomic, strong) AVAsset *audioAsset;

@end
