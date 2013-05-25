//
//  EditLivskompass.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/17/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface EditLivskompass : UIViewController{
    NSString *dateoflivskompass;
    sqlite3 *exerciseDB;
    NSString *databasePath;
    IBOutlet UIButton *averageBt;
    IBOutlet UILabel *label;
}
@property (nonatomic , retain)NSString *dateoflivskompass;
@property (nonatomic,retain)IBOutlet UITextView *textview;
-(IBAction)updatedata:(id)sender;
-(IBAction)deletedata:(id)sender;
@end
