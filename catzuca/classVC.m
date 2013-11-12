//
//  classVC.m
//  catzuca
//
//  Created by cytms on 13/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "classVC.h"
#import "itemsInClassVC.h"
#import "catzucaIO.h"

@interface classVC ()

@end

@implementation classVC {
    NSArray *arr;
}

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
    self.category = [[NSMutableDictionary alloc] init];
    [self.category setObject:@"民宿" forKey:@"houstay"] ;
    [self.category setObject:@"博物館" forKey:@"museum"] ;
    [self.category setObject:@"文化景點" forKey:@"culture"] ;
    [self.category setObject:@"溫泉" forKey:@"hot spring"] ;
    [self.category setObject:@"餐廳" forKey:@"restaurant"] ;
    [self.category setObject:@"工作坊" forKey:@"workshop"] ;
    [self.category setObject:@"表演團體" forKey:@"group"] ;
    arr = [[catzucaIO sharedData] readPlist];

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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.category allValues] objectAtIndex:indexPath.row];
    // Configure the cell...
    
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowItemsInClass"]) {
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        itemsInClassVC *destination = segue.destinationViewController; //segue 連線（起點到終點）
        NSString *category = [[self.category allKeys] objectAtIndex:indexPath.row];
        destination.datum = [[NSMutableArray alloc] init];
        for (NSDictionary *item in arr) {
            if ([[item objectForKey:@"category"] isEqualToString:category]) {
                [destination.datum addObject:item];
            }
        }
        
        NSLog(@"classVC in segue");
        //        [self.navigationController pushViewController:detailViewController animated:YES];
        //
        //        [self.storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
        
    }
}


@end
