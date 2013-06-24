//
//  Utmanatankar.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/1/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface Utmanatankar : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>
{
    UILabel *label2,*strategier,*negative,*din,*motavis,*tanke,*alltanke;
    UITextView *c1,*c2,*c4,*c5,*c6;
    UILabel *c3;
    sqlite3 *exerciseDB;
    NSString *databasePath;
    IBOutlet UISlider *slider;
    
    IBOutlet UIScrollView *scroll,*scroll1;
    UIAlertView *alert;
    
    IBOutlet UIView *listofdates;
    UITableView *tableView;
    NSMutableArray *listexercise3;
    NSMutableArray *list_exercise3;

    
    sqlite3_stmt    *statement;
    NSString *SelectedDate;
    UITableViewCell *cell;
    
    IBOutlet UIView *Label1Popup;
    IBOutlet UIButton *raderaButton;
}

@property(nonatomic, retain)IBOutlet UILabel *label1;
@property(nonatomic, retain)IBOutlet UILabel *strategier;
@property(nonatomic, retain)IBOutlet UILabel *negative;
@property(nonatomic, retain)IBOutlet UILabel *din;
@property(nonatomic, retain)IBOutlet UILabel *motavis;
@property(nonatomic, retain)IBOutlet UILabel *tanke;
@property(nonatomic, retain)IBOutlet UILabel *alltanke;

@property(nonatomic, retain)IBOutlet    UILabel *c3;
@property(nonatomic, retain)IBOutlet  UITextView *c1;
@property(nonatomic, retain)IBOutlet  UITextView *c2;
@property(nonatomic, retain)IBOutlet  UITextView *c4;
@property(nonatomic, retain)IBOutlet  UITextView *c5;
@property(nonatomic, retain)IBOutlet  UITextView *c6;

-(IBAction)changeSlider:(id)sender ;
-(IBAction)sparabutton:(id)sender;
-(IBAction)newbutton:(id)sender;
-(IBAction)nextbutton:(id)sender;
-(IBAction)labelalert:(id)sender;

-(IBAction)Closelistofdates:(id)sender;

-(IBAction)SelectChekBoxs:(id)sender;
-(IBAction)aMethod:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *listexercise3;
@property(nonatomic, retain)NSMutableArray *list_exercise3;
@end

