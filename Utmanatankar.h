//
//  Utmanatankar.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/1/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface Utmanatankar : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>
{
    UILabel *regTankerLabel,*strategier,*quesitonLabel1,*questionLabel2,*questionLabel3,*questionLabel4,*questionLabel5,*questionLabel6;
    UITextView *c1,*c2,*c4,*c5,*c6;
    UILabel *c3;
    sqlite3 *exerciseDB;
    NSString *databasePath;
    
    IBOutlet UISlider *slider;
    
    IBOutlet UIScrollView *scroll,*scroll1;
    UIAlertView *alert;
    
    IBOutlet UIView *listofdates;
    UITableView *tableview;
    NSMutableArray *listexercise3;
    NSMutableArray *list_exercise3;

    
    sqlite3_stmt    *statement;
    NSString *SelectedDate;
    UITableViewCell *cell;
    
    IBOutlet UIView *questionView1,*questionView2,*questionView3,*questionView4,*questionView4_1,*questionView5,*questionView6;
    
    IBOutlet UIView *Label1Popup;
    IBOutlet UIButton *raderaButton;
    
    
    //Gopal
    UILabel *regLabel1,*regLabel2,*regLabel3,*regLabel4,*regLabel5,*regLabel6,*regLabel7,*regLabel8,*regLabel4_1;
    UIButton *regButton1,*regButton2,*regButton3,*regButton4,*regButton5,*regButton6,*regButton7,*regButton8;
    
    
}
//Gopal
@property (nonatomic, retain) NSMutableArray *selectedRegistreraTankars;
@property (nonatomic, retain) NSMutableArray *registreraTankars;

//Gopal ******
@property(nonatomic, retain)IBOutlet UILabel *regLabel1,*regLabel2,*regLabel3,*regLabel4,*regLabel5,*regLabel6,*regLabel7,*regLabel8,*regLabel4_1;
@property(nonatomic, retain)IBOutlet UIButton *regButton1,*regButton2,*regButton3,*regButton4,*regButton5,*regButton6,*regButton7,*regButton8;
///Gopal **********


@property(nonatomic, retain)IBOutlet UILabel *regTankerLabel;

@property(nonatomic, retain)IBOutlet UILabel *strategier;

@property(nonatomic, retain)IBOutlet UILabel *quesitonLabel1;
@property(nonatomic, retain)IBOutlet UILabel *quesitonLabel2;
@property(nonatomic, retain)IBOutlet UILabel *quesitonLabel3;
@property(nonatomic, retain)IBOutlet UILabel *quesitonLabel4;
@property(nonatomic, retain)IBOutlet UILabel *quesitonLabel4_1;
@property(nonatomic, retain)IBOutlet UILabel *questionLabel5;
@property(nonatomic, retain)IBOutlet UILabel *questionLabel6;

@property(nonatomic, retain)IBOutlet  UILabel *c3;
@property(nonatomic, retain)IBOutlet  UITextView *c1;
@property(nonatomic, retain)IBOutlet  UITextView *c2;
@property(nonatomic, retain)IBOutlet  UITextView *c4;
@property(nonatomic, retain)IBOutlet  UITextView *c5;
@property(nonatomic, retain)IBOutlet  UITextView *c6;
@property (retain, nonatomic) IBOutlet UIButton *skickaButton;

-(IBAction)changeSlider:(id)sender ;
-(IBAction)sparabutton:(id)sender;
-(IBAction)newbutton:(id)sender;
-(IBAction)nextbutton:(id)sender;
-(IBAction)labelalert:(id)sender;

-(void)getDataFromtheRegistreratanker;

-(IBAction)Closelistofdates:(id)sender;

- (IBAction)SelectChekBoxs:(id)sender;
- (IBAction)aMethod:(id)sender;
- (IBAction)skickaButtonClicked:(id)sender;

@property(nonatomic, retain) IBOutlet UITableView *tableview;
@property(nonatomic, retain) NSMutableArray *listexercise3;
@property(nonatomic, retain) NSMutableArray *list_exercise3;

@end

