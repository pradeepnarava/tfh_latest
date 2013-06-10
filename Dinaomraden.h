//
//  Dinaomraden.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/11/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ListOfKompass.h"

@interface Dinaomraden : UIViewController <ListOfKompassDelegate, UIAlertViewDelegate>
{
        IBOutlet UIView *subView;
     IBOutlet UIView *settingsView;
    IBOutlet UITextField *text1,*text2,*text3,*text4,*text5,*text6,*text7,*text8,*text9,*text10;
     IBOutlet UILabel*label1,*label2,*label3,*label4,*label5,*label6,*label7,*label8,*label9,*label10;
    IBOutlet UITextField *tf1,*tf2,*tf3,*tf4,*tf5,*tf6,*tf7,*tf8,*tf9,*tf10;
    IBOutlet UIButton *averageBt;
    IBOutlet UILabel *label;
    NSString *scb;
    IBOutlet UIButton *cb1,*cb2,*cb3,*cb4,*cb5,*cb6,*cb7,*cb8,*cb9,*cb10;
    sqlite3 *exerciseDB;
    NSString        *databasePath;
//    ListOfKompass *lok;
    IBOutlet UIScrollView *scrollView;
    
    NSString *dateOfCurrentItem;
    ListOfKompass *lok;
}

@property (nonatomic,retain)IBOutlet UITextView *textview;
-(IBAction)averagevalue;
-(IBAction)selectedcheckbox:(id)sender;
-(IBAction)CloseBtn:(id)sender;
-(IBAction)SaveBtn:(id)sender;
-(IBAction)NewBtn:(id)sender;
-(IBAction)listofvalues:(id)sender;
-(IBAction)Increase:(id)sender;
-(IBAction)Decrease:(id)sender;
- (IBAction)deleteEntry:(id)sender;
- (IBAction)generateGraph:(id)sender;
@end
