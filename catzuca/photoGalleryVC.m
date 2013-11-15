//
//  photoGalleryVC.m
//  catzuca
//
//  Created by Thomas on 2013/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "photoGalleryVC.h"
#import "NSData+NSDataAdditions.h"
#import <FacebookSDK/FacebookSDK.h>
//#import "OGProtocols.h"
#import "catzucaAppDelegate.h"
#import "catzucaIO.h"
#import "photoGalleryShowImage.h"

@interface photoGalleryVC (){
    int _count;
    int _allCellCount;
    UIImageView *imageView;
    UILabel *Title;
    
    UIImagePickerController *picker;
    UIImageView *chooseImageView;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, strong) NSArray *directoryContents;
@property (nonatomic, strong) NSString *documentsDirectory;
//@property (nonatomic, strong) NSData *imageData;

@property (nonatomic, strong) NSMutableArray *wantImageNumber;
@property (nonatomic, strong) NSMutableArray *allImageName;

@end

@implementation photoGalleryVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    activityIndicator = [[UIActivityIndicatorView alloc]
                         initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 20.0f)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicator];
    [self.view bringSubviewToFront:activityIndicator];
    [activityIndicator setHidden:YES];

    
}

- (void) viewWillAppear:(BOOL)animated{
    // find Document folder item
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory = [paths objectAtIndex:0];
    NSError * error;
    _directoryContents = [[NSArray alloc] init];
    
    _directoryContents =  [[NSFileManager defaultManager]
                           contentsOfDirectoryAtPath:_documentsDirectory error:&error];
    
    _count = 0;
    _allCellCount=0;
    _wantImageNumber = [[NSMutableArray alloc] init];
    _allImageName = [[catzucaIO sharedData] getGalleryImageName];
    
    for (int i=0; i<[_directoryContents count]; i++)
    {
        NSData *imageData;
        imageData = [NSData dataWithContentsOfFile:[_documentsDirectory stringByAppendingPathComponent :_directoryContents[i]]];

        if ([imageData dataIsValidPNG:imageData])
        {
            NSLog(@"12345");
            _allCellCount++;
            [_wantImageNumber addObject:[NSString stringWithFormat:@"%d", _allCellCount]];
        }
        else
        {
            
        }
        
    }
    NSLog(@"_allCellCount = %d", _allCellCount);
    
    
    
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //    return [_directoryContents count];
    return _allCellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...

    if (_count > [_directoryContents count]-1)
    {
        NSLog(@"_count >= [_directoryContents count]-1");
        return cell;
    }
    
    Title = (UILabel *)[cell viewWithTag:11];
    imageView = (UIImageView *)[cell viewWithTag:22];
    NSLog(@"hahaha ");
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData* imageData = [NSData dataWithContentsOfFile:[_documentsDirectory stringByAppendingPathComponent: [_directoryContents objectAtIndex:[[_wantImageNumber objectAtIndex:_count] intValue]-1]]];
//        dispatch_async(dispatch_get_main_queue(), ^{
            [imageView setImage:[UIImage imageWithData:imageData]];
            Title.text = [self.allImageName objectAtIndex:_count];
//        });
        _count++;
//    });
    


    
    //    NSString *path = _directoryContents[indexPath.row];
    //    [image valueForKeyPath:[_documentsDirectory stringByAppendingPathComponent:_directoryContents[indexPath.row]]];
    //    [image setValuesForKeysWithDictionary:[_documentsDirectory stringByAppendingPathComponent:_directoryContents[indexPath.row]]];
    
    UIButton *button;
    button = (UIButton *)[cell viewWithTag:33];
//    UIImageView *shareFBImage;
//    shareFBImage = (UIImageView *)[cell viewWithTag:44];
//    [shareFBImage setImage:[UIImage imageNamed:@"FBShare1.png"]];
    [button setTitle:@"" forState:UIControlStateNormal];
    //    [button setTitle:@"分享至臉書" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareToFacebook:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void) shareToFacebook:(UIButton *)sender{
//    NSLog(@"hihi");
//    //    [self shareGameActivity];
//    
//    //    NSURL* url = [NSURL URLWithString:@"https://developers.facebook.com/"];
//    //    [FBDialogs presentShareDialogWithLink:url
//    //                                  handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
//    //                                      if(error) {
//    //                                          NSLog(@"Error: %@", error.description);
//    //                                      } else {
//    //                                          NSLog(@"Success!");
//    //                                      }
//    //                                  }];
//    
//    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
//    params.link = [NSURL URLWithString:@"https://developers.facebook.com/ios"];
//    params.picture = [NSURL URLWithString:@"image1.jpg"];
//    params.name = @"跟著步落客咔ㄘ咔";
//    params.caption = @"Build great apps";
//    [FBDialogs presentShareDialogWithParams:params clientState:nil handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
//        if(error) {
//            NSLog(@"Error: %@", error.description);
//        } else {
//            NSLog(@"Success!");
//        }
//    }];
//
    
    NSIndexPath *indexPath =
    [self.tableView
     indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    NSUInteger row = indexPath.row;
    
    NSString *shareString = [NSString stringWithFormat:@"我最喜歡 %@ 了 <3", [self.allImageName objectAtIndex:indexPath.row]];
    
    NSData *tempimage =[[NSData alloc] initWithContentsOfFile:[_documentsDirectory stringByAppendingPathComponent:_directoryContents[row]]];
    UIImage *shareImage = [UIImage imageWithData:tempimage];
    NSArray *activityItems = [NSArray arrayWithObjects:shareString, shareImage, nil, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:activityViewController animated:YES completion:nil];
}

- (BOOL)shareGameActivity {
    id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject openGraphActionForPost];
    //    action[@"gesture"] = builtInOpenGraphObjects[_lastPlayerCall]; // set action's gesture property
    //    action[@"opposing_gesture"] = builtInOpenGraphObjects[_lastComputerCall]; // set action's opposing_gesture property
    return nil !=
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"fb_sample_rps:throw"
                                 previewPropertyName:@"gesture"
                                             handler:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"photoGalleryShowImage"])
    {
        UITableViewCell *cell = (UITableViewCell *)sender;
        chooseImageView = (UIImageView *)[cell viewWithTag:22];

//        [activityIndicator setHidden:NO];
//        [self.view bringSubviewToFront:activityIndicator];
//        [activityIndicator startAnimating];
        
        NSData *data = UIImagePNGRepresentation(chooseImageView.image);
        
//       [activityIndicator stopAnimating];
        
        photoGalleryShowImage *viewController = segue.destinationViewController;
        viewController.imageData = data;
    }
}

@end

