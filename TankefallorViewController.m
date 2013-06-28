//
//  TankefallorViewController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "TankefallorViewController.h"
#import "MTPopupWindow.h"


#define kAlertViewOne 1
#define kAlertViewTwo 2


@interface TankefallorViewController ()

@property (nonatomic) BOOL isSaved;

@end

@implementation TankefallorViewController

@synthesize StagC2,StagC1,SelektC2,SelektC1,overC1,overC2,TankeC2,TankeC1,PerC1,PerC2,PliktC1,PliktC2,DiskC1,DiskC2,ForC1,ForC2,KanslC1,KanslC2,KataC1,KataC2,AllC1,AllC2,listexercise2;

@synthesize isSaved;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark -- TextViewDelegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
                         }
                         completion:^(BOOL finished){
                             // whatever you need to do when animations are complete
                             
                         }];
    }
    else {
        return YES;
    }
    return 0;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         [scroll setContentOffset:CGPointMake(scroll.frame.origin.x, textView.frame.origin.y - 30) animated:YES];
                     }
                     completion:^(BOOL finished){
                         // whatever you need to do when animations are complete
                         
                     }];
    
    return YES;
}


#pragma mark ViewLifeCycle Methods

- (void)viewDidLoad
{
    
    self.navigationItem.title=@"Tankefällor";
    
  
    scroll.scrollEnabled = YES;
    
    [scroll setContentSize:CGSizeMake(320, 4029)];
    scroll1.scrollEnabled = YES;
    
    [scroll1 setContentSize:CGSizeMake(320, 4418)];
   
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
   databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"tankefallorDB.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &tankefallorDB) == SQLITE_OK)
        {
            char *errMsg;
           const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISETWO (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  STAGC1 TEXT ,STAGC2 TEXT,OVERC1 TEXT,OVERC2 TEXT,TANKEC1 TEXT,TANKEC2 TEXT,PERC1 TEXT,PERC2 TEXT,DISKC1 TEXT,DISKC2 TEXT, FORC1 TEXT,FORC2 TEXT,KATAC1 TEXT, KATAC2 TEXT,ALLC1 TEXT,ALLC2 TEXT,PLIKTC1 TEXT,PLIKTC2 TEXT,SELEKTC1 TEXT, SELEKTC2 TEXT,KANSLC1 TEXT,KANSLC2 TEXT)";
            
            if (sqlite3_exec(tankefallorDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            
            sqlite3_close(tankefallorDB);
            
        } else {
            NSLog(@"Failed to open or create database");
        }
    }else {
        [self getDetailsFromtankefallorDB];
    }
    
    [filemgr release];
   
    [super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    isSaved = YES;
}



-(IBAction)mainlabelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Tankefallor.html" insideView:self.view];
}


-(IBAction)Sparabutton:(id)sender {
    
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    if([StagC1.text isEqualToString:@""] && [StagC2.text isEqualToString:@""] && [TankeC1.text isEqualToString:@""] && [AllC1.text isEqualToString:@""]&& [AllC2.text isEqualToString:@""] && [PerC1.text isEqualToString:@""] && [PerC2.text isEqualToString:@""] && [overC1.text isEqualToString:@""] && [overC2.text isEqualToString:@""] && [KanslC1.text isEqualToString:@""]&& [KanslC2.text isEqualToString:@""] && [KataC1.text isEqualToString:@""] && [KataC2.text isEqualToString:@""] && [DiskC1.text isEqualToString:@""] && [DiskC1.text isEqualToString:@""] && [SelektC1.text isEqualToString:@""]&& [SelektC2.text isEqualToString:@""] && [ForC1.text isEqualToString:@""] && [ForC2.text isEqualToString:@""] && [PliktC1.text isEqualToString:@""]&& [PliktC1.text isEqualToString:@""] && [TankeC2.text isEqualToString:@""] ){
        
    }
    else if (sqlite3_open(dbpath, &tankefallorDB) == SQLITE_OK) {
        if (isSaved == YES) {
            
            
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISETWO (date,stagc1,stagc2,overc1,overc2,tankec1,tankec2,perc1,perc2,diskc1,diskc2,forc1,forc2,katac1,katac2,allc1,allc2,pliktc1,pliktc2,selektc1,selektc2,kanslc1,kanslc2) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\")", str, StagC1.text,StagC2.text,StagC1.text,overC2.text,TankeC1.text,TankeC2.text,PerC1.text,PerC2.text,DiskC1.text,DiskC2.text,ForC1.text,ForC2.text,KataC1.text,KataC2.text,AllC1.text,AllC2.text,PliktC1.text,PliktC2.text,SelektC1.text,SelektC2.text,KanslC1.text,KanslC2.text];
            
            const char *insert_stmt = [insertSQL UTF8String];
            
            sqlite3_prepare_v2(tankefallorDB, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                isSaved = NO;
                NSLog(@"Save");
                
            } else {
                NSLog(@"Failed to add contact");
            }
            sqlite3_finalize(statement);
            sqlite3_close(tankefallorDB);
        }
        else {
            NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISETWO SET stagc1='%@',stagc2='%@', overc1='%@', overc2='%@',tankec1='%@',tankec2='%@', perc1='%@', perc2='%@',diskc1='%@',diskc2='%@', forc1='%@', forc2='%@',katac1='%@',katac2='%@', allc1='%@', allc2='%@',pliktc1='%@',pliktc2='%@', selektc1='%@', selektc2='%@',kanslc1='%@',kanslc2='%@'",StagC1.text,StagC2.text, overC1.text,overC2.text,TankeC1.text,TankeC2.text,PerC1.text,PerC2.text,DiskC1.text,DiskC2.text,ForC1.text,ForC2.text,KataC1.text,KataC2.text,AllC1.text,AllC2.text,PliktC1.text,PliktC2.text,SelektC1.text,SelektC2.text,KanslC1.text,KanslC2.text];
            
            const char *del_stmt = [query UTF8String];
            
            if (sqlite3_prepare_v2(tankefallorDB, del_stmt, -1, & statement, NULL)==SQLITE_OK);{
                if(SQLITE_DONE != sqlite3_step(statement))
                    NSLog(@"Error while updating. %s", sqlite3_errmsg(tankefallorDB));
                NSLog(@"sss");
                isSaved = NO;
                [self clearalltexts];
                
                
            }
            
            
            sqlite3_finalize(statement);
            sqlite3_close(tankefallorDB);
        }
    }
    UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Sparat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
    [alert1 show];
    [alert1 release];
}
  
