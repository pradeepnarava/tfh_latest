//
//  EventPopOverViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 14/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "EventPopOverViewController.h"

@interface EventPopOverViewController ()

@property (nonatomic, strong) NSString *currentStatuBtn;

@end

@implementation EventPopOverViewController
@synthesize currentStatuBtn;
@synthesize hoursTextField1,hoursTextField2,mintsTextField1,mintsTextField2;
@synthesize eventDesTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    else {
        return YES;
    }
    return 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *docsDir;
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
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE6 (ID INTEGER PRIMARY KEY AUTOINCREMENT,DATE TEXT,STARTDATE TEXT,ENDDATE TEXT,STATUS TEXT,DAYDATE TEXT,EVENTDES TEXT)";

        if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create database");
        }
        
        sqlite3_close(exerciseDB);
        
    } else {
        NSLog(@"Failed to open/create database");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITextField Delegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
    
}


-(void)insertDataIntoDatabase {

    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    NSString* str = [formatter stringFromDate:[NSDate date]];
    
    
    NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
    NSString *endDate =[NSString stringWithFormat:@"%@:%@",hoursTextField2.text,mintsTextField2.text];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE6 (date,startdate,enddate,status,daydate,eventdes) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\",\"%@\")",str,startDate,endDate,currentStatuBtn,str,eventDesTextView.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
    
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"YES");
        } else {
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
            NSLog(@"NO");
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(exerciseDB);
}

#pragma mark Klar Button Clicked

-(IBAction)saveButtonClicked:(id)sender {
    
    [self insertDataIntoDatabase];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InsertData" object:nil];

    
}


-(IBAction)statusButtonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%i",btn.tag);
    
    switch (btn.tag) {
        case 1:
            currentStatuBtn = btn.currentTitle;
            break;
        case 2:
            currentStatuBtn = btn.currentTitle;
            break;
        case 3:
            currentStatuBtn = btn.currentTitle;
            break;
        default:
            break;
    }
}




@end
