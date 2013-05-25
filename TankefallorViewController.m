//
//  TankefallorViewController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/30/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "TankefallorViewController.h"
#import "MTPopupWindow.h"
@interface TankefallorViewController ()

@end

@implementation TankefallorViewController
@synthesize StagC2,StagC1,SelektC2,SelektC1,overC1,overC2,TankeC2,TankeC1,PerC1,PerC2,PliktC1,PliktC2,DiskC1,DiskC2,ForC1,ForC2,KanslC1,KanslC2,KataC1,KataC2,AllC1,AllC2,EtikeC1,EtikeC2;
@synthesize label;
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

- (void)viewDidLoad
{
    
    self.navigationItem.title=@"Tankefällor";
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 3000)];
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
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == YES)
    {
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
    }
    
    [filemgr release];
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
    
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
             NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISETWO (date,stagc1,stagc2,overc1,overc2,tankec1,tankec2,perc1,perc2,diskc1,diskc2,forc1,forc2,katac1,katac2,allc1,allc2,pliktc1,pliktc2,selektc1,selektc2,kanslc1,kanslc2,etikec1,etikec2) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\")", str, StagC1.text,StagC2.text,StagC1.text,overC2.text,TankeC1.text,TankeC2.text,PerC1.text,PerC2.text,DiskC1.text,DiskC2.text,ForC1.text,ForC2.text,KataC1.text,KataC2.text,AllC1.text,AllC2.text,PliktC1.text,PliktC2.text,SelektC1.text,SelektC2.text,KanslC1.text,KanslC2.text,EtikeC1.text,EtikeC2.text];
        					
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
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
            
             NSLog(@"Save");
        } else {
            NSLog(@"no");
        }
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }
    



}
-(IBAction)Nyttbutton:(id)sender{
    if([StagC1.text isEqualToString:@""] && [StagC2.text isEqualToString:@""] && [TankeC1.text isEqualToString:@""] && [AllC1.text isEqualToString:@""]){
        
    }else{
     UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Please Enter the text above fields"
                                        delegate:self
                               cancelButtonTitle:@"Cancel"
                               otherButtonTitles:@"without saving", nil];
        
        [alert show];
        [alert release];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ok");
    //  DATE TEXT,  STAGC1 TEXT ,STAGC2 TEXT,OVERC1 TEXT,OVERC2 TEXT,TANKEC1 TEXT,TANKEC2 TEXT,PERC1 TEXT,PERC2 TEXT,DISKC1 TEXT,DISKC2 TEXT, FORC1 TEXT,FORC2 TEXT,KATAC1 TEXT, KATAC2 TEXT,ALLC1 TEXT,ALLC2 TEXT,PLIKTC1 TEXT,PLIKTC2 TEXT,SELEKTC1 TEXT, SELEKTC2 TEXT,KANSLC1 TEXT,KANSLC2 TEXT,ETIKEC1 TEXT,ETIKEC2 TEXT
    

        if (buttonIndex == 1) {
            NSLog(@"new form");
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
            
            
            
        }else{
            
        }
    
}
-(IBAction)nextbutton:(id)sender{
    etdl=[[ExerciseTwoDateList alloc]initWithNibName:@"ExerciseTwoDateList" bundle:nil];
    [self.navigationController pushViewController:etdl animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
