//
//  Registreratankar.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "EditExerciseViewController.h"
@interface Registreratankar : UIViewController{
    UILabel *label,*nat,*tanke,*tabellen,*flykt;
    sqlite3 *exerciseDB;
     NSString        *databasePath;
    UITextView *situation;
    UITextView *negative;
    UITextView *overiga;
    UITextView *beteenden;
    UIAlertView *alert;
    EditExerciseViewController *eevc;
    IBOutlet UIView *tabellenView;
    IBOutlet UIScrollView *tabellenscroll;
    IBOutlet UIScrollView *scroll;
    IBOutlet UIScrollView *scroll1;
}

@property(nonatomic,retain)IBOutlet UITextView *situation;
@property(nonatomic,retain)IBOutlet UITextView *negative;
@property(nonatomic,retain)IBOutlet UITextView *overiga;
@property(nonatomic,retain)IBOutlet UITextView *beteenden;

@property(nonatomic,retain)IBOutlet UIAlertView *alert;

@property(nonatomic, retain)IBOutlet UILabel *label;
@property(nonatomic, retain)IBOutlet UILabel *nat;
@property(nonatomic, retain)IBOutlet UILabel *tanke;
@property(nonatomic, retain)IBOutlet UILabel *tabellen;
@property(nonatomic, retain)IBOutlet UILabel *flykt;
-(IBAction)Sparabutton:(id)sender;
-(IBAction)nyttbutton:(id)sender;
-(IBAction)retrivebutton:(id)sender;
-(IBAction)Editbutton:(id)sender;
-(IBAction)closebutton:(id)sender;
-(IBAction)tabellencheck:(id)sender;
-(IBAction)mainlabelalert:(id)sender;

@end
