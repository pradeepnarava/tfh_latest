//
//  Va_lkommenViewController.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OveningarViewController.h"
#import <sqlite3.h> 


@interface Va_lkommenViewController : UIViewController{

    sqlite3 *exerciseDB;
    NSString        *databasePath;
}
@property (nonatomic, strong) OveningarViewController *ovc;

-(IBAction)introduktion:(id)sender;
-(IBAction)om:(id)sender;
-(IBAction)lashorna:(id)sender;
-(IBAction)oveningarbutton:(id)sender;

@end
