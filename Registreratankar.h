//
//  Registreratankar.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "KanslorViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface Registreratankar : UIViewController <UITableViewDelegate, UITableViewDataSource,UITextViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    
    UILabel *nat,*tanke,*tabellen,*flykt;
    sqlite3 *exerciseDB;
    NSString *databasePath;
    UITextView *situation;
    UITextView *negative;
    UITextView *overiga;
    UITextView *beteenden;
    UIAlertView *alert;
    KanslorViewController *kanslor;
  
    IBOutlet UIScrollView *scroll;
    IBOutlet UIScrollView *scroll2;
    sqlite3_stmt  *statement;
    IBOutlet UIView *listofdates;
    UITableView *tableView;
    UITableViewCell *cell;
    NSMutableArray *listexercise1;
    NSString *SelectedDate;
    IBOutlet UIView *PopupView1,*PopupView2,*PopupView3;
    //IBOutlet UIView *PopupView4;
    IBOutlet UIButton *raderabutton;
    NSMutableArray *exercise1_list;
}

-(IBAction)mainlabelalert:(id)sender;

@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSMutableArray *listexercise1;
@property(nonatomic,retain) NSMutableArray *exercise1_list;


@property(nonatomic,retain)IBOutlet UITextView *situation;
@property(nonatomic,retain)IBOutlet UITextView *negative;
@property(nonatomic,retain)IBOutlet UITextView *overiga;
@property(nonatomic,retain)IBOutlet UITextView *beteenden;

//@property(nonatomic, retain)IBOutlet UILabel *label;
@property(nonatomic, retain)IBOutlet UILabel *nat;
@property(nonatomic, retain)IBOutlet UILabel *tanke;
@property(nonatomic, retain)IBOutlet UILabel *tabellen;
@property(nonatomic, retain)IBOutlet UILabel *flykt;
@property (retain, nonatomic) IBOutlet UIButton *skickaButton;


-(IBAction)Sparabutton:(id)sender;
-(IBAction)nyttbutton:(id)sender;
- (IBAction)skickaButtonClicked:(id)sender;

-(IBAction)Editbutton:(id)sender;
-(IBAction)Closelistofdates:(id)sender;
-(IBAction)aMethod:(id)sender;
-(IBAction)mainlabelalert:(id)sender;

@end
