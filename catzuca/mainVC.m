//
//  mainVC.m
//  catzuca
//
//  Created by Thomas on 2013/10/27.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "mainVC.h"
#import "Constant.h"
#import "catzucaIO.h"
#import "KxMenu.h"
#import "detailVC.h"
#import <Parse/Parse.h>


#import <MobileCoreServices/MobileCoreServices.h>
#import "CTAssetsPickerController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

static void *AVPlayerDemoPlaybackViewControllerStatusObservationContext = &AVPlayerDemoPlaybackViewControllerStatusObservationContext;

@interface mainVC () <UINavigationControllerDelegate, CTAssetsPickerControllerDelegate>


@property (strong, nonatomic) NSMutableArray *asset;
@end

@implementation mainVC{
    UIButton *menuButton;
    NSArray *data;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [[catzucaIO sharedData] setVideoGalleryVCCount];
    
//    menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    menuButton.frame = CGRectMake(230, 10, 100, 50);
//    [menuButton setTitle:@"MENU" forState:UIControlStateNormal];
//    [menuButton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:menuButton];


//    [_upperBarImage setBackgroundColor:[UIColor cyanColor]];
//    [_upperBarImage setBackgroundColor:[UIColor colorWithRed:154/255.0f green:189/255.0f blue:212/255.0f alpha:1.0]];
//    [_logoImage setImage:[UIImage imageNamed:@"logo2.jpg"]];
    self->data = [[catzucaIO sharedData] getListOfData: locationManager.location and:@"all"];
    [locationManager stopUpdatingLocation];
    
//    self->data = [[NSArray alloc] init];
//    self->data = [[catzucaIO sharedData] readPlist];
//    for (id element in self->data) {
//        NSLog(@"%@", [element objectForKey:@"name"]);
//    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self->data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    //cell.textLabel.text = [NSString stringWithFormat:@"%@" ;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
//    NSLog(@"row:%@",[self->data objectAtIndex:indexPath.row]);
    UILabel *spotName = (UILabel *)[cell viewWithTag:1001];
    spotName.text = [self->data[indexPath.row] objectForKey:@"name"];
    UIImageView *spotImage = (UIImageView *)[cell viewWithTag:1002];

    NSURL *imgPath = [[NSBundle mainBundle] URLForResource:[self->data[indexPath.row]objectForKey:@"category"] withExtension:@"png"];
    
    NSString *stringPath = [imgPath absoluteString];
    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringPath]];
    
    spotImage.image = [UIImage imageWithData: imageData];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return SPECIAL_HEIGHT;
//}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    
    if ([segue.identifier isEqualToString:@"ShowSpotDetail"]) {
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        PFObject *spot = [self->data objectAtIndex:indexPath.row];
        
        detailVC *detailViewController = segue.destinationViewController; //segue 連線（起點到終點）
        detailViewController.spot = spot;
        
        NSLog(@"in segue");
//        [self.navigationController pushViewController:detailViewController animated:YES];
//        
//        [self.storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}




///////////////////////////////////////////////////////////////
/*----------------------------------下面都先不用動他先忽略3Q---------------------------------------------*/
/*----------------------------------下面都先不用動他先忽略3Q---------------------------------------------*/
/*----------------------------------下面都先不用動他先忽略3Q---------------------------------------------*/
/*----------------------------------下面都先不用動他先忽略3Q---------------------------------------------*/
/*----------------------------------下面都先不用動他先忽略3Q---------------------------------------------*/
/*----------------------------------下面都先不用動他先忽略3Q---------------------------------------------*/
/*----------------------------------是相片和影片有關的東西呢---------------------------------------------*/


- (void)showMenu:(UIButton *)sender
{
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"小 小 步 落 客"
                     image:nil
                    target:nil
                    action:NULL],
      
      [KxMenuItem menuItem:@"我 的 照 片"
                     image:[UIImage imageNamed:@"action_icon"]
                    target:self

                    action:@selector(myPhotoButton:)],



      
      [KxMenuItem menuItem:@"我 的 影 片"
                     image:[UIImage imageNamed:@"check_icon"]
                    target:self

                    action:@selector(createVideo:)],
      [KxMenuItem menuItem:@"testing"
                     image:nil
                    target:self
                    action:@selector(openCamcorder:)]



      

      ];
    
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}

