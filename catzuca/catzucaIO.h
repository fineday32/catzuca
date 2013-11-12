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


@interface catzucaIO : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    NSArray * originData;
    NSInteger cameraImageCount;
    NSInteger allMergeVideoCount;
    NSMutableArray *allMergeVideo;
    
    AVPlayer* mPlayer;
}
+ (catzucaIO *)sharedData;
- (NSArray *)readPlist;

- (void)plusCameraImageCount;
-(NSInteger)getCameraImageCount;

- (void)setAllMergeVideoCount:(NSInteger)i;
-(NSInteger)getAllMergeVideoCount;

- (void)plusAllMergeVideo:(id)object;
- (NSMutableArray *)getAllMergeVideo;

- (void)mergeAllVideo;


@property (readwrite, retain) AVPlayer* mPlayer;
@end
