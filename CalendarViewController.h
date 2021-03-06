//
//  CalendarViewController.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "PlusveckaDayView.h"


@class SettingRegistViewController;
@class DayCalendarViewController;

@interface CalendarViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>

{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}

////////////////////// New Code
@property (nonatomic,strong) PlusveckaDayView *dayView;
@property (nonatomic,copy) NSDate *week;
@property (strong, nonatomic) IBOutlet UIView *popupView,*totalView;

@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
//@property (nonatomic, strong) UILabel *monLabel1,*tueLabel2,*wedLabel3,*thrLabel4,*friLabel5,*satLabel6,*sunLabel7,*mainWeekLabel;
@property (nonatomic, strong) IBOutlet UILabel *sliderLabel;
@property (nonatomic, strong) IBOutlet UIButton *monButton1,*tueButton2,*wedButton3,*thrButton4,*friButton5,*satButton6,*sunButton7;

@property (nonatomic, strong) IBOutlet UITextField *hoursTextField1,*mintsTextField1;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField2,*mintsTextField2;
@property (nonatomic, strong) IBOutlet UITextView *eventDesTextView;

@property (nonatomic) BOOL isEventNotify,isTotalNotify;

@property (nonatomic, strong) SettingRegistViewController *settingRegViewCntrl;
@property (nonatomic, strong) DayCalendarViewController *dayCalendarVC;

////////////////
@property (nonatomic, retain) NSString *buttonString;
@property (nonatomic, retain) NSString *editIndexValue;
@property (nonatomic, retain) NSString *totalBtnTag;
@property (nonatomic, retain) IBOutlet UIButton *raderaBtn;
@property (nonatomic, strong) NSMutableArray *dataArray,*weekdays,*totalDataArray,*dataArrayCount;



/////////*************** Calendar Events from iPhone Calendar *************//////////////

///Calendar Event from iPhone Default Calendar
@property (nonatomic, strong) EKEventStore *eventStore;

// Default calendar associated with the above event store
@property (nonatomic, strong) EKCalendar *defaultCalendar;

// Array of all events happening within the next 24 hours
@property (nonatomic, strong) NSMutableArray *eventsList;

/////*********************///////////////////////////////////////

////////********** New Registreringsvecka **********//////
@property (nonatomic,assign)int newRowId;

//////////
- (void)checkEventStoreAccessForCalendar;
- (void)requestCalendarAccess;
- (void)accessGrantedForCalendar;
- (void)fetchEvents;


////*********************///////


-(IBAction)calendarDayCellClicked:(id)sender;
-(IBAction)statusButtonClicked:(id)sender;
-(IBAction)closeButtonAction:(id)sender;
-(IBAction)sliderValueChanged:(UISlider*)sender;



-(IBAction)totalOkButtonClicked:(id)sender;
-(IBAction)totalButtonClicked:(id)sender;



///Calendar Weeks
- (NSDate *)firstDayOfWeekFromDate:(NSDate *)date;
- (void)week:(NSDate *)date;
- (NSString*)dateFromStringCal:(NSDate*)date;

//************************ GOPAL *****************////
- (void)displayButton;
- (void)databaseInsert;
- (void)getDataSub1Events;
- (void)getDataSub1Total;
- (void)databaseInsertTotal;
- (UIView*)popupView;

/*- (void)empty:(id)sender;
- (void)empty1:(id)sender;
- (void)empty2:(id)sender;
- (void)empty3:(id)sender;
- (void)empty4:(id)sender;
- (void)empty5:(id)sender;
- (void)empty6:(id)sender;
 
 //Sub1Events
 - (BOOL)findContact:(NSNumber*)questionId;
 - (void)updateIntDatabase:(NSDictionary*)recordsDic;
 - (void)insertIntoDatabase:(NSDictionary*)recordDic;
 - (void)deleteRecord:(NSDictionary*)deleDic;

*/

- (IBAction)raderaButtonClicked:(id)sender;
- (void)raderaClicked:(id)sender;
- (IBAction)okButtonClicked:(id)sender;


//Sub1Totals
- (BOOL)findContactTotal:(NSNumber*)questionId;
- (void)updateIntDatabaseT:(NSDictionary*)updateDic;
- (void)insertIntoDatabaseT:(NSDictionary*)recordDic;
- (void)deleteRecordT:(NSDictionary*)deleDic;

@end
