//
//  PlusveckaDayView.h
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/21/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ASDepthModalViewController.h"
#import "PlusveckaTidigeraViewController.h"
#import "PlusveckaForslagViewController.h"
@interface PlusveckaDayView : UIViewController<UITextFieldDelegate>
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
    BOOL isSub2,isPopup;
}
@property (nonatomic, strong) PlusveckaForslagViewController *forslagController;
@property (nonatomic, strong) PlusveckaTidigeraViewController *tidigeraController;
@property (nonatomic,strong) NSMutableArray *sub1EventsArray,*dataArray,*totalArray;
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *popupView,*totalView;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField1,*mintsTextField1;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField2,*mintsTextField2;
@property (nonatomic, strong) IBOutlet UITextView *eventDesTextView;
@property (nonatomic,strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *sliderLabel;
@property (nonatomic, assign) BOOL isDinackar;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) IBOutlet UIButton *dateButton,*raderaBtn;
@property (nonatomic, strong) NSString *editTotalValue,*dateIndexValue;
@property (nonatomic, strong) NSMutableDictionary *sub2Settings;
////////////////////// New Code
@property (nonatomic, retain) NSString *buttonString;
@property (nonatomic, retain) NSString *editIndexValue;
-(IBAction)statusButtonClicked:(id)sender;
-(IBAction)sliderValueChanged:(UISlider*)sender;
-(IBAction)totalButtonClicked:(id)sender;
-(IBAction)closeButtonClicked:(id)sender;
-(IBAction)okButtonClicked:(id)sender;
-(IBAction)totalOkButtonAction:(id)sender;
@end
