//
//  PlusveckaCalander.h
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/18/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface PlusveckaCalenderViewController : UIViewController<UITextFieldDelegate>
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}
@property (nonatomic,copy) NSDate *week;
@property (nonatomic,strong) NSMutableArray *dateArray,*weekdays,*dataArray;
@property (nonatomic,strong) IBOutlet UIButton *monButton1,*tueButton2,*wedButton3,*thrButton4,*friButton5,*satButton6,*sunButton7;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *popupView,*totalView;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField1,*mintsTextField1;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField2,*mintsTextField2;
@property (nonatomic, strong) IBOutlet UITextView *eventDesTextView;
@property (nonatomic,strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *sliderLabel;
@end
