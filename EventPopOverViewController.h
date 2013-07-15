//
//  EventPopOverViewController.h
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 14/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface EventPopOverViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate>
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt    *statement;
}


@property (nonatomic, strong) IBOutlet UITextField *hoursTextField1,*mintsTextField1;
@property (nonatomic, strong) IBOutlet UITextField *hoursTextField2,*mintsTextField2;
@property (nonatomic, strong) IBOutlet UITextView *eventDesTextView;


-(IBAction)saveButtonClicked:(id)sender;
-(IBAction)statusButtonClicked:(id)sender;




@end
