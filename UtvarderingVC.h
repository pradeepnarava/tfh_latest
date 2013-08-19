//
//  UtvarderingVC.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 04/08/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "MTPopupWindow.h"
@class UtvarderingVeckostatestikVC;

@interface UtvarderingVC : UIViewController
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) UtvarderingVeckostatestikVC *utvarderingVeckosVC;

-(IBAction)buttonClicked:(id)sender;

@end
