//
//  PlusveckaDinaveckarView.h
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/21/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ASDepthModalViewController.h"
#import "PlusveckaDayView.h"
#import "PlusveckaSettingsView.h"
@interface PlusveckaDinaveckarView : UIViewController<UITextFieldDelegate>
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}
@property (nonatomic,strong) PlusveckaDayView *dayView;
@property (nonatomic,copy) NSDate *week;
@property (nonatomic,strong) NSMutableArray *dateArray,*weekdays,*dataArray,*sub1EventsArray,*totalArray;
@property (nonatomic,strong) IBOutlet UIButton *monButton1,*tueButton2,*wedButton3,*thrButton4,*friButton5,*satButton6,*sunButton7,*raderaBtn;
@property (nonatomic,strong) NSMutableDictionary *selectedDictionary;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *popupView,*totalView;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField1,*mintsTextField1;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField2,*mintsTextField2;
@property (nonatomic, strong) IBOutlet UITextView *eventDesTextView;
@property (nonatomic,strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *sliderLabel;
@property (nonatomic, strong) PlusveckaSettingsView *settingsView;

////////////////////// New Code
@property (nonatomic, retain) NSString *buttonString;
@property (nonatomic, retain) NSString *editIndexValue;

-(IBAction)statusButtonClicked:(id)sender;
@end
