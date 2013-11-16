//
//  itemsInClassVC.m
//  catzuca
//
//  Created by cytms on 13/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "itemsInClassVC.h"
#import "catzucaIO.h"
#import "detailVC.h"

@interface itemsInClassVC ()

@end

@implementation itemsInClassVC

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
//        if [item objectForKey:@"category"] == self.category
//            [self.d
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    // Return the number of rows in the section.
    return self.datum.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    UILabel *spotName = (UILabel *)[cell viewWithTag:1001];
    spotName.text = [[self.datum objectAtIndex:indexPath.row] objectForKey:@"name"];
    UIImageView *spotImage = (UIImageView *)[cell viewWithTag:1002];
    
    NSURL *imgPath = [[NSBundle mainBundle] URLForResource:[[self.datum objectAtIndex:indexPath.row] objectForKey:@"category"] withExtension:@"png"];
    
    NSString *stringPath = [imgPath absoluteString];
    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringPath]];
    
    spotImage.image = [UIImage imageWithData: imageData];
    
//    cell.textLabel.text = [[self.datum objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([segue.identifier isEqualToString:@"ShowSpotDetail"]) {
         UITableViewCell *cell = (UITableViewCell *)sender;
         NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
         PFObject *spot = [self.datum objectAtIndex:indexPath.row];
 
         detailVC *detailViewController = segue.destinationViewController; //segue 連線（起點到終點）
         detailViewController.spot = spot;
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

@end
