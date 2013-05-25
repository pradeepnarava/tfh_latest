//
//  BeteendeEditForm.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "PMCalendar.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface BeteendeEditForm : UIViewController<PMCalendarControllerDelegate>{
    NSString *selected_date;
    sqlite3 *exerciseDB;
    NSString *databasePath;
    UITextField *Eex4c1;
    UITextView *Eex4c2,*Eex4c3,*Eex4c4,*Eex4c5;
     IBOutlet UISlider *slider;
     UILabel *slabel1,*slabel2;
}
@property(nonatomic, retain)IBOutlet UILabel *slabel1;
@property(nonatomic, retain)IBOutlet UILabel *slabel2;
@property(nonatomic,retain)NSString *selected_date;
@property(nonatomic, retain)IBOutlet UITextView *Eex4c2;
@property(nonatomic, retain)IBOutlet UITextView *Eex4c3;
@property(nonatomic, retain)IBOutlet UITextView *Eex4c4;
@property(nonatomic, retain)IBOutlet UITextView *Eex4c5;
@property(nonatomic, retain)IBOutlet UITextField *Eex4c1;
-(IBAction)updateButton:(id)sender;
-(IBAction)radera:(id)sender;
  - (IBAction)showCalendar:(id)sender;
-(IBAction)changeSlider:(id)sender ;
-(IBAction)changeSlider1:(id)sender ;

@end
