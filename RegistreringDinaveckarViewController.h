//
//  RegistreringDinaveckarViewController.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 22/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "DinaveckarCell.h"

@class RegiDinaveckarCalendarViewController,DataBaseHelper,NewRegistrering;

@interface RegistreringDinaveckarViewController : UIViewController


@property (nonatomic, strong) IBOutlet UITableView *table;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, retain) RegiDinaveckarCalendarViewController *regiDinaCalVC;

- (IBAction)submitButtonAction:(id)sender;
- (void)getData;

-(NSDate*)dateFromString:(NSString*)date;
-(NSString*)yearStringFromDate:(NSDate*)date;
-(NSString*)monthStringFromDate:(NSDate*)date;

@end
