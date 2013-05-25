//
//  Utmanatankar.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/1/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Utmanatankar.h"
#import "MTPopupWindow.h"
NSArray *pArray;
@interface Utmanatankar ()

@end

@implementation Utmanatankar
@synthesize  label,label1,strategier,negative,din,motavis,tanke,alltanke,c1,c2,c3,c4,c5,c6;

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
   self.navigationItem.title=@"Utmana tankr";
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 1400)];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
//    label.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGesture =
//    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelalert:)] autorelease];
//    [label addGestureRecognizer:tapGesture];
    
    label1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(label1alert:)] autorelease];
    [label1 addGestureRecognizer:tapGesture2];
    
    
    strategier.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(strategieralert:)] autorelease];
    [strategier addGestureRecognizer:tapGesture3];
    
    
    negative.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture4 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(negativealert:)] autorelease];
    [negative addGestureRecognizer:tapGesture4];
    
    
    din.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture5 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dinalert:)] autorelease];
    [din addGestureRecognizer:tapGesture5];

    motavis.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture6 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(motavisalert:)] autorelease];
    [motavis addGestureRecognizer:tapGesture6];
    
    tanke.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture7 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tankealert:)] autorelease];
    [tanke addGestureRecognizer:tapGesture7];
    
    alltanke.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture8 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alltankealert:)] autorelease];
    [alltanke addGestureRecognizer:tapGesture8];

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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE3 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  NEGATIVE TEXT ,DINA TEXT,HUR TEXT, MOTBEVIS TEXT,TANKEFALLA TEXT,ALTERNATIV TEXT)";
            
            if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create database");
            }
            
            sqlite3_close(exerciseDB);
            
        } else {
            //status.text = @"Failed to open/create database";
        }
    }
    
    [filemgr release];

    
 [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)labelalert:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"Utmanatankar.html" insideView:self.view];
}

-(IBAction)label1alert:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"om.html" insideView:self.view];
}
-(IBAction)strategieralert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"tankefallar.html" insideView:self.view];
}
-(IBAction)negativealert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"tanke.html" insideView:self.view];
}

-(IBAction)dinalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Minabevis.html" insideView:self.view];
}
-(IBAction)motavisalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Motbevis.html" insideView:self.view];
}
-(IBAction)tankealert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"tanefallor.html" insideView:self.view];
}
-(IBAction)alltankealert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Alternativtanke.html" insideView:self.view];
}

-(IBAction)changeSlider:(id)sender {
    
   NSString *str= [[NSString alloc] initWithFormat:@"%d%@", (int)slider.value,@"%"];
    self.c3.text=str;
}

-(IBAction)sparabutton:(id)sender{
    
    NSLog(@"c2%@",c2.text);
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    //Get the string date
    
    NSString* str1 = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str1);
    if ([c1.text isEqualToString:@""]||[c2.text isEqualToString:@""]||[c4.text isEqualToString:@""]
        ||[c5.text isEqualToString:@""]||[c6.text isEqualToString:@""]) {
        
    }else{
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE3 (date,negative,dina,hur,motbevis,tankefalla,alternativ) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\",\"%@\",\"%@\")", str1, c1.text,c2.text, c3.text ,c4.text,c5.text,c6.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)

            

        {
            c1.text=@"";
            c2.text=@"";
            c3.text=@"0%";
            c4.text=@"";
            c5.text=@"";
            c6.text=@"";
                        NSLog(@"yes");
            
        } else {
            NSLog(@"no");
        }
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }
    

    }

}
-(IBAction)newbutton:(id)sender{
    if ([c1.text isEqualToString:@""]&&[c2.text isEqualToString:@""]&&[c4.text isEqualToString:@""]
        &&[c5.text isEqualToString:@""]&&[c6.text isEqualToString:@""]) {
        
    }else{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Please Enter the text above fields"
                                    delegate:self
                           cancelButtonTitle:@"Cancel"
                           otherButtonTitles:@"without saving", nil];
   
    [alert show];
    [alert release];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
        if (buttonIndex == 1) {
            NSLog(@"new form");
           
            c1.text=@"";
            c2.text=@"";
            c3.text=@"0%";
            c4.text=@"";
            c5.text=@"";
            c6.text=@"";
        }else{
            
        }
    
}

-(IBAction)nextbutton:(id)sender{
    udv=[[UtmanaDateView alloc]initWithNibName:@"UtmanaDateView" bundle:nil];
    [self.navigationController pushViewController:udv animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
