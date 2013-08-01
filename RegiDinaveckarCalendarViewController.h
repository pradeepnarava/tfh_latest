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
@class RegiDinaveckarDayCalendarViewController;


@interface RegiDinaveckarCalendarViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>

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

//@property (nonatomic) BOOL isEventNotify,isTotalNotify;

@property (nonatomic, strong) SettingRegistViewController *settingRegViewCntrl;
@property (nonatomic, strong) RegiDinaveckarDayCalendarViewController *regiDinaDayCalendarVC;

////////////////
@property (nonatomic, retain) NSString *buttonString;
@property (nonatomic, retain) NSString *editIndexValue;
@property (nonatomic, retain) NSString *totalBtnTag;
@property (nonatomic, retain) IBOutlet UIButton *raderaBtn;
@property (nonatomic, retain) NSMutableArray *dataArray,*weekdays,*totalDataArray;
@property (nonatomic, retain) NSMutableDictionary *selectedDictionary;




-(IBAction)calendarDayCellClicked:(id)sender;
-(IBAction)statusButtonClicked:(id)sender;
-(IBAction)closeButtonAction:(id)sender;
-(IBAction)sliderValueChanged:(UISlider*)sender;



-(IBAction)totalOkButtonClicked:(id)sender;
-(IBAction)totalButtonClicked:(id)sender;



///Calendar Weeks
- (void)week:(NSDate *)date;


//************************ GOPAL *****************////
-(void)displayButton;
-(void)databaseInsert;
-(void)getDataSub1Events;
-(void)getDataSub1Total;
-(void)databaseInsertTotal;
-(UIView*)popupView;

-(IBAction)empty:(id)sender;
-(IBAction)empty1:(id)sender;
-(IBAction)empty2:(id)sender;
-(IBAction)empty3:(id)sender;
-(IBAction)empty4:(id)sender;
-(IBAction)empty5:(id)sender;
-(IBAction)empty6:(id)sender;
-(IBAction)raderaButtonClicked:(id)sender;
-(IBAction)okButtonClicked:(id)sender;

//Sub1Events
- (BOOL)findContact:(NSNumber*)questionId;
-(void)updateIntDatabase:(NSDictionary*)recordsDic;
-(void)insertIntoDatabase:(NSDictionary*)recordDic;
-(void)deleteRecord:(NSDictionary*)deleDic;

//Sub1Totals
- (BOOL)findContactTotal:(NSNumber*)questionId;
-(void)updateIntDatabaseT:(NSDictionary*)updateDic;
-(void)insertIntoDatabaseT:(NSDictionary*)recordDic;
-(void)deleteRecordT:(NSDictionary*)deleDic;

@end
