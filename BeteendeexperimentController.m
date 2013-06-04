//
//  BeteendeexperimentController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/2/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "BeteendeexperimentController.h"
#import "MTPopupWindow.h"
#import "PMCalendar.h"
@interface BeteendeexperimentController ()
@property (nonatomic, strong) PMCalendarController *pmCC;
@end

@implementation BeteendeexperimentController
@synthesize label,label1,ex3c1,ex3c2,ex3c3,ex3c4,ex3c5,slabel1,slabel2,pmCC;
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
    
    [ex3c1 resignFirstResponder];
    
    return YES;
}
- (void)viewDidLoad
{
    self.navigationItem.title=@"Beteendeexperiment";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    [self.view addSubview:listofdates];
    listofdates.hidden=YES;
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 1300)];
    
//    label.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGesture =
//    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainlabelalert:)] autorelease];
//    [label addGestureRecognizer:tapGesture];
    
    label1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(l1alert:)] autorelease];
    [label1 addGestureRecognizer:tapGesture2];
    
    
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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE4 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  DATUM TEXT ,EXPERIMENTET TEXT,FORUTSAGE TEXT,FORUTPRC TEXT, RESULTAT TEXT,LARDOMAR TEXT,LARDPRC TEXT)";
            
            if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create database");
            }else{
                 NSLog(@"create database");
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
-(IBAction)mainlabelalert:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"Beteebdeexperiment.html" insideView:self.view];
}
-(IBAction)l1alert:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"tanke.html" insideView:self.view];
}
-(IBAction)changeSlider:(id)sender {
    
    NSString *sl1= [[NSString alloc] initWithFormat:@"%d%@", (int)slider.value,@"%"];
    NSLog(@"sl1%@",sl1);
    self.slabel1.text=sl1;
     NSLog(@"self.slabel1.text%@",self.slabel1.text);
    
}
-(IBAction)changeSlider1:(id)sender {
    
    NSString *sl2= [[NSString alloc] initWithFormat:@"%d%@", (int)slider1.value,@"%"];
    NSLog(@"str%@",sl2);
    self.slabel2.text=sl2;
     NSLog(@"self.slabel2.text%@",self.slabel2.text);
    
}
-(IBAction)saveButton:(id)sender{
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    if ([ex3c1.text isEqualToString:@""]||[ex3c2.text isEqualToString:@""]||[ex3c3.text isEqualToString:@""]||[ex3c4.text isEqualToString:@""]||[ex3c5.text isEqualToString:@""]) {
        
    }else{
    sqlite3_stmt    *statement;
    //DATE TEXT,  DATUM TEXT ,EXPERIMENTET TEXT,FORUTSAGE TEXT, RESULTAT TEXT,LARDOMAR TEXT
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE4 (date,datum,experimentet,forutsage,forutprc,resultat,lardomar,lardprc) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", str, ex3c1.text,ex3c2.text, ex3c3.text , slabel1.text, ex3c4.text,ex3c5.text,slabel2.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
             
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            
            
            ex3c1.text=@"";
             ex3c2.text=@""; ex3c3.text=@""; ex3c4.text=@""; ex3c5.text=@"";
            
            
        } else {
            NSLog(@"no");
        }
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }
    }

}
-(IBAction)newButton:(id)sender{
    if([ex3c1.text isEqualToString:@""] && [ex3c2.text isEqualToString:@""] && [ex3c3.text isEqualToString:@""] && [ex3c4.text isEqualToString:@""]&& [ex3c5.text isEqualToString:@""]){
        
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
   
        if (buttonIndex == 1) {
            NSLog(@"new form");
            ex3c1.text=@"";
            ex3c2.text=@""; ex3c3.text=@""; ex3c4.text=@""; ex3c5.text=@"";
            
        }else{
            
        }
   
}
-(IBAction)nextButton:(id)sender{
   // bdl=[[BeteendeDateList alloc]initWithNibName:@"BeteendeDateList" bundle:nil];
   // [self.navigationController pushViewController:bdl animated:YES];
    
    scroll.scrollEnabled = NO;
    //listexercise1=[[NSMutableArray alloc]init];
    //[listexercise1 removeAllObjects];
    [self.view bringSubviewToFront:listofdates];
    listofdates.hidden = NO;
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
}
-(IBAction)CloseButton:(id)sender{
    scroll.scrollEnabled = YES;
     listofdates.hidden = YES;
}
    - (IBAction)showCalendar:(id)sender
    {
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
        ex3c1.text = [NSString stringWithFormat:@"%@"
                            , [newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]
                           ];
    }
- (IBAction)RaderaButton:(id)sender{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
