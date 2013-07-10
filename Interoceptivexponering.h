//
//  Interoceptivexponering.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/6/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface Interoceptivexponering : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    //Gopal DataBase
    sqlite3 *exerciseDB;
    NSString        *databasePath;
    sqlite3_stmt    *statement;

    //Gopal Timer
    UILabel *timerQuestionLabel;
    UITableView *tblView;
    
    //Labels
    UILabel *ovning;
    UITextView *egen;
    UISlider *slider;
    UILabel *prc;
    
    //Views
    IBOutlet UIView *pupview;
    IBOutlet UIView *timerview;
    
    IBOutlet UIScrollView *scroll,*scroll1;
    IBOutlet UIButton *startTime;
    //PopupView Labels
    IBOutlet UILabel *cb1,*cb2,*cb3,*cb4,*cb5,*cb6,*cb7,*cb8,*cb9,*cb10;
    
    //DataStore
    NSMutableDictionary *items;
    NSDictionary *selectedDic;

    //
    NSString *inStr;
    
    
    
}

//Gopal
@property (nonatomic, retain) IBOutlet UILabel *timerQuestionLabel;
@property (nonatomic, retain) IBOutlet UILabel *prc;
@property (nonatomic, retain) IBOutlet UILabel *ovning;
@property (nonatomic, retain) IBOutlet UITextView *egen;
@property (nonatomic, retain) IBOutlet UISlider *slider;
@property (nonatomic, retain) IBOutlet UITableView *tblView;

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;


//DataSotre
@property (nonatomic, retain) NSMutableArray *allItems;




//timer
@property (nonatomic, retain) IBOutlet UILabel *secondsDisplay;
@property (nonatomic, retain) IBOutlet UILabel *minutesDisplay;
@property (nonatomic, retain) NSTimer *secondsTimer;


//**********************************************************************
-(void)getDetailsFromInteroceptivexponeringDB;
-(void)insertIntoDatabase:(NSDictionary*)recordDic;
-(void)updateIntDatabase:(NSDictionary*)recordsDic;
-(void)deleteRecordsFromDB:(NSDictionary *)tempDict;

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


@end
