//
//  UtmanaDateView.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/2/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "EditUtmana.h"
@interface UtmanaDateView : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UITableView *tableView;
    NSMutableArray *listexercise3;
    sqlite3 *exerciseDB;
    NSString *databasePath;
    EditUtmana *eu;
}
@property(nonatomic,retain)IBOutlet UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *listexercise3;
@end
