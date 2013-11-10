//
//  searchVC.m
//  catzuca
//
//  Created by cytms on 13/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import "searchVC.h"
#import "catzucaIO.h"

@interface searchVC ()

@end

@implementation searchVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
//    sBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,61,320,30)];
    sBar.delegate = self;
//    [self.view addSubview:sBar];
//    
//    
//    
//    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 91, 300, 400)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
//    [self.view addSubview:myTableView];
    
    //initialize the two arrays; dataSource will be initialized and populated by appDelegate
    searchedData = [[NSMutableArray alloc]init];
    tableData = [[NSMutableArray alloc]init];
    dataSource = [[NSMutableArray alloc] init];
    dataSource = [[catzucaIO sharedData] readPlist];
    //[tableData addObjectsFromArray:dataSource];//on launch it should display all the records
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"contacts error in num of row");
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = [[tableData objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // only show the status bar's cancel button while in edit mode
    sBar.showsCancelButton = YES;
    sBar.autocorrectionType = UITextAutocorrectionTypeNo;
    // flush the previous search content
    [tableData removeAllObjects];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    sBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [tableData removeAllObjects];// remove all data that belongs to previous search
    if([searchText isEqualToString:@""]||searchText==nil){
        [myTableView reloadData];
        return;
    }
    NSInteger counter = 0;
    
    for(NSDictionary *item in dataSource)
    {
//        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
        NSRange r = [[item objectForKey:@"name"] rangeOfString:searchText];
        if(r.location != NSNotFound)
        {
            //if(r.location== 0)//that is we are checking only the start of the names.
            //{
                [tableData addObject:item];
            //}
        }
        counter++;
//        [pool release];
    }
    [myTableView reloadData];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // if a valid search was entered but the user wanted to cancel, bring back the main list content
    [tableData removeAllObjects];
    [tableData addObjectsFromArray:dataSource];
    @try{
        [myTableView reloadData];
    }
    @catch(NSException *e){
        
    }
    [sBar resignFirstResponder];
    sBar.text = @"";
}

// called when Search (in our case "Done") button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
