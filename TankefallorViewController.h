//
//  TankefallorViewController.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface TankefallorViewController : UIViewController<UITextViewDelegate>{
    
    sqlite3 *tankefallorDB;
    NSString *databasePath;
    
    UILabel *label;
    //1.
    UITextView *alltTV1;
    UITextView *alltTV2;
    //2.
    UITextView *kataTV1;
    UITextView *kataTV2;
    //3.
    UITextView *diskTV1;
    UITextView *diskTV2;
    //4.
    UITextView *attTV1;
    UITextView *attTV2;
    //5.
    UITextView *etikTV1;
    UITextView *etikTV2;
    //6.
    UITextView *forTV1;
    UITextView *forTV2;
    //7.
    UITextView *mentTV1;
    UITextView *mentTV2;
    //8.
    UITextView *tankTV1;
    UITextView *tankTV2;
    //9.
    UITextView *overTV1;
    UITextView *overTV2;
    //10.
    UITextView *persTV1;
    UITextView *persTV2;
    //11.
    UITextView *mansTV1;
    UITextView *mansTV2;

    IBOutlet UIScrollView *scroll,*scroll1;
    

}




-(void)getDetailsFromtankefallorDB;
-(IBAction)Sparabutton:(id)sender;
-(IBAction)Nyttbutton:(id)sender;
-(IBAction)mainlabelalert:(id)sender;

//1.
@property(nonatomic, retain)IBOutlet UITextView *alltTV1;
@property(nonatomic, retain)IBOutlet UITextView *alltTV2;
//2.
@property(nonatomic, retain)IBOutlet UITextView *kataTV1;
@property(nonatomic, retain)IBOutlet UITextView *kataTV2;
//3.
@property(nonatomic, retain)IBOutlet UITextView *diskTV1;
@property(nonatomic, retain)IBOutlet UITextView *diskTV2;
//4.
@property(nonatomic, retain)IBOutlet UITextView *attTV1;
@property(nonatomic, retain)IBOutlet UITextView *attTV2;
//5.
@property(nonatomic, retain)IBOutlet UITextView *etikTV1;
@property(nonatomic, retain)IBOutlet UITextView *etikTV2;
//6.
@property(nonatomic, retain)IBOutlet UITextView *forTV1;
@property(nonatomic, retain)IBOutlet UITextView *forTV2;
//7.
@property(nonatomic, retain)IBOutlet UITextView *mentTV1;
@property(nonatomic, retain)IBOutlet UITextView *mentTV2;
//8.
@property(nonatomic, retain)IBOutlet UITextView *tankTV1;
@property(nonatomic, retain)IBOutlet UITextView *tankTV2;
//9.
@property(nonatomic, retain)IBOutlet UITextView *overTV1;
@property(nonatomic, retain)IBOutlet UITextView *overTV2;
//10.
@property(nonatomic, retain)IBOutlet UITextView *persTV1;
@property(nonatomic, retain)IBOutlet UITextView *persTV2;
//11.
@property(nonatomic, retain)IBOutlet UITextView *mansTV1;
@property(nonatomic, retain)IBOutlet UITextView *mansTV2;


@end
