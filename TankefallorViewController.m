//
//  TankefallorViewController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "TankefallorViewController.h"
#import "MTPopupWindow.h"
int x=0;
#define kAlertViewOne 1
#define kAlertViewTwo 2
@interface TankefallorViewController ()

@end

@implementation TankefallorViewController
@synthesize StagC2,StagC1,SelektC2,SelektC1,overC1,overC2,TankeC2,TankeC1,PerC1,PerC2,PliktC1,PliktC2,DiskC1,DiskC2,ForC1,ForC2,KanslC1,KanslC2,KataC1,KataC2,AllC1,AllC2,EtikeC1,EtikeC2,tableView,listexercise2,list_exercise2;

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
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         // whatever you need to do when animations are complete
                         
                     }];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.frame = CGRectMake(self.view.frame.origin.x, -100, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         // whatever you need to do when animations are complete
                         
                     }];
    
    return YES;
}

- (void)viewDidLoad
{
    
    self.navigationItem.title=@"Tankefällor";
    [self.view addSubview:listofdates];
    list_exercise2=[[NSMutableArray alloc]init];
    [list_exercise2 addObject:@"Null"];
    listofdates.hidden=YES;
    scroll.scrollEnabled = YES;
    raderaButton.hidden=YES;
    [scroll setContentSize:CGSizeMake(320, 4435)];
    scroll1.scrollEnabled = YES;
    
    [scroll1 setContentSize:CGSizeMake(320, 4418)];
    //    label.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tapGesture =
    //    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainlabelalert:)] autorelease];
    //    [label addGestureRecognizer:tapGesture];
    
    // Do any additional setup after loading the view from its nib.
    
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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISETWO (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  STAGC1 TEXT ,STAGC2 TEXT,OVERC1 TEXT,OVERC2 TEXT,TANKEC1 TEXT,TANKEC2 TEXT,PERC1 TEXT,PERC2 TEXT,DISKC1 TEXT,DISKC2 TEXT, FORC1 TEXT,FORC2 TEXT,KATAC1 TEXT, KATAC2 TEXT,ALLC1 TEXT,ALLC2 TEXT,PLIKTC1 TEXT,PLIKTC2 TEXT,SELEKTC1 TEXT, SELEKTC2 TEXT,KANSLC1 TEXT,KANSLC2 TEXT,ETIKEC1 TEXT,ETIKEC2 TEXT)";
            
            if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create database");
            }else{
                NSLog(@" create database");
            }
            
            sqlite3_close(exerciseDB);
            
        } else {
            //status.text = @"Failed to open/create database";
        }
   
    [super viewDidLoad];
    
}
-(IBAction)mainlabelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Tankefallor.html" insideView:self.view];
}





