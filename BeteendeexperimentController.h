//
//  BeteendeexperimentController.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/2/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "BeteendeDateList.h"
#import "PMCalendar.h"
@interface BeteendeexperimentController : UIViewController<PMCalendarControllerDelegate>{
    UILabel *label,*label1;
     IBOutlet UISlider *slider,*slider1;
    UITextView *ex3c2,*ex3c3,*ex3c4,*ex3c5;
    UITextField *ex3c1;
    UILabel *slabel1,*slabel2;
    sqlite3 *exerciseDB;
       NSString        *databasePath;
    BeteendeDateList *bdl;
      IBOutlet UIScrollView *scroll;
    
     IBOutlet UIView *listofdates;
}
@property(nonatomic, retain)IBOutlet UILabel *label;
@property(nonatomic, retain)IBOutlet UILabel *label1;
@property(nonatomic, retain)IBOutlet UILabel *slabel1;
@property(nonatomic, retain)IBOutlet UILabel *slabel2;

@property(nonatomic, retain)IBOutlet UITextField *ex3c1;
@property(nonatomic, retain)IBOutlet UITextView *ex3c2;
@property(nonatomic, retain)IBOutlet  UITextView *ex3c3;
@property(nonatomic, retain)IBOutlet  UITextView *ex3c4;
@property(nonatomic, retain)IBOutlet  UITextView *ex3c5;

-(IBAction)changeSlider:(id)sender ;
-(IBAction)changeSlider1:(id)sender ;

-(IBAction)saveButton:(id)sender;
-(IBAction)newButton:(id)sender;
-(IBAction)nextButton:(id)sender;
-(IBAction)mainlabelalert:(id)sender;
   - (IBAction)showCalendar:(id)sender;
- (IBAction)RaderaButton:(id)sender;


-(IBAction)CloseButton:(id)sender;
@end
