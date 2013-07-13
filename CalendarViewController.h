//
//  CalendarViewController.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SettingRegistViewController;

@interface CalendarViewController : UIViewController




@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) IBOutlet UILabel *monLabel1,*tueLabel2,*wedLabel3,*thrLabel4,*friLabel5,*satLabel6,*sunLabel7;
@property (nonatomic,strong) IBOutlet UIButton *monButton1,*tueButton2,*wedButton3,*thrButton4,*friButton5,*satButton6,*sunButton7;

@property (nonatomic,strong) NSMutableArray *dateArray;

@property (nonatomic, strong) SettingRegistViewController *settingRegViewCntrl;


-(IBAction)totalButtonClicked:(id)sender;
-(IBAction)calendarEmptyCellClicked:(id)sender;
-(IBAction)calendarDayCellClicked:(id)sender;


- (IBAction)forwardCalendar:(id)sender;
- (IBAction)backwardCalender:(id)sender;


@end
