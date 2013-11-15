//
//  videoGalleryVC.m
//  catzuca
//
//  Created by Thomas on 2013/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "videoGalleryVC.h"
#import "CTAssetsPickerController.h"
#import "Constant.h"
#import "UIButton+Bootstrap.h"
#import "catzucaIO.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "UIButton+Bootstrap.h"

@interface videoGalleryVC ()<UINavigationControllerDelegate, CTAssetsPickerControllerDelegate>{

}

@property (strong, nonatomic) NSMutableArray *asset;

@end


@implementation videoGalleryVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [[catzucaIO sharedData] plusVideoGalleryVCCount];
    if ([[catzucaIO sharedData] getVideoGalleryVCCount]%2)
    {
        [self.playMergeVideoButtonOutlet setTitle:@"" forState:UIControlStateNormal];
        self.playMergeVideoButtonOutlet.enabled = NO;
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"咔ㄘ咔影片製作" message:@"\n從先前各地部族拍的影片中\n\n各位步落客們可挑選2~6部短片\n\n合成最長一分鐘的紀念影片\n\n將獲得意想不到的驚喜與回憶唷！\n\n趕快來試試看吧 （*^_^*）" delegate:self cancelButtonTitle:@"我了解了" otherButtonTitles: nil];
        [alert show];
    }
    else{
        [self.playMergeVideoButtonOutlet setTitle:@"立即觀看！" forState:UIControlStateNormal];
        self.playMergeVideoButtonOutlet.enabled = YES;
        [self.playMergeVideoButtonOutlet infoStyle];
    }
    //for Image(Video) Pick
    if (self.asset==nil)
        self.asset = [[NSMutableArray alloc] init];
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.maximumNumberOfSelection = MAX_VEDIO_SELECT_NUM;
    picker.assetsFilter = [ALAssetsFilter allAssets];
    picker.delegate = self;
    [self presentViewController:picker animated:NO completion:nil];

}

- (void)viewDidLoad{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mergeVideoSuccess setImage:[UIImage imageNamed:@"mergeVideoSuccess"]];
    });
    
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"步落客紀念影片" message:@"想製作步落客的紀念影片嘛" delegate:self cancelButtonTitle:@"沒關係" otherButtonTitles:@"先看看現在的影片", @"馬上來做！", nil];
//    [alert show];
    
}

- (void) startMergingVideo:(id)sender{
    NSLog(@"here!!!");
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    //cancelButton index is 0
//    if (buttonIndex==0)
//    {
//
//    }
//    else if (buttonIndex==1)
//    {
//        [self startMediaBrowserFromViewController:self usingDelegate:self];
//    }
//    else if (buttonIndex==2)
//    {
//        
//        //for Image(Video) Pick
//        if (self.asset==nil)
//            self.asset = [[NSMutableArray alloc] init];
//        CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
//        picker.maximumNumberOfSelection = MAX_VEDIO_SELECT_NUM;
//        picker.assetsFilter = [ALAssetsFilter allAssets];
//        picker.delegate = self;
//        [self presentViewController:picker animated:NO completion:nil];
//    }
//}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate {
    // 1 - Validations
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = delegate;
    // 3 - Display image picker
    [controller presentViewController:mediaUI animated:YES completion:nil];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 1 - Get media type
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    // 2 - Dismiss image picker
    [self dismissViewControllerAnimated:NO completion:nil];
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        // 3 - Play the video
        MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc]
                                                 initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        [self presentMoviePlayerViewControllerAnimated:theMovie];
        // 4 - Register for the playback finished notification
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    }
}
// For responding to the user tapping Cancel.
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (IBAction)playMergeVideoButton:(id)sender {
    if ([[catzucaIO sharedData] getShouldPlayMergeVideo])
    {
        
        [[catzucaIO sharedData] minusVideoGalleryVCCount];
        // Handle a movie capture
        NSURL *url = [[catzucaIO sharedData] getURLForPlayingMergeVideo];
        MPMoviePlayerViewController* theMovie =
        [[MPMoviePlayerViewController alloc] initWithContentURL: url];
        
        // Register for the playback finished notification
        [[NSNotificationCenter defaultCenter]
         addObserver: self
         selector: @selector(myMovieFinishedCallback:)
         name: MPMoviePlayerPlaybackDidFinishNotification
         object: theMovie];

        
        theMovie.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [self presentMoviePlayerViewControllerAnimated:theMovie];

        
    }
}

// When the movie is done, release the controller.
-(void) myMovieFinishedCallback: (NSNotification*) aNotification
{
    
    [self dismissMoviePlayerViewControllerAnimated];
    
    MPMoviePlayerController* theMovie = [aNotification object];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver: self
     name: MPMoviePlayerPlaybackDidFinishNotification
     object: theMovie];
    // Release the movie instance created in playMovieAtURL:
}

@end
