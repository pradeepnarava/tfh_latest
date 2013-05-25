//
//  Utmanatankar.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/1/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "UtmanaDateView.h"
@interface Utmanatankar : UIViewController{
    UILabel *label,*label2,*strategier,*negative,*din,*motavis,*tanke,*alltanke;
    UITextView *c1,*c2,*c4,*c5,*c6;
    UILabel *c3;
    sqlite3 *exerciseDB;
    NSString *databasePath;
     IBOutlet UISlider *slider;
    UtmanaDateView *udv;
     IBOutlet UIScrollView *scroll;
}
@property(nonatomic, retain)IBOutlet UILabel *label;
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
@end
