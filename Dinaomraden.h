//
//  Dinaomraden.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/11/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ListOfKompass.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Dinaomraden : UIViewController <ListOfKompassDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate>
{
        IBOutlet UIView *subView;
     IBOutlet UIView *settingsView;
    IBOutlet UITextField *text1,*text2,*text3,*text4,*text5,*text6,*text7,*text8,*text9,*text10;
     IBOutlet UILabel*label1,*label2,*label3,*label4,*label5,*label6,*label7,*label8,*label9,*label10;
    IBOutlet UITextField *tf1,*tf2,*tf3,*tf4,*tf5,*tf6,*tf7,*tf8,*tf9,*tf10;
    IBOutlet UIButton *averageBt;
    IBOutlet UILabel *omradeLabel1;
    IBOutlet UILabel *omradeLabel2;
    NSString *scb;
    IBOutlet UIButton *cb1,*cb2,*cb3,*cb4,*cb5,*cb6,*cb7,*cb8,*cb9,*cb10;
//    sqlite3 *exerciseDB;
    NSString        *databasePath;
//    ListOfKompass *lok;
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIButton *skickaButton;
    
    NSString *dateOfCurrentItem;
    ListOfKompass *lok;
    UIImageView *tableImageView;
    UIButton *closeButton;
    
    BOOL recentBtn1Selected;
    BOOL recentBtn2Selected;
    BOOL isOmrade1;
//     UIImage* image;
}
@property (retain, nonatomic) IBOutlet UIButton *raderaButton;

//@property (retain, nonatomic) IBOutlet UIDatePicker *reminderDatePicker;
@property (retain, nonatomic) IBOutlet UIButton *reminderOnButton;
@property (retain, nonatomic) IBOutlet UIButton *reminderOffButton;

@property (retain, nonatomic) IBOutlet UIButton *recentButton1;
@property (retain, nonatomic) IBOutlet UIButton *recentButton2;
@property (retain, nonatomic) IBOutlet UILabel *recentLabel1;
@property (retain, nonatomic) IBOutlet UILabel *recentLabel2;
@property (retain, nonatomic) IBOutlet UILabel *kiLabel;
@property (retain, nonatomic) IBOutlet UILabel *settingBLabel;
@property (retain, nonatomic) IBOutlet UIImageView *settingBImageView;
@property (retain, nonatomic) IBOutlet UIImageView *settingBTitleImageView;

- (IBAction)skickaButtonClicked:(id)sender;

@property (nonatomic,retain)IBOutlet UITextView *textview;
@property (retain, nonatomic) IBOutlet UITextView *textview1;
-(IBAction)averagevalue;
-(IBAction)selectedcheckbox:(id)sender;
-(IBAction)CloseBtn:(id)sender;
-(IBAction)SaveBtn:(id)sender;
-(IBAction)NewBtn:(id)sender;
-(IBAction)listofvalues:(id)sender;
-(IBAction)Increase:(id)sender;
-(IBAction)Decrease:(id)sender;
- (IBAction)deleteEntry:(id)sender;
- (IBAction)generateGraph:(id)sender;
- (IBAction)reminderOnOff:(UIButton *)sender;
- (IBAction)recentButtonsClicked:(id)sender;
@property (retain, nonatomic) IBOutlet UISegmentedControl *weekdaysPickerOutlet;
- (IBAction)weekdaysPickerAction:(id)sender;

@property (retain, nonatomic) IBOutlet UIButton *dayPickerOutlet;
- (IBAction)dayPickerAction:(id)sender;

@end
