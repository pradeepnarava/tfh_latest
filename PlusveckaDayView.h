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

@interface PlusveckaDayView : UIViewController<UITextFieldDelegate>
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}
@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *popupView,*totalView;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField1,*mintsTextField1;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField2,*mintsTextField2;
@property (nonatomic, strong) IBOutlet UITextView *eventDesTextView;
@property (nonatomic,strong) IBOutlet UISlider *slider;
@property (nonatomic, strong) IBOutlet UILabel *sliderLabel;
@property (nonatomic, assign) BOOL isDinackar;
-(IBAction)statusButtonClicked:(id)sender;
-(IBAction)sliderValueChanged:(UISlider*)sender;
-(IBAction)totalButtonClicked:(id)sender;
-(IBAction)closeButtonClicked:(id)sender;
-(IBAction)okButtonClicked:(id)sender;
-(IBAction)totalOkButtonAction:(id)sender;
@end
