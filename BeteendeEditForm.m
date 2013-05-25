//
//  BeteendeEditForm.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "BeteendeEditForm.h"
#import "PMCalendar.h"
@interface BeteendeEditForm ()
@property (nonatomic, strong) PMCalendarController *pmCC;
@end

@implementation BeteendeEditForm
@synthesize selected_date,Eex4c1,Eex4c2,Eex4c3,Eex4c4,Eex4c5,pmCC,slabel2,slabel1;
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
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [Eex4c1 resignFirstResponder];
    
    return YES;
}
- (void)viewDidLoad
{
    self.navigationItem.title=@"";
    NSLog(@"%@",selected_date);
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Dela"
                                                                    style:UIBarButtonItemStylePlain target:nil action:@selector(sharebutton:)];
    self.navigationItem.rightBarButtonItem = rightButton;
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
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE4 WHERE date='%@'", selected_date];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char* c1 = (char*) sqlite3_column_text(statement,2);
          
            if (c1 != NULL){
                Eex4c1.text = [NSString stringWithUTF8String:c1];
                NSLog(@"value form db :%@",Eex4c1.text );
               
            }
            char* c2 = (char*) sqlite3_column_text(statement,3);
            
            if (c2 != NULL){
                Eex4c2.text  = [NSString stringWithUTF8String:c2];
                NSLog(@"value form db :%@",Eex4c2.text );
              
            }
            
            char* c3 = (char*) sqlite3_column_text(statement,4);
          
            if (c3!= NULL){
                Eex4c3.text = [NSString stringWithUTF8String:c3];
                NSLog(@"value form db :%@",Eex4c3.text );
                          }
            char* c4 = (char*) sqlite3_column_text(statement,5);
            
            if (c4!= NULL){
                slabel1.text = [NSString stringWithUTF8String:c4];
                NSLog(@"value form db :%@",slabel1.text );
                slabel1.text=@"30%";
            }
            char* c5 = (char*) sqlite3_column_text(statement,6);
          
            if (c5 != NULL){
                Eex4c4.text = [NSString stringWithUTF8String:c5];
                NSLog(@"value form db :%@",Eex4c4.text );
               
            }
            char* c6 = (char*) sqlite3_column_text(statement,7);
            
            if (c6 != NULL){
                Eex4c5.text = [NSString stringWithUTF8String:c6];
                NSLog(@"value form db :%@",Eex4c5.text );
                
            }
            char* c7 = (char*) sqlite3_column_text(statement,8);
            
            if (c7 != NULL){
                NSString *str = [NSString stringWithUTF8String:c7];
                NSLog(@"value form db :%@",str);
                slabel2.text=@"36%";
                
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)updateButton:(id)sender{
   // date,datum,experimentet,forutsage,resultat,lardomar
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISE4 SET  datum='%@',experimentet='%@', forutsage='%@',forutprc='%@', resultat='%@',lardomar='%@' ,lardprc='%@' WHERE date='%@'",Eex4c1.text,Eex4c2.text, Eex4c3.text,slabel1.text, Eex4c4.text, Eex4c5.text,slabel2.text, selected_date];
        const char *del_stmt = [query UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK);{
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
            NSLog(@"sss");
        }
        
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }

}

-(IBAction)radera:(id)sender{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Erasing the form or not?"
                                                 delegate:self
                                        cancelButtonTitle:@"Cancel"
                                        otherButtonTitles:@"Delete", nil];
    
    [alert show];
    [alert release];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        sqlite3_stmt    *statement;
        if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
            
            NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE4  WHERE date='%@'", selected_date];
            
            const char *del_stmt = [sql UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSLog(@"sss");
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
            
            Eex4c1.text=@"";
            Eex4c2.text=@"";
            Eex4c3.text=@"";
            Eex4c4.text=@"";
            Eex4c5.text=@"";
            
        }
      
        
    }else{
        
    }
}
-(IBAction)showCalendar:(id)sender{
    self.pmCC = [[PMCalendarController alloc] init];
    pmCC.delegate = self;
    pmCC.mondayFirstDayOfWeek = YES;
    
    [pmCC presentCalendarFromView:sender
         permittedArrowDirections:PMCalendarArrowDirectionAny
                         animated:YES];
    /*    [pmCC presentCalendarFromRect:[sender frame]
     inView:[sender superview]
     permittedArrowDirections:PMCalendarArrowDirectionAny
     animated:YES];*/
    [self calendarController:pmCC didChangePeriod:pmCC.period];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark PMCalendarControllerDelegate methods

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    Eex4c1.text = [NSString stringWithFormat:@"%@"
                  , [newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]
                  ];
}
-(IBAction)changeSlider:(id)sender {
    
    NSString *sl1= [[NSString alloc] initWithFormat:@"%d%@", (int)slider.value,@"%"];
    NSLog(@"sl1%@",sl1);
    slabel1.text=sl1;
    
}
-(IBAction)changeSlider1:(id)sender {
    
    NSString *sl2= [[NSString alloc] initWithFormat:@"%d%@", (int)slider.value,@"%"];
    NSLog(@"str%@",sl2);
    slabel2.text=sl2;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
