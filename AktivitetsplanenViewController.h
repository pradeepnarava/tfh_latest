//
//  AktivitetsplanenViewController.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/18/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Va_lkommenAppDelegate.h"
#import "ShowEventsBO.h"
#import <EventKitUI/EventKitUI.h>
#import "DayEventViewController.h"
#import <sqlite3.h>
@interface AktivitetsplanenViewController : UIViewController<UIScrollViewDelegate>
{
    Va_lkommenAppDelegate *appDelegate;
    IBOutlet UIView *popupView1,*popupView2;
    IBOutlet UIView *settingView;
    IBOutlet UIDatePicker *pickerOne;
    IBOutlet UIDatePicker *pickerTwo;
    IBOutlet UIDatePicker *pickerThree;
    IBOutlet UIDatePicker *pickerFour;
    IBOutlet UIScrollView *scrollSetting;
    IBOutlet UILabel *lblSlide;
    IBOutlet UISlider *slider;
    NSString *selectedValue;
    sqlite3 *exerciseDB;
    NSString        *databasePath;
    IBOutlet UIButton *MonBtn;
    IBOutlet UIButton *TueBtn;
    IBOutlet UIButton *WedBtn;
    IBOutlet UIButton *ThurBtn;
    IBOutlet UIButton *FriBtn;
    IBOutlet UIButton *SatBtn;
    IBOutlet UIButton *SunBtn;
    
    IBOutlet UIButton *Week_prevBarBtn;
    IBOutlet UIButton *Week_nextBarBtn;
    IBOutlet UILabel *Week_weekBarLbl;
    UIButton *view1;
    IBOutlet UITextView *messageEventTxtView;
    IBOutlet UITextField *txtLbl1,*txtLbl2,*txtLbl3,*txtLbl4;
    
    NSMutableArray *listofallevents;
    NSMutableArray *listofallidentifier;
    NSMutableArray *timeslotArray;
    NSMutableArray *arrayEvents;
    NSMutableArray *arrayShowEvents;
    UIScrollView *scrollview;

    NSDate *selectedDate;
    UIEvent *event;
    CGPoint initialPoint;
    CGPoint endPoint;
    
    int selectedBtnTag;
    CGPoint point;
    int xAxies;
    int yAxies;
    NSMutableArray *arraWeek;
    NSMutableArray *arraWeek2;
    NSString *strDate;
    NSString *OnrOff;
    NSString *text;
    NSString *OnrOffD;
}
@property (nonatomic, retain) Va_lkommenAppDelegate *appDelegate;

-(IBAction)Week_CalendarActionEvents:(id)sender;

- (IBAction)selectOnWeekDay:(id)sender;
- (IBAction)selectSennestBtn:(id)sender;
- (IBAction)closeBtn:(id)sender;
- (IBAction)selectSlider:(id)sender;
- (NSDate *)dateBySubtractingOneDayFromDate:(NSDate *)date;
- (IBAction)selectSettingButton:(id)sender;
- (void)setDates;
- (NSArray *)lastSevenDays;
- (NSInteger)getnewdates;
- (NSDate *)firstDayOfWeekFromDate:(NSDate *)date;

- (void)addColumn:(CGFloat)position;

- (IBAction)close:(id)sender;
- (NSArray *)fetchEventsForToday : (NSDate *)startDate;
-(NSString *)changeformate_string24hr:(NSString *)date;
-(void)loadScheduleView;
- (void)refreshEventsLoad;
-(IBAction)cleartext:(id)sender;
-(IBAction)selectremaindercheckbox:(id)sender;
-(IBAction)remainderON:(id)sender;
-(IBAction)remainderOFF:(id)sender;
-(IBAction)remainderDON:(id)sender;
-(IBAction)remainderDOFF:(id)sender;
-(IBAction)SelectedButtontitle:(id)sender;
@end
