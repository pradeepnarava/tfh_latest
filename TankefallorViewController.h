//
//  TankefallorViewController.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ExerciseTwoDateList.h"
@interface TankefallorViewController : UIViewController{
    
    sqlite3 *exerciseDB;
    NSString *databasePath;
    ExerciseTwoDateList *etdl;
    UILabel *label;
    UITextView *StagC1;
    UITextView *StagC2;
    UITextView *overC1;
    UITextView *overC2;
    UITextView *TankeC1;
    UITextView *TankeC2;
    UITextView *PerC1;
    UITextView *PerC2;
    UITextView *DiskC1;
    UITextView *DiskC2;
    UITextView *ForC1;
    UITextView *ForC2;
    UITextView *KataC1;
    UITextView *KataC2;
    UITextView *AllC1;
    UITextView *AllC2;
    UITextView *PliktC1;
    UITextView *PliktC2;
    UITextView *SelektC1;
    UITextView *SelektC2;
    UITextView *KanslC1;
    UITextView *KanslC2;
    UITextView *EtikeC1;
    UITextView *EtikeC2;
      IBOutlet UIScrollView *scroll;
}
@property(nonatomic, retain)IBOutlet UILabel *label;
-(IBAction)Sparabutton:(id)sender;
-(IBAction)Nyttbutton:(id)sender;
-(IBAction)nextbutton:(id)sender;
-(IBAction)mainlabelalert:(id)sender;

@property(nonatomic, retain)IBOutlet UITextView *StagC1;
@property(nonatomic, retain)IBOutlet UITextView *StagC2;
@property(nonatomic, retain)IBOutlet UITextView *overC1;
@property(nonatomic, retain)IBOutlet  UITextView *overC2;
@property(nonatomic, retain)IBOutlet  UITextView *TankeC1;
@property(nonatomic, retain)IBOutlet UITextView *TankeC2;
@property(nonatomic, retain)IBOutlet UITextView *PerC1;
@property(nonatomic, retain)IBOutlet UITextView *PerC2;
@property(nonatomic, retain)IBOutlet  UITextView *DiskC1;
@property(nonatomic, retain)IBOutlet UITextView *DiskC2;
@property(nonatomic, retain)IBOutlet  UITextView *ForC1;
@property(nonatomic, retain)IBOutlet UITextView *ForC2;
@property(nonatomic, retain)IBOutlet  UITextView *KataC1;
@property(nonatomic, retain)IBOutlet UITextView *KataC2;
@property(nonatomic, retain)IBOutlet  UITextView *AllC1;
@property(nonatomic, retain)IBOutlet UITextView *AllC2;
@property(nonatomic, retain)IBOutlet  UITextView *PliktC1;
@property(nonatomic, retain)IBOutlet  UITextView *PliktC2;
@property(nonatomic, retain)IBOutlet UITextView *SelektC1;
@property(nonatomic, retain)IBOutlet UITextView *SelektC2;
@property(nonatomic, retain)IBOutlet UITextView *KanslC1;
@property(nonatomic, retain)IBOutlet UITextView *KanslC2;
@property(nonatomic, retain)IBOutlet UITextView *EtikeC1;
@property(nonatomic, retain)IBOutlet UITextView *EtikeC2;
@end
