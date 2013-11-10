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
@interface videoGalleryVC ()<UINavigationControllerDelegate, CTAssetsPickerControllerDelegate>
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
	// Do any additional setup after loading the view.
    //for Image(Video) Pick
    if (self.asset==nil)
        self.asset = [[NSMutableArray alloc] init];
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.maximumNumberOfSelection = MAX_VEDIO_SELECT_NUM;
    picker.assetsFilter = [ALAssetsFilter allAssets];
    picker.delegate = self;
    [self presentViewController:picker animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
