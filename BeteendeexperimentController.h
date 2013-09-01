//
//  BeteendeexperimentController.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/2/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface BeteendeexperimentController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate>{
    
    
    UILabel *label,*label1;
    IBOutlet UISlider *slider,*slider1;
    
    UITextView *ex3c2,*ex3c3,*ex3c4,*ex3c5;
    UITextField *ex3c1;
    
    UILabel *slabel1,*slabel2;
    sqlite3 *exerciseDB;
    NSString        *databasePath;
    
    IBOutlet UIScrollView *scroll,*scroll1;
    
    IBOutlet UIView *listofdates, *questionView3;
    
    UITableView *tableview;
    NSMutableArray *listexercise4;
    NSMutableArray *list_exercise4;
    NSString *SelectedDate;
    
    sqlite3_stmt    *statement;
    
    IBOutlet UIButton *raderabutton;
    IBOutlet UIDatePicker *picker;
}


-(IBAction)displayDate:(id)sender;

@property(nonatomic, retain)IBOutlet UITableView *tableview;

@property(nonatomic, retain)NSMutableArray *listexercise4;
@property(nonatomic, retain)NSMutableArray *list_exercise4;
@property(nonatomic, retain)IBOutlet UILabel *label1;
@property(nonatomic, retain)IBOutlet UILabel *slabel1;
@property(nonatomic, retain)IBOutlet UILabel *slabel2;

@property(nonatomic, retain)IBOutlet UITextField *ex3c1;
@property(nonatomic, retain)IBOutlet UITextView *ex3c2;
@property(nonatomic, retain)IBOutlet UITextView *ex3c3;
@property(nonatomic, retain)IBOutlet UITextView *ex3c4;
@property(nonatomic, retain)IBOutlet UITextView *ex3c5;

- (void)clearalltexts;

- (IBAction)skickaButtonClicked:(id)sender;
- (IBAction)changeSlider:(id)sender;
- (IBAction)changeSlider1:(id)sender;

- (IBAction)saveButton:(id)sender;
- (IBAction)newButton:(id)sender;
- (IBAction)nextButton:(id)sender;
- (IBAction)mainlabelalert:(id)sender;
  
- (IBAction)RaderaButton:(id)sender;
- (IBAction)CloseButton:(id)sender;

@end
