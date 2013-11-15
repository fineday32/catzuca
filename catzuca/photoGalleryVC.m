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

@interface photoGalleryVC (){
    int _count;
    int _allCellCount;
    UILabel *Title;
}

@property (nonatomic, strong) NSArray *directoryContents;
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSData *imageData;

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
    
    for (int i=0; i<[_directoryContents count]; i++)
    {
        _imageData = [[NSData alloc] initWithContentsOfFile:[_documentsDirectory stringByAppendingPathComponent:_directoryContents[i]]];
        if ([_imageData dataIsValidPNG:_imageData])
        {
            _allCellCount++;
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
    
    //    if (_count >= [_directoryContents count]-1)
    //        return nil;
    
    //    if (indexPath.row < _count)
    //        return nil;
    
    
    UIImageView *imageView;
    
    Title = (UILabel *)[cell viewWithTag:11];
    
    imageView = (UIImageView *)[cell viewWithTag:22];
    
    _imageData = [[NSData alloc] initWithContentsOfFile:[_documentsDirectory stringByAppendingPathComponent:_directoryContents[_count]]];
    [Title setText:_directoryContents[_count]];
    
    
    while (1)
    {
        if ([_imageData dataIsValidPNG:_imageData])
        {
            NSLog(@"%@ is png", Title.text);
            break;
        }
        else
        {
            NSLog(@"%@ is not png", Title.text);
            _count++;
            _imageData = [[NSData alloc] initWithContentsOfFile:[_documentsDirectory stringByAppendingPathComponent:_directoryContents[_count]]];
            [Title setText:_directoryContents[_count]];
        }
    }
    
    
    [imageView setImage:[UIImage imageWithData:_imageData]];
    _count++;
    
    //    NSString *path = _directoryContents[indexPath.row];
    //    [image valueForKeyPath:[_documentsDirectory stringByAppendingPathComponent:_directoryContents[indexPath.row]]];
    //    [image setValuesForKeysWithDictionary:[_documentsDirectory stringByAppendingPathComponent:_directoryContents[indexPath.row]]];
    
    UIButton *button;
    button = (UIButton *)[cell viewWithTag:33];
    UIImageView *shareFBImage;
    shareFBImage = (UIImageView *)[cell viewWithTag:44];
    [shareFBImage setImage:[UIImage imageNamed:@"FBShare1.png"]];
    [button setTitle:@"" forState:UIControlStateNormal];
    //    [button setTitle:@"分享至臉書" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareToFacebook:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void) shareToFacebook:(UIButton *)sender{
    NSLog(@"hihi");
    //    [self shareGameActivity];
    
    //    NSURL* url = [NSURL URLWithString:@"https://developers.facebook.com/"];
    //    [FBDialogs presentShareDialogWithLink:url
    //                                  handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
    //                                      if(error) {
    //                                          NSLog(@"Error: %@", error.description);
    //                                      } else {
    //                                          NSLog(@"Success!");
    //                                      }
    //                                  }];
    
    NSIndexPath *indexPath =
    [self.tableView
     indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    NSUInteger row = indexPath.row;
    NSLog(@"=================%lu", (unsigned long)row);
    

    NSString *shareString = @"test";
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



@end