-(IBAction)Sparabutton:(id)sender{
    
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    raderaButton.hidden=YES;
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    if([StagC1.text isEqualToString:@""] && [StagC2.text isEqualToString:@""] && [TankeC1.text isEqualToString:@""] && [AllC1.text isEqualToString:@""]&& [AllC2.text isEqualToString:@""] && [PerC1.text isEqualToString:@""] && [PerC2.text isEqualToString:@""]&& [overC1.text isEqualToString:@""] && [overC2.text isEqualToString:@""] && [KanslC1.text isEqualToString:@""]&& [KanslC2.text isEqualToString:@""] && [KataC1.text isEqualToString:@""] && [KataC2.text isEqualToString:@""]&& [DiskC1.text isEqualToString:@""] && [DiskC1.text isEqualToString:@""] && [SelektC1.text isEqualToString:@""]&& [SelektC2.text isEqualToString:@""] && [EtikeC1.text isEqualToString:@""] && [EtikeC2.text isEqualToString:@""]&& [ForC1.text isEqualToString:@""] && [ForC2.text isEqualToString:@""] && [PliktC1.text isEqualToString:@""]&& [PliktC1.text isEqualToString:@""] && [TankeC2.text isEqualToString:@""] ){
       
    }else{
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            if([[list_exercise2 objectAtIndex:0] isEqualToString:@"Null"]){
                NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISETWO (date,stagc1,stagc2,overc1,overc2,tankec1,tankec2,perc1,perc2,diskc1,diskc2,forc1,forc2,katac1,katac2,allc1,allc2,pliktc1,pliktc2,selektc1,selektc2,kanslc1,kanslc2,etikec1,etikec2) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\")", str, StagC1.text,StagC2.text,StagC1.text,overC2.text,TankeC1.text,TankeC2.text,PerC1.text,PerC2.text,DiskC1.text,DiskC2.text,ForC1.text,ForC2.text,KataC1.text,KataC2.text,AllC1.text,AllC2.text,PliktC1.text,PliktC2.text,SelektC1.text,SelektC2.text,KanslC1.text,KanslC2.text,EtikeC1.text,EtikeC2.text];
                
                const char *insert_stmt = [insertSQL UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                    [self clearalltexts];
                    NSLog(@"Save");
                } else {
                    NSLog(@"no");
                }
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
            }else{
                NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISETWO SET stagc1='%@',stagc2='%@', overc1='%@', overc2='%@',tankec1='%@',tankec2='%@', perc1='%@', perc2='%@',diskc1='%@',diskc2='%@', forc1='%@', forc2='%@',katac1='%@',katac2='%@', allc1='%@', allc2='%@',pliktc1='%@',pliktc2='%@', selektc1='%@', selektc2='%@',kanslc1='%@',kanslc2='%@', etikec1='%@', etikec2='%@'  WHERE date='%@'",StagC1.text,StagC2.text, overC1.text,overC2.text,TankeC1.text,TankeC2.text,PerC1.text,PerC2.text,DiskC1.text,DiskC2.text,ForC1.text,ForC2.text,KataC1.text,KataC2.text,AllC1.text,AllC2.text,PliktC1.text,PliktC2.text,SelektC1.text,SelektC2.text,KanslC1.text,KanslC2.text,EtikeC1.text,EtikeC2.text, [listexercise2 objectAtIndex:x]];
                const char *del_stmt = [query UTF8String];
                
                if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK);{
                    if(SQLITE_DONE != sqlite3_step(statement))
                        NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
                    NSLog(@"sss");
                    [self clearalltexts];
                    [listexercise2 removeAllObjects];
                    x=0;
                    [listexercise2 addObject:@"Null"];
                    
                }
                
                
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
                
                
            }
        }
    }
    
    
}
-(IBAction)Nyttbutton:(id)sender{
    if([StagC1.text isEqualToString:@""] && [StagC2.text isEqualToString:@""] && [TankeC1.text isEqualToString:@""] && [AllC1.text isEqualToString:@""]&& [AllC2.text isEqualToString:@""] && [PerC1.text isEqualToString:@""] && [PerC2.text isEqualToString:@""]&& [overC1.text isEqualToString:@""] && [overC2.text isEqualToString:@""] && [KanslC1.text isEqualToString:@""]&& [KanslC2.text isEqualToString:@""] && [KataC1.text isEqualToString:@""] && [KataC2.text isEqualToString:@""]&& [DiskC1.text isEqualToString:@""] && [DiskC1.text isEqualToString:@""] && [SelektC1.text isEqualToString:@""]&& [SelektC2.text isEqualToString:@""] && [EtikeC1.text isEqualToString:@""] && [EtikeC2.text isEqualToString:@""]&& [ForC1.text isEqualToString:@""] && [ForC2.text isEqualToString:@""] && [PliktC1.text isEqualToString:@""]&& [PliktC1.text isEqualToString:@""] && [TankeC2.text isEqualToString:@""] ){
        
    }else{
        alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Please Enter the text above fields"
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                               otherButtonTitles:@"without saving", nil];
        alert.tag=kAlertViewOne;
        [alert show];
        [alert release];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ok");
    //  DATE TEXT,  STAGC1 TEXT ,STAGC2 TEXT,OVERC1 TEXT,OVERC2 TEXT,TANKEC1 TEXT,TANKEC2 TEXT,PERC1 TEXT,PERC2 TEXT,DISKC1 TEXT,DISKC2 TEXT, FORC1 TEXT,FORC2 TEXT,KATAC1 TEXT, KATAC2 TEXT,ALLC1 TEXT,ALLC2 TEXT,PLIKTC1 TEXT,PLIKTC2 TEXT,SELEKTC1 TEXT, SELEKTC2 TEXT,KANSLC1 TEXT,KANSLC2 TEXT,ETIKEC1 TEXT,ETIKEC2 TEXT
    
    if(alert.tag  == kAlertViewOne) {
        if (buttonIndex == 1) {
            NSLog(@"new form");
            [self clearalltexts];
            raderaButton.hidden=YES;
            [list_exercise2  removeAllObjects];
            x=0;
            [list_exercise2 addObject:@"Null"];
            
        }else{
            
        }
    }else{
    }
    
}
-(IBAction)nextbutton:(id)sender{
    //  etdl=[[ExerciseTwoDateList alloc]initWithNibName:@"ExerciseTwoDateList" bundle:nil];
    //  [self.navigationController pushViewController:etdl animated:YES];
    scroll.scrollEnabled = NO;
    listexercise2=[[NSMutableArray alloc]init];
    [listexercise2 removeAllObjects];
    [self.view bringSubviewToFront:listofdates];
    listofdates.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
    [self getlistofDates];
}
-(void)getlistofDates{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT date FROM EXERCISETWO ORDER BY date DESC"
                              ];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* date = (char*) sqlite3_column_text(statement,0);
                NSString *tmp;
                if (date != NULL){
                    tmp = [NSString stringWithUTF8String:date];
                    NSLog(@"value form db :%@",tmp);
                    [listexercise2 addObject:tmp];
                }
            }
            if (sqlite3_step(statement) != SQLITE_ROW) {
                NSLog(@"%u",listexercise2.count);
                if (listexercise2.count==0) {
                    listofdates.hidden = YES;
                    scroll.scrollEnabled=YES;
                }
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(exerciseDB);
        }
    }
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listexercise2 count];
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer = @"CellIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    // Using a cell identifier will allow your app to reuse cells as they come and go from the screen.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    
    // Deciding which data to put into this particular cell.
    // If it the first row, the data input will be "Data1" from the array.
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [listexercise2 objectAtIndex:row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Upon selecting an event, create an EKEventViewController to display the event.
	NSDictionary *dictionary = [self.listexercise2 objectAtIndex:indexPath.row];
    NSLog(@"%@",dictionary);
    x=indexPath.row;
    SelectedDate=[NSString stringWithFormat:@"%@", dictionary];
    NSLog(@"%@",SelectedDate);
    raderaButton.hidden=NO;
    [list_exercise2 removeAllObjects];
    [list_exercise2 addObject:SelectedDate];
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISETWO WHERE date='%@'", SelectedDate];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char* c1 = (char*) sqlite3_column_text(statement,2);
            
            if (c1 != NULL){
                StagC1.text= [NSString stringWithUTF8String:c1];
                NSLog(@" StagC1.text :%@",StagC1.text);
                
            }
            char* c2 = (char*) sqlite3_column_text(statement,3);
            
            if (c2 != NULL){
                StagC2.text = [NSString stringWithUTF8String:c2];
                NSLog(@" StagC2.text :%@", StagC2.text);
                
            }
            
            char* c3 = (char*) sqlite3_column_text(statement,4);
            if (c3!= NULL){
                overC1.text= [NSString stringWithUTF8String:c3];
                NSLog(@"overC1.text :%@",overC1.text);
                
            }
            
            char* c4 = (char*) sqlite3_column_text(statement,5);
            
            if (c4 != NULL){
                overC2.text= [NSString stringWithUTF8String:c4];
                NSLog(@"overC2.text%@",overC2.text);
                
            }
            char* c5 = (char*) sqlite3_column_text(statement,6);
            
            if (c5 != NULL){
                TankeC1.text= [NSString stringWithUTF8String:c5];
                NSLog(@"value form db :%@", TankeC1.text);
                
            }
            char* c6 = (char*) sqlite3_column_text(statement,7);
            
            if (c6 != NULL){
                TankeC2.text= [NSString stringWithUTF8String:c6];
                NSLog(@"value form db :%@", TankeC2.text);
                
            }
            
            char* c7 = (char*) sqlite3_column_text(statement,8);
            
            if (c7 != NULL){
                PerC1.text= [NSString stringWithUTF8String:c7];
                NSLog(@"value form db :%@",PerC1.text);
                
            }
            char* c8 = (char*) sqlite3_column_text(statement,9);
            
            if (c4 != NULL){
                PerC2.text= [NSString stringWithUTF8String:c8];
                NSLog(@"value form db :%@",PerC2.text);
                
            }
            char* c9 = (char*) sqlite3_column_text(statement,10);
            
            if (c4 != NULL){
                DiskC1.text= [NSString stringWithUTF8String:c9];
                NSLog(@"value form db :%@",DiskC1.text);
                
            }
            char* c10 = (char*) sqlite3_column_text(statement,11);
            
            if (c10 != NULL){
                DiskC2.text= [NSString stringWithUTF8String:c10];
                NSLog(@"value form db :%@",DiskC2.text);
                
            }
            char* c11 = (char*) sqlite3_column_text(statement,12);
            
            if (c11 != NULL){
                ForC1.text= [NSString stringWithUTF8String:c11];
                NSLog(@"value form db :%@",ForC1.text);
                
            }
            char* c12 = (char*) sqlite3_column_text(statement,13);
            if (c12 != NULL){
                ForC2.text= [NSString stringWithUTF8String:c12];
                NSLog(@" ForC2.text :%@", ForC2.text);
                
            }
            char* c13 = (char*) sqlite3_column_text(statement,14);
            
            if (c13 != NULL){
                KataC1.text= [NSString stringWithUTF8String:c13];
                NSLog(@"value form db :%@", KataC1.text);
                
            }
            char* c14 = (char*) sqlite3_column_text(statement,15);
            
            if (c14 != NULL){
                KataC2.text= [NSString stringWithUTF8String:c14];
                NSLog(@"value form db :%@", KataC2.text);
                
            }
            char* c15 = (char*) sqlite3_column_text(statement,16);
            
            if (c15 != NULL){
                AllC1.text= [NSString stringWithUTF8String:c15];
                NSLog(@"value form db :%@",AllC1.text);
                
            }
            char* c16 = (char*) sqlite3_column_text(statement,17);
            
            if (c16 != NULL){
                AllC2.text= [NSString stringWithUTF8String:c16];
                NSLog(@"value form db :%@",AllC2.text);
                
            }
            char* c17 = (char*) sqlite3_column_text(statement,18);
            
            if (c17 != NULL){
                PliktC1.text= [NSString stringWithUTF8String:c17];
                NSLog(@"value form db :%@", PliktC1.text);
                
            }
            char* c18 = (char*) sqlite3_column_text(statement,19);
            
            if (c18 != NULL){
                PliktC2.text= [NSString stringWithUTF8String:c18];
                NSLog(@"value form db :%@", PliktC2.text);
                
            }
            char* c19 = (char*) sqlite3_column_text(statement,20);
            
            if (c19 != NULL){
                SelektC1.text= [NSString stringWithUTF8String:c19];
                NSLog(@"value form db :%@",SelektC1.text);
                
            }char* c20 = (char*) sqlite3_column_text(statement,21);
            
            if (c20 != NULL){
                SelektC2.text= [NSString stringWithUTF8String:c20];
                NSLog(@"value form db :%@",SelektC2.text);
                
            }char* c21 = (char*) sqlite3_column_text(statement,22);
            
            if (c21!= NULL){
                KanslC1.text= [NSString stringWithUTF8String:c21];
                NSLog(@"value form db :%@",KanslC1.text);
                
            }
            char* c22 = (char*) sqlite3_column_text(statement,23);
            
            if (c22 != NULL){
                KanslC2.text= [NSString stringWithUTF8String:c22];
                NSLog(@"value form db :%@",KanslC2.text);
                
            }
            char* c23 = (char*) sqlite3_column_text(statement,24);
            
            if (c23 != NULL){
                EtikeC1.text= [NSString stringWithUTF8String:c23];
                NSLog(@"value form db :%@",EtikeC1.text);
                
            }
            char* c24 = (char*) sqlite3_column_text(statement,25);
            
            if (c24 != NULL){
                EtikeC2.text= [NSString stringWithUTF8String:c24];
                NSLog(@"value form db :%@",EtikeC2.text);
                
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    
    
}
-(IBAction)aMethod:(id)sender{
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISETWO WHERE date='%@'", [listexercise2 objectAtIndex:x]];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"sss");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    [list_exercise2  removeAllObjects];
    x=0;
    [list_exercise2 addObject:@"Null"];
    raderaButton.hidden=YES;
    [self clearalltexts];
    listofdates.hidden = YES;
    scroll.scrollEnabled = YES;
    
}
-(IBAction)CloseButton:(id)sender{
    listofdates.hidden = YES;
    scroll.scrollEnabled = YES;
}
-(void)clearalltexts{
    StagC1.text = @"";
    StagC2.text  = @"";
    overC1.text = @"";
    overC2.text=@"";
    TankeC1.text=@"";
    TankeC2.text=@"";
    PerC1.text=@"";
    PerC2.text=@"";
    DiskC1.text=@"";
    DiskC2.text=@"";
    ForC1.text=@"";
    ForC2.text=@"";
    KataC1.text=@"";
    KataC2.text=@"";
    AllC1.text=@"";
    AllC2.text=@"";
    PliktC1.text=@"";
    PliktC2.text=@"";
    SelektC1.text=@"";
    SelektC2.text=@"";
    KanslC1.text=@"";
    KanslC2.text=@"";
    EtikeC1.text=@"";
    EtikeC2.text=@"";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end