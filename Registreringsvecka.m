//
//  Registreringsvecka.m
//  Välkommen till TFH-appen
//
//  Created by Gopal on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Registreringsvecka.h"
#import "MTPopupWindow.h"
#import "CalendarViewController.h"
#import "RegistreringDinaveckarViewController.h"

#import "DataBaseHelper.h"

@interface Registreringsvecka ()

@end

@implementation Registreringsvecka
@synthesize calendarView,regDinaveckarView,weekArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationItem.title=@"Registreringsvecka";
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    }
    else {
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setBackgroundImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    }
   /* NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SUB1DINAVECKOR (id INTEGER PRIMARY KEY AUTOINCREMENT,startDate TEXT,endDate TEXT,currentDate TEXT)";
        if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create database");
        }
        sqlite3_close(exerciseDB);
        
    } else {
        NSLog(@"Failed to open/create database");
    }
*/
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated{
    [self week:[NSDate date]];
    [super viewWillAppear:YES];
}

#pragma mark BackButton

-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark Button Actions

-(IBAction)sub1button:(id)sender {
    
    NSString *startDate = [self dateFromString:[self.weekArray objectAtIndex:0]];
    NSString *endDate = [self dateFromString:[self.weekArray objectAtIndex:6]];
    NSString *currentDate = [self dateFromString:[NSDate date]];
    BOOL success;
    
    success = [[DataBaseHelper sharedDatasource] saveDBstart:startDate end:endDate curDate:currentDate checked:@"NO"];
    if (success) {

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if ([[UIScreen mainScreen] bounds].size.height > 480) {
                if (!calendarView) {
                    calendarView = [[CalendarViewController alloc]initWithNibName:@"CalendarView" bundle:nil];
                }
            }else{
                if (!calendarView) {
                    calendarView = [[CalendarViewController alloc]initWithNibName:@"CalendarView_iPhone4" bundle:nil];
                }
            }
        }
        else{
            if (!calendarView) {
                calendarView = [[CalendarViewController alloc]initWithNibName:@"CalendarView_iPad" bundle:nil];
            }
        }
        calendarView.isEventNotify = NO;
        calendarView.isTotalNotify = NO;
       
        calendarView.newRowId = [[DataBaseHelper sharedDatasource] newRowId];
        [self.navigationController pushViewController:calendarView animated:YES];
    }
    else {
        NSLog(@"Failed to open table");
    }
}




-(NSString*)dateFromString:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


-(IBAction)ILabel:(id)sender {
     [MTPopupWindow showWindowWithHTMLFile:@"Registreringsvecka.html" insideView:self.view];
}


-(IBAction)dinavaor:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!regDinaveckarView) {
                regDinaveckarView = [[RegistreringDinaveckarViewController alloc]initWithNibName:@"RegistreringDinaveckaView" bundle:nil];
            }
        }else{
            if (!regDinaveckarView) {
                regDinaveckarView = [[RegistreringDinaveckarViewController alloc]initWithNibName:@"RegistreringDinaveckaView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!regDinaveckarView) {
            regDinaveckarView = [[RegistreringDinaveckarViewController alloc]initWithNibName:@"RegistreringDinaveckaView_iPad" bundle:nil];
        }
    }

    [self.navigationController pushViewController:regDinaveckarView animated:YES];
    
}


#pragma mark getting week Days

- (void)week:(NSDate *)_date {
    self.weekArray = [[NSMutableArray alloc] init];
    
    for (int i =1; i <= 7; i++)
    {
        NSDateComponents *comps1 = [[NSDateComponents alloc] init];
        [comps1 setMonth:0];
        [comps1 setDay:+i];
        [comps1 setHour:0];
        NSCalendar *calendar1 = [NSCalendar currentCalendar];
        NSDate *newDate1 = [calendar1 dateByAddingComponents:comps1 toDate:[NSDate date] options:0];
        [self.weekArray addObject:newDate1];
    }
}


#pragma mark Sub2 Functionality

-(void)databaseInsertTotal:(NSDictionary *)dict{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO SUB2D2NAVECKOR (startDate,endDate,currentDate) VALUES (\"%@\", \"%@\",\"%@\")",[dict valueForKey:@"startDate"],[dict valueForKey:@"endDate"],[dict valueForKey:@"currentDate"]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"New Record Created");
        }
        else {
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
            NSLog(@"error for insertig data into database NO");
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