- (void) myPhotoButton:(id)sender{
//    self.PhotoCVC = [self.storyboard instantiateViewControllerWithIdentifier:@"photoCVC"];
//    [self presentViewController:self.PhotoCVC animated:NO completion:^{
//        NSLog(@"to photoCollectionViewController");
//    }];

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];

}

- (void) myVideoButton:(id)sender{
    
    //for Image(Video) Pick
    if (self.asset==nil)
        self.asset = [[NSMutableArray alloc] init];
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.maximumNumberOfSelection = MAX_VEDIO_SELECT_NUM;
    picker.assetsFilter = [ALAssetsFilter allAssets];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
        
}

- (void) pushMenuItem:(id)sender
{
    NSLog(@"%@", sender);
}



- (void)createVideo:(id)sender {
    
//    NSMutableArray *imageArray;
//    NSArray* imagePaths = [[NSBundle mainBundle] pathsForResourcesOfType:@"jpg" inDirectory:nil];
//    imageArray = [[NSMutableArray alloc] initWithCapacity:imagePaths.count];
//    for (NSString* path in imagePaths)
//    {
//        [imageArray addObject:[UIImage imageWithContentsOfFile:path]];
//        //NSLog(@"-->image path= %@", path);
//    }
    

    AVURLAsset* firstAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"IMG_1442" ofType: @"MOV"]] options:nil];
    AVURLAsset * secondAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"IMG_1449" ofType: @"MOV"]] options:nil];

    
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
    CGAffineTransform Scale = CGAffineTransformMakeScale(0.5f,0.5f);
    CGAffineTransform Move = CGAffineTransformMakeTranslation(50,50);

    [FirstlayerInstruction setTransform:CGAffineTransformConcat(Scale,Move) atTime:kCMTimeZero];
    

    AVMutableVideoCompositionLayerInstruction *SecondlayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:secondTrack];
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
                                                NSLog(@"Writing3");
                                            }
											
										});
										
									}];
	}

}

- (void)observeValueForKeyPath:(NSString*) path ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if (mPlayer.status == AVPlayerStatusReadyToPlay) {
//        [self.mPlaybackView setPlayer:self.mPlayer];
        [self.mPlayer play];
    }
}



- (void) openCamcorder:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //    //original type
    //    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    //    //
    //    //not to use this method
    //    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    //    //
    picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeMovie, nil];
    picker.videoMaximumDuration = 10;
    picker.delegate = self;
    [self presentViewController:picker animated:NO completion:nil];

}


// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {

    [[picker parentViewController] dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Video recording canceled");
    }];

}


// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {

    //    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    //    UIImage *originalImage, *editedImage, *imageToSave;
    //
    //    // Handle a still image capture
    //    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
    //        == kCFCompareEqualTo) {
    //
    //        editedImage = (UIImage *) [info objectForKey:
    //                                   UIImagePickerControllerEditedImage];
    //        originalImage = (UIImage *) [info objectForKey:
    //                                     UIImagePickerControllerOriginalImage];
    //
    //        if (editedImage) {
    //            imageToSave = editedImage;
    //        } else {
    //            imageToSave = originalImage;
    //        }
    //
    //        // Save the new image (original or edited) to the Camera Roll
    //        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    //    }
    //
    //    // Handle a movie capture
    //    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
    //        == kCFCompareEqualTo) {
    //
    //
    //        NSString *moviePath = [info objectForKey:[UIImagePickerControllerMediaURL]];
    //
    ////        [[info objectForKey:
    ////                                UIImagePickerControllerMediaURL] path];
    //
    //        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
    //            UISaveVideoAtPathToSavedPhotosAlbum (
    //                                                 moviePath, nil, nil, nil);
    //        }
    //    }
    //


    NSString *sourcePath = [[info objectForKey:@"UIImagePickerControllerMediaURL"]relativePath];
    UISaveVideoAtPathToSavedPhotosAlbum(sourcePath,nil,nil,nil);

    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];

}

@end




















