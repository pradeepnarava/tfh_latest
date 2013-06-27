//
//  Interoceptivexponering.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/6/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface Interoceptivexponering : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSString *inStr,*instr1;
    NSMutableString *str1,*str2,*str3, *str11,*str21,*str31;
    UIScrollView *scrollview;
    UILabel *titlelabel,*titlelabel1;
    UITableView *tblView,*tabeldates;
    UILabel *ovning;
    UITextView *egen;
    UISlider *slider;
    int noOfSection;
    UIButton *cellButton ;
    UILabel *prc,*text1,*text2;
    IBOutlet UIScrollView *scroll,*scroll1;
    IBOutlet UIView *pupview;
    IBOutlet UIView *timerview,*datesView;
    IBOutlet UIButton *cb1,*cb2,*cb3,*cb4,*cb5,*cb6,*cb7,*cb8,*cb9,*cb10;
    sqlite3 *exerciseDB;
    NSString        *databasePath;
    sqlite3_stmt    *statement;
    NSMutableArray *listofovningars,*listof_sliderValue,*listexercise5,*list_exercise5,*list_egen,*listofovningars1,*listof_sliderValue1,*list_egen1;
    NSString *SelectedDate;
    IBOutlet UIButton *raderaButton;
}
//-(IBAction)switchStateChanged:(id)sender;
@property (nonatomic, retain)IBOutlet UILabel *prc;
@property (nonatomic, retain)IBOutlet UILabel *text1;
@property (nonatomic, retain)IBOutlet UILabel *text2;
@property(nonatomic ,retain)NSMutableArray *listexercise5;
@property(nonatomic ,retain)NSMutableArray *list_exercise5;
@property(nonatomic ,retain)NSMutableArray *listofovningars1;
@property(nonatomic ,retain)NSMutableArray *listof_sliderValue1;
@property(nonatomic ,retain)NSMutableArray *list_egen1;

@property (nonatomic, retain)IBOutlet UILabel *ovning;
@property (nonatomic, retain)IBOutlet  UITextView *egen;
@property (nonatomic, retain)IBOutlet  UISlider *slider;
@property(nonatomic,retain)IBOutlet UITableView *tblView;
@property(nonatomic,retain)IBOutlet UITableView *tabeldates;

//timer
@property (nonatomic, strong) IBOutlet UILabel *secondsDisplay;
@property (nonatomic, strong) IBOutlet UILabel *minutesDisplay;
@property (nonatomic, strong) NSTimer *secondsTimer;

-(IBAction)newcolm:(id)sender;
- (IBAction)closeBtn:(id)sender;
- (IBAction)closetimer:(id)sender;
- (IBAction)starttimer:(id)sender;
- (IBAction)Restarttimer:(id)sender;
- (IBAction)stoptimer:(id)sender;
-(IBAction)selectedcheckbox:(id)sender;

- (IBAction)SparaButton:(id)sender;
-(IBAction)titlelabelalert:(id)sender;
-(IBAction)CloseButton:(id)sender;
-(IBAction)nextbutton:(id)sender;
-(IBAction)raderaclick:(id)sender;
@end
