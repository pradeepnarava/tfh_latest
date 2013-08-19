//
//  RegistreringDinaveckarViewController.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 22/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "DinaveckarCell.h"

@class RegiDinaveckarCalendarViewController;

@interface RegistreringDinaveckarViewController : UIViewController
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}

@property (nonatomic,strong) IBOutlet UITableView *table;
@property (nonatomic,strong) NSMutableArray *dataArray,*sub1EventsArray;
@property (nonatomic, retain) RegiDinaveckarCalendarViewController *regiDinaCalVC;


- (void)deleteRecord:(NSDictionary*)deleDic;
- (IBAction)submitButtonAction:(id)sender;


@end
