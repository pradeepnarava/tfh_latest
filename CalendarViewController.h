//
//  CalendarViewController.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
//#import "ASDepthModalViewController.h"

@class SettingRegistViewController;

@interface CalendarViewController : UIViewController <UITextFieldDelegate>

{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}

@property (nonatomic,copy) NSDate *week;
@property (strong, nonatomic) IBOutlet UIView *popupView;

@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) IBOutlet UILabel *monLabel1,*tueLabel2,*wedLabel3,*thrLabel4,*friLabel5,*satLabel6,*sunLabel7,*mainWeekLabel;
@property (nonatomic,strong) IBOutlet UIButton *monButton1,*tueButton2,*wedButton3,*thrButton4,*friButton5,*satButton6,*sunButton7,*currentButtonStatus;

@property (nonatomic, strong) IBOutlet UITextField *hoursTextField1,*mintsTextField1;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField2,*mintsTextField2;
@property (nonatomic, strong) IBOutlet UITextView *eventDesTextView;


@property (nonatomic,strong) NSMutableArray *dateArray,*weekdays;

@property (nonatomic, strong) SettingRegistViewController *settingRegViewCntrl;


-(IBAction)totalButtonClicked:(id)sender;

-(IBAction)calendarDayCellClicked:(id)sender;

-(IBAction)okButtonClicked:(id)sender;



- (NSString *)titleText;
- (NSDate *)firstDayOfWeekFromDate:(NSDate *)date;
- (void)week:(NSDate *)date;
- (void)updateScreens;


@end
