//
//  searchVC.h
//  catzuca
//
//  Created by cytms on 13/11/10.
//  Copyright (c) 2013年 Thomas Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchVC : UIViewController {
    //UITableView *myTableView;
    NSMutableArray *dataSource; //will be storing all the data
    NSMutableArray *tableData;//will be storing data that will be displayed in table
    NSMutableArray *searchedData;//will be storing data matching with the search string
    
    //UISearchBar *sBar;//search bar
    IBOutlet UISearchBar *sBar;
    IBOutlet UITableView *myTableView;
    
}
@property(nonatomic,retain)NSMutableArray *dataSource;
@end
