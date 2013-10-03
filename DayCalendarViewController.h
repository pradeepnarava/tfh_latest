//
//  DayCalendarViewController.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 27/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DayCalendarViewController : UIViewController <UIAlertViewDelegate>
    
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}


@property (nonatomic, retain) IBOutlet UIButton *dayButton;
@property (nonatomic, retain) IBOutlet UIScrollView *dayScrollView;
@property (nonatomic, retain) NSString *dayTimenTag;

@property (strong, nonatomic) IBOutlet UIView *popupView,*totalView;
@property (nonatomic, strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *sliderLabel;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField1,*mintsTextField1;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField2,*mintsTextField2;
@property (nonatomic, strong) IBOutlet UITextView *eventDesTextView;


@property (nonatomic, strong) NSString *currentStatuBtn;
@property (nonatomic, retain) NSString *buttonString;
@property (nonatomic, retain) NSString *editIndexValue;
@property (nonatomic, retain) NSString *totalBtnTag;
@property (nonatomic, retain) IBOutlet UIButton *raderaBtn;
@property (nonatomic, strong) NSMutableArray *dataArray,*totalDataArray;



-(IBAction)calendarDayCellClicked:(id)sender;
-(IBAction)statusButtonClicked:(id)sender;
-(IBAction)closeButtonAction:(id)sender;
-(IBAction)sliderValueChanged:(UISlider*)sender;


-(void)raderaClicked:(id)sender;
-(IBAction)raderaButtonClicked:(id)sender;

-(IBAction)totalOkButtonClicked:(id)sender;
-(IBAction)totalButtonClicked:(id)sender;


-(IBAction)dayCell:(id)sender;


-(void)displayButton;
-(void)databaseInsert;
-(void)getDataSub1Events;
-(void)getDataSub1Total;
-(void)databaseInsertTotal;

-(IBAction)okButtonClicked:(id)sender;

//Sub1Events
-(BOOL)findContact:(NSNumber*)questionId;
-(void)updateIntDatabase:(NSDictionary*)recordsDic;
-(void)insertIntoDatabase:(NSDictionary*)recordDic;
-(void)deleteRecord:(NSDictionary*)deleDic;



@end