//************** Updated the tankerfallorDB

/*NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISETWO SET stagc1='%@',stagc2='%@', overc1='%@', overc2='%@',tankec1='%@',tankec2='%@', perc1='%@', perc2='%@',diskc1='%@',diskc2='%@', forc1='%@', forc2='%@',katac1='%@',katac2='%@', allc1='%@', allc2='%@',pliktc1='%@',pliktc2='%@', selektc1='%@', selektc2='%@',kanslc1='%@',kanslc2='%@', etikec1='%@', etikec2='%@'  WHERE date='%@'",StagC1.text,StagC2.text, overC1.text,overC2.text,TankeC1.text,TankeC2.text,PerC1.text,PerC2.text,DiskC1.text,DiskC2.text,ForC1.text,ForC2.text,KataC1.text,KataC2.text,AllC1.text,AllC2.text,PliktC1.text,PliktC2.text,SelektC1.text,SelektC2.text,KanslC1.text,KanslC2.text,EtikeC1.text,EtikeC2.text, [listexercise2 objectAtIndex:x]];
 const char *del_stmt = [query UTF8String];
 
 if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK);{
 if(SQLITE_DONE != sqlite3_step(statement))
 NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
 NSLog(@"sss");
 isSaved = NO;*/






-(IBAction)Nyttbutton:(id)sender {
    if([StagC1.text isEqualToString:@""] && [StagC2.text isEqualToString:@""] && [TankeC1.text isEqualToString:@""] && [AllC1.text isEqualToString:@""]&& [AllC2.text isEqualToString:@""] && [PerC1.text isEqualToString:@""] && [PerC2.text isEqualToString:@""]&& [overC1.text isEqualToString:@""] && [overC2.text isEqualToString:@""] && [KanslC1.text isEqualToString:@""]&& [KanslC2.text isEqualToString:@""] && [KataC1.text isEqualToString:@""] && [KataC2.text isEqualToString:@""]&& [DiskC1.text isEqualToString:@""] && [DiskC1.text isEqualToString:@""] && [SelektC1.text isEqualToString:@""]&& [SelektC2.text isEqualToString:@""] && [ForC1.text isEqualToString:@""] && [ForC2.text isEqualToString:@""] && [PliktC1.text isEqualToString:@""]&& [PliktC1.text isEqualToString:@""] && [TankeC2.text isEqualToString:@""] ){
        
    }else {
        if (isSaved == YES) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Du har inte sparat ditt formulär, är du säker på att du vill fortsätta?"
                                            delegate:self
                                   cancelButtonTitle:@"Forsätt"
                                   otherButtonTitles:@"Avbryt", nil];
            alert.tag=kAlertViewOne;
            [alert show];
            [alert release];
        }
        else {
            [self clearalltexts];
    
            isSaved = YES;
        }
    }
}


-(void)getDetailsFromtankefallorDB {
    
    const char *dbpath = [databasePath UTF8String];
    
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &tankefallorDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM EXERCISETWO ORDER BY date DESC"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(tankefallorDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {

            while  (sqlite3_step(statement) == SQLITE_ROW) {
                isSaved = YES;
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
                
            }
            
            
            
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(tankefallorDB);
}


-(IBAction)nextbutton:(id)sender{
    
    scroll.scrollEnabled = NO;
    
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
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end