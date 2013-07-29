//
//  PlusveckaDinaveckar.h
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/19/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlusveckaDinaveckarView.h"
#import "DinaveckarCell.h"
#import <sqlite3.h>
@interface PlusveckaDinaveckar : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}

@property (nonatomic,strong) IBOutlet UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataArray,*sub1EventsArray;
@property (nonatomic,strong) PlusveckaDinaveckarView *calanderView;


@end
