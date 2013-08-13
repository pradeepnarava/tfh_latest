//
//  Registreringsvecka.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@class CalendarViewController;
@class RegistreringDinaveckarViewController;

@interface Registreringsvecka : UIViewController
{
    sqlite3 *exerciseDB;
    NSString *databasePath;
    sqlite3_stmt  *statement;
}
@property (nonatomic, strong) NSMutableArray *weekArray;
@property (nonatomic, strong) CalendarViewController *calendarView;
@property (nonatomic, strong) RegistreringDinaveckarViewController *regDinaveckarView;

-(IBAction)sub1button:(id)sender;
-(IBAction)ILabel:(id)sender;
-(IBAction)dinavaor:(id)sender;


@end
