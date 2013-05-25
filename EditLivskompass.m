//
//  EditLivskompass.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/17/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "EditLivskompass.h"

@interface EditLivskompass ()

@end

@implementation EditLivskompass
@synthesize dateoflivskompass,textview;
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
    self.navigationItem.title=@"Edit Form";
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    // const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE7 WHERE date='%@'", dateoflivskompass];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char* c1 = (char*) sqlite3_column_text(statement,2);
            NSString *tmp1;
            if (c1 != NULL){
                tmp1 = [NSString stringWithUTF8String:c1];
                NSLog(@"value form db :%@",tmp1);
                label.text=tmp1;
            }
            char* c2 = (char*) sqlite3_column_text(statement,3);
            NSString *tmp2;
            if (c2 != NULL){
                tmp2 = [NSString stringWithUTF8String:c2];
                NSLog(@"value form db :%@",tmp2);
                textview.text=tmp2;
            }
            
            char* c3 = (char*) sqlite3_column_text(statement,4);
            NSString *tmp3;
            if (c3!= NULL){
                tmp3= [NSString stringWithUTF8String:c3];
                NSLog(@"value form db :%@",tmp3);
                 [averageBt setTitle:tmp3 forState:UIControlStateNormal];
            }
            
          
            
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)updatedata:(id)sender{
    //omrade,aktivitet,average
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISE7 SET omrade='%@', aktivitet='%@' , average='%@', WHERE date='%@' ",label.text,textview.text,averageBt.currentTitle, dateoflivskompass];
        const char *del_stmt = [query UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK){
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
            NSLog(@"sss");
        }
        
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }

}
-(IBAction)deletedata:(id)sender{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Erasing the form or not?"
                                                 delegate:self
                                        cancelButtonTitle:@"Cancel"
                                        otherButtonTitles:@"Delete", nil];
    
    [alert show];
    [alert release];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([title isEqualToString:@"Delete"]) {
        NSLog(@"Delete.");
        sqlite3_stmt    *statement;
        if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
            
            NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE7 WHERE date='%@'", dateoflivskompass];
            
            const char *del_stmt = [sql UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSLog(@"sss");
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
            
            
        }
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
