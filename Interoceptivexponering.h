//
//  Interoceptivexponering.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/6/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface Interoceptivexponering : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    //Gopal
    sqlite3 *exerciseDB;
    NSString        *databasePath;
    sqlite3_stmt    *statement;

    //Gopal
    UILabel *timerQuestionLabel;
    
    UITableView *tblView;
    
    UILabel *ovning;
    UITextView *egen;
    UISlider *slider;
    UILabel *prc;
    
    IBOutlet UIView *pupview;
    IBOutlet UIView *timerview;
    
    //
    NSString *inStr,*instr1;
    NSMutableString *str1,*str2,*str3, *str11,*str21,*str31;


    
    int noOfSection;
    UIButton *cellButton;

    IBOutlet UIScrollView *scroll,*scroll1;

    IBOutlet UIButton *cb1,*cb2,*cb3,*cb4,*cb5,*cb6,*cb7,*cb8,*cb9,*cb10;

    NSMutableArray *listofovningars,*listof_sliderValue,*listexercise5,*list_exercise5,*list_egen,*listofovningars1,*listof_sliderValue1,*list_egen1;
    NSString *SelectedDate;

}

//Gopal
@property (nonatomic, retain) IBOutlet UILabel *timerQuestionLabel;
@property (nonatomic, retain) IBOutlet UILabel *prc;
@property (nonatomic, retain) IBOutlet UILabel *ovning;
@property (nonatomic, retain) IBOutlet UITextView *egen;
@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UITableView *tblView;


//timer
@property (nonatomic, retain) IBOutlet UILabel *secondsDisplay;
@property (nonatomic, retain) IBOutlet UILabel *minutesDisplay;
@property (nonatomic, retain) NSTimer *secondsTimer;



@property(nonatomic ,retain)NSMutableArray *listexercise5;
@property(nonatomic ,retain)NSMutableArray *list_exercise5;
@property(nonatomic ,retain)NSMutableArray *listofovningars1;
@property(nonatomic ,retain)NSMutableArray *listof_sliderValue1;
@property(nonatomic ,retain)NSMutableArray *list_egen1;


- (IBAction)newcolm:(id)sender;
- (IBAction)closeBtn:(id)sender;
- (IBAction)closetimer:(id)sender;
- (IBAction)starttimer:(id)sender;
- (IBAction)Restarttimer:(id)sender;
- (IBAction)stoptimer:(id)sender;
- (IBAction)selectedcheckbox:(id)sender;

- (IBAction)SparaButton:(id)sender;
- (IBAction)titlelabelalert:(id)sender;
- (IBAction)CloseButton:(id)sender;
- (IBAction)nextbutton:(id)sender;

@end
