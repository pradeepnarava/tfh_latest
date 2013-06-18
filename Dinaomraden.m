//
//  Dinaomraden.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/11/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Dinaomraden.h"
#import <QuartzCore/QuartzCore.h>
#import "DinKompass.h"

@interface Dinaomraden ()

@end

@implementation Dinaomraden
@synthesize  textview;

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
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Dina områden";
    dateOfCurrentItem = nil;
    scrollView.contentSize = self.view.frame.size;
    //CGRect frame = CGRectMake(10, 270, 350, 50);
   // subView = [[UIView alloc] initWithFrame:frame];
    [self.view addSubview:subView];
    subView.hidden=YES;
    
    [self.view addSubview:settingsView];
    settingsView.hidden=YES;
      label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelalert:)] autorelease];
    [label addGestureRecognizer:tapGesture];
    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(settingsbutton:)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"alarm-button.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingsbutton:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 30, 30);
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
    
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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE7 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  OMRADE TEXT ,AKTIVITET TEXT,AVERAGE TEXT,FAMILJ TEXT,VANNER TEXT,KARLEK TEXT,ARBETE TEXT,EKONOMI TEXT,KOST TEXT,MOTION TEXT,VILA TEXT,FRITID TEXT,SOMN TEXT)";
            
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
    
    [self averagevalue];
    // Do any additional setup after loading the view from its nib.
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self initPlot];
//}

- (void)updateCurrentItem
{
    if (dateOfCurrentItem)
    {
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
            
            NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE7 WHERE date='%@'", dateOfCurrentItem];
            
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
                
                char* c4 = (char*) sqlite3_column_text(statement,5);
                NSString *tmp4;
                if (c4!= NULL){
                    tmp4= [NSString stringWithUTF8String:c4];
                    NSLog(@"value form db :%@",tmp4);
                    tf1.text = tmp4;
                }
                
                char* c5 = (char*) sqlite3_column_text(statement,6);
                NSString *tmp5;
                if (c5!= NULL){
                    tmp5= [NSString stringWithUTF8String:c5];
                    NSLog(@"value form db :%@",tmp5);
                    tf2.text = tmp5;
                }
                
                char* c6 = (char*) sqlite3_column_text(statement,7);
                NSString *tmp6;
                if (c6!= NULL){
                    tmp6= [NSString stringWithUTF8String:c6];
                    NSLog(@"value form db :%@",tmp6);
                    tf3.text = tmp6;
                }
                
                char* c7 = (char*) sqlite3_column_text(statement,8);
                NSString *tmp7;
                if (c7!= NULL){
                    tmp7= [NSString stringWithUTF8String:c7];
                    NSLog(@"value form db :%@",tmp7);
                    tf4.text = tmp7;
                }
                
                char* c8 = (char*) sqlite3_column_text(statement,9);
                NSString *tmp8;
                if (c8!= NULL){
                    tmp8= [NSString stringWithUTF8String:c8];
                    NSLog(@"value form db :%@",tmp8);
                    tf5.text = tmp8;
                }
                
                char* c9 = (char*) sqlite3_column_text(statement,10);
                NSString *tmp9;
                if (c9!= NULL){
                    tmp9= [NSString stringWithUTF8String:c9];
                    NSLog(@"value form db :%@",tmp9);
                    tf6.text = tmp9;
                }
                
                char* c10 = (char*) sqlite3_column_text(statement,11);
                NSString *tmp10;
                if (c10!= NULL){
                    tmp10= [NSString stringWithUTF8String:c10];
                    NSLog(@"value form db :%@",tmp10);
                    tf7.text = tmp10;
                }
                
                char* c11 = (char*) sqlite3_column_text(statement,12);
                NSString *tmp11;
                if (c11!= NULL){
                    tmp11= [NSString stringWithUTF8String:c11];
                    NSLog(@"value form db :%@",tmp11);
                   tf8.text = tmp11;
                }
                
                char* c12 = (char*) sqlite3_column_text(statement,13);
                NSString *tmp12;
                if (c12!= NULL){
                    tmp12= [NSString stringWithUTF8String:c12];
                    NSLog(@"value form db :%@",tmp12);
                    tf9.text = tmp12;
                }
                
                char* c13 = (char*) sqlite3_column_text(statement,14);
                NSString *tmp13;
                if (c13!= NULL){
                    tmp13= [NSString stringWithUTF8String:c13];
                    NSLog(@"value form db :%@",tmp13);
                    tf10.text = tmp13;
                }
             }
            
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
        }
//        dateOfCurrentItem = nil;
    }
    else
    {
        label.text=@"";
        textview.text=@"";
        [averageBt setTitle:@"" forState:UIControlStateNormal];
        tf1.text=@"";
        tf2.text=@"";
        tf3.text=@"";  tf4.text=@"";
        tf5.text=@"";
        tf6.text=@"";
        tf7.text=@"";
        tf8.text=@"";
        tf9.text=@"";
        tf10.text=@"";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [scrollView setContentOffset:CGPointZero animated:YES];
}

-(IBAction)labelalert:(id)sender
{
    [self.view bringSubviewToFront:subView];
    subView.hidden = NO;
    settingsView.hidden = YES;
    label1.text=text1.text;
    label2.text=text2.text;
    label3.text=text3.text;
    label4.text=text4.text;
    label5.text=text5.text;
    label6.text=text6.text;
    label7.text=text7.text;
    label8.text=text8.text;
    label9.text=text9.text;
    label10.text=text10.text;    
 
    
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectedcheckbox:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 1)
    {
              NSLog(@"%@",scb);
            if(cb1.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                if ([label.text isEqualToString:@""]) {

                [cb1 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                label.text=label1.text;
                }
            }else{
                [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                label.text=@"";
            }

        }
          
    else if(btn.tag == 2){
       
        if(cb2.currentImage==[UIImage imageNamed:@"uncheck.png"]){
             if ([label.text isEqualToString:@""]) {
            [cb2 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
             label.text=label2.text;
             }
        }else{
            [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
       label.text=@"";
        }
               }
   
    
    else if(btn.tag == 3){
        
        if(cb3.currentImage==[UIImage imageNamed:@"uncheck.png"]){
             if ([label.text isEqualToString:@""]) {
            [cb3 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
            label.text=label3.text;
             }
        }else{
            [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        label.text=@"";
        }
     
          }else if(btn.tag == 4){
              if(cb4.currentImage==[UIImage imageNamed:@"uncheck.png"]){
                   if ([label.text isEqualToString:@""]) {
                  [cb4 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                   label.text=label4.text;
                   }
              }else{
                  [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                   label.text=@"";
              }
           
          
        
    }else if(btn.tag == 5){
        
        if(cb5.currentImage==[UIImage imageNamed:@"uncheck.png"]){
             if ([label.text isEqualToString:@""]) {
            [cb5 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
             label.text=label5.text;
             }
        }else{
            [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
             label.text=@"";
        }
       
    }else if(btn.tag == 6){
        if(cb6.currentImage==[UIImage imageNamed:@"uncheck.png"]){
             if ([label.text isEqualToString:@""]) {
            [cb6 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
             label.text=label6.text;
             }
        }else{
            [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
             label.text=@"";
        }
      
     
    }else if(btn.tag == 7){
        if(cb7.currentImage==[UIImage imageNamed:@"uncheck.png"]){
             if ([label.text isEqualToString:@""]) {
            [cb7 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
             label.text=label7.text;
            }
        }else{
            [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
             label.text=@"";
        
        }
}else if(btn.tag == 8){
    if(cb8.currentImage==[UIImage imageNamed:@"uncheck.png"]){
         if ([label.text isEqualToString:@""]) {
        [cb8 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
         label.text=label8.text;
        }
    }else{
        [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
         label.text=@"";
    }
    
}else if(btn.tag == 9){
    
    if(cb9.currentImage==[UIImage imageNamed:@"uncheck.png"]){
         if ([label.text isEqualToString:@""]) {
        [cb9 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
         label.text=label9.text;
        }
    }else{
        [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
         label.text=@"";
    }
    
    
    }else if(btn.tag == 10){
      
        if(cb10.currentImage==[UIImage imageNamed:@"uncheck.png"]){
             if ([label.text isEqualToString:@""]) {
            [cb10 setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
             label.text=label10.text;
           } 
        }else{
            [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
             label.text=@"";
        }
        
    }else{
        
    }
    
    
    
    
}
-(IBAction)CloseBtn:(id)sender
{
    if (!subView.isHidden)
    {
        subView.hidden = YES;
    }
    else if (!settingsView.isHidden)
    {
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
                
        for (int i = 0; i <= 6; i++)
        {
            NSDate *newDate = [[_reminderDatePicker date] dateByAddingTimeInterval:(60 * 60 * 24 * i)];
            
            NSDateComponents *newDateComp = [cal components:NSWeekdayCalendarUnit fromDate:newDate];
            
            if (_weekSegmentControl.selectedSegmentIndex + 1 == [newDateComp weekday])
            {
                notif.fireDate = newDate;
                notif.repeatInterval = NSWeekdayCalendarUnit;
            }
        }
        
        notif.timeZone = [NSTimeZone defaultTimeZone];
        
        notif.alertBody = @"Did you forget something?";
        notif.alertAction = @"Show me";
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.applicationIconBadgeNumber = 1;
        notif.userInfo = [NSDictionary dictionaryWithObject:@"Reminder" forKey:@"Type"];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        [notif release];
        
        settingsView.hidden = YES;
    }
}

-(IBAction)averagevalue
{
    int box1=[tf1.text intValue];
    NSLog(@"%d",box1);
     int box2=[tf2.text intValue];
   int box3=[tf3.text intValue];
   int box4=[tf4.text intValue];
    int box5=[tf5.text intValue];
     int box6=[tf6.text intValue];
    int box7=[tf7.text intValue];
    int box8=[tf8.text intValue];
   int box9=[tf9.text intValue];
    int box10=[tf10.text intValue];
    
    float sumValue=box1+box2+box3+box4+box5+box6+box7+box8+box9+box10;
    float avgValue=sumValue/10;
     //NSLog(@"%.1f",avgValue);
    NSString *str=[NSString stringWithFormat: @"%.1f", avgValue];
    [averageBt setTitle:str forState:UIControlStateNormal];
    
}

-(IBAction)settingsbutton:(id)sender
{
    [self.view bringSubviewToFront:settingsView];
    
    if (_reminderOnButton.enabled && _reminderOffButton.enabled)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Reminder"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    settingsView.hidden = NO;
    subView.hidden = YES;
    
    [_reminderDatePicker setDate:[NSDate date]];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Reminder"])
    {
        _reminderOnButton.enabled = NO;
        _reminderOffButton.enabled = YES;
        
        _reminderDatePicker.enabled = YES;
        
        _weekSegmentControl.enabled = YES;
    }
    else
    {
        _reminderOnButton.enabled = NO;
        _reminderOffButton.enabled = YES;
        
        _reminderDatePicker.enabled = NO;
        
        _weekSegmentControl.enabled = NO;
    }
    
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
}

-(IBAction)SaveBtn:(id)sender
{
    
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
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        int rows = 0;
        
        NSString *sql = [NSString stringWithFormat: @"SELECT COUNT(*) FROM EXERCISE7 WHERE date='%@'", str];
        
        const char *query_stmt = [sql UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                rows = sqlite3_column_int(statement, 0);
            }
        }
        
        NSString *insertSQL;
        
        if (rows == 0)
        {
            insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE7(date,omrade,aktivitet,average,familj,vanner,karlek,arbete,ekonomi,kost,motion,vila,fritid,somn) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\" ,\"%@\")", str, label.text,textview.text,averageBt.currentTitle, tf1.text, tf2.text, tf3.text, tf4.text, tf5.text, tf6.text, tf7.text, tf8.text, tf9.text, tf10.text];
        }
        else
        {
            insertSQL = [NSString stringWithFormat: @"UPDATE EXERCISE7 SET date='%@', omrade='%@',aktivitet='%@',average='%@',familj='%@',vanner='%@',karlek='%@',arbete='%@',ekonomi='%@',kost='%@',motion='%@',vila='%@',fritid='%@',somn='%@' WHERE date='%@'", str, label.text,textview.text,averageBt.currentTitle, tf1.text, tf2.text, tf3.text, tf4.text, tf5.text, tf6.text, tf7.text, tf8.text, tf9.text, tf10.text, str];
        }
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
//            label.text=@"";
//            textview.text=@"";
//       [averageBt setTitle:@"" forState:UIControlStateNormal];
//            tf1.text=@"";
//            tf2.text=@"";
//            tf3.text=@"";  tf4.text=@"";
//            tf5.text=@"";
//            tf6.text=@"";
//            tf7.text=@"";
//            tf8.text=@"";
//            tf9.text=@"";
//            tf10.text=@"";
            if (rows == 0)
            {
                UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Form Saved Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
                [insertAlert show];
            }
            else
            {
                UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Form Updated Successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
                [insertAlert show];
            }
            
            dateOfCurrentItem = [[NSString alloc] initWithString:str];
            
        } else {
            NSLog(@"no");
            UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Form Update/Save Failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            [insertAlert show];
        }
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }

}
-(IBAction)NewBtn:(id)sender
{
//    if([label.text isEqualToString:@""] && [textview.text isEqualToString:@""] )
//    {
//        
//    }
//    else
//    {
      UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Du har inte sparat ditt formulär, är du säker på att du vill fortsätta?"
                                        delegate:self
                               cancelButtonTitle:@"Avbryt"
                               otherButtonTitles:@"Fortsätt utan att spara", nil];
        alert.tag = 1;
        
        [alert show];
        [alert release];
//    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"ok");
    
        if (buttonIndex == 1 && alertView.tag == 1)
        {
            NSLog(@"new form");
            label.text=@"";
            textview.text=@"";
            tf1.text=@"";
              tf2.text=@"";
              tf3.text=@"";  tf4.text=@"";
              tf5.text=@"";
              tf6.text=@"";
              tf7.text=@"";
              tf8.text=@"";
              tf9.text=@"";
              tf10.text=@"";
               [averageBt setTitle:@"" forState:UIControlStateNormal];
            dateOfCurrentItem = nil;
            
        }
        else if (buttonIndex == 1 && alertView.tag == 2)
        {
            sqlite3_stmt    *statement;
            if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
                
                NSLog(@"Date of Item to be delete = %@", dateOfCurrentItem);
                NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE7 WHERE date='%@'", dateOfCurrentItem];
                
                const char *del_stmt = [sql UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    NSLog(@"Deleted");
                    dateOfCurrentItem = nil;
                    [self updateCurrentItem];
                }
                
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
            }
        }
}
-(IBAction)listofvalues:(id)sender
{
    int rows = 0;
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    // const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK)
    {
        
        NSString *sql = [NSString stringWithFormat: @"SELECT COUNT(*) FROM EXERCISE7"];
        
        const char *query_stmt = [sql UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                rows = sqlite3_column_int(statement, 0);
            }
        }
        
        NSLog(@"SQLite Rows: %i", rows);
        
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }
    
    if (rows > 0)
    {
        tableImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, scrollView.contentSize.height - 280, 320, 280)] autorelease];
        [tableImageView setImage:[UIImage imageNamed:@"scrollbottom.png"]];
//        lok = [[ListOfKompass alloc]initWithNibName:@"ListOfKompass" bundle:nil];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            lok = [[ListOfKompass alloc]initWithNibName:@"ListOfKompass" bundle:nil];
        }else
        {
            lok = [[ListOfKompass alloc]initWithNibName:@"ListOfKompass_iPad" bundle:nil];
        }
        
        lok.delegate = self;
        //    [self.navigationController pushViewController:lok animated:YES];
//        lok.tableView.layer.cornerRadius = 10;
//        lok.tableView.layer.borderColor = [UIColor blueColor].CGColor;
//        lok.tableView.layer.borderWidth = 3;
        
        lok.tableView.frame = CGRectMake(10, tableImageView.frame.origin.y + 10, 300, 210);
        
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.frame = CGRectMake(30, tableImageView.frame.origin.y + 230, 260, 31);
        [closeButton setBackgroundImage:[UIImage imageNamed:@"blargebutton.png"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(removeTableSubviews) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTitle:@"Avbryt" forState:UIControlStateNormal];
        closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//        [self.view addSubview:lok.tableView];
        [self.view addSubview:tableImageView];
        [self.view addSubview:lok.tableView];
        [self.view addSubview:closeButton];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"There are no saved entries."
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)removeTableSubviews
{
    [closeButton removeFromSuperview];
    [lok.tableView removeFromSuperview];
    [tableImageView removeFromSuperview];
}

- (void)didSelectDate:(NSString *)date
{
    dateOfCurrentItem = [[NSString alloc] initWithString:date];
    NSLog(@"Date of Selected Item = %@", dateOfCurrentItem);
    [self updateCurrentItem];
    [lok.tableView removeFromSuperview];
    [closeButton removeFromSuperview];
    [lok.tableView removeFromSuperview];
    [tableImageView removeFromSuperview];
    [lok release];
    NSLog(@"CHECKING...");
    NSLog(@"CHECKING ITEM = %@", dateOfCurrentItem);
}

-(IBAction)Increase:(id)sender
{
     UIButton *btn = (UIButton *)sender;
    if(btn.tag==1){
        int box1=[tf1.text intValue];
        if(box1 != 10){
            box1++;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf1.text=str;
            NSLog(@"%@",tf1.text);
        }
      
    }
else if(btn.tag==2){
    int box1=[tf2.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf2.text=str;
        NSLog(@"%@",tf2.text);
    }
}
else if(btn.tag==3){
    int box1=[tf3.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf3.text=str;
        NSLog(@"%@",tf3.text);
    }
}
else if(btn.tag==4){
    int box1=[tf4.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf4.text=str;
        NSLog(@"%@",tf4.text);
    }
}
else if(btn.tag==5){
    int box1=[tf5.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf5.text=str;
        NSLog(@"%@",tf5.text);
    }
}
else if(btn.tag==6){
    int box1=[tf6.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf6.text=str;
        NSLog(@"%@",tf6.text);
    }
}
else if(btn.tag==7){
    int box1=[tf7.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf7.text=str;
        NSLog(@"%@",tf7.text);
    }
}
else if(btn.tag==8){
    int box1=[tf8.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf8.text=str;
        NSLog(@"%@",tf8.text);
    }
}
else if(btn.tag==9){
    int box1=[tf9.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf9.text=str;
        NSLog(@"%@",tf9.text);
    }
}
else if(btn.tag==10){
    int box1=[tf10.text intValue];
    if(box1 != 10){
        box1++;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf10.text=str;
        NSLog(@"%@",tf10.text);
    }
}
    
    [self averagevalue];
}


-(IBAction)Decrease:(id)sender{
     UIButton *btn = (UIButton *)sender;
    if(btn.tag==1){
        int box1=[tf1.text intValue];
          if(box1 != 1){
        box1--;
        NSString *str=[NSString stringWithFormat: @"%d", box1];
        NSLog(@"%@",str);
        tf1.text=str;
        NSLog(@"%@",tf1.text);
          }
    }
    else if(btn.tag==2){
        int box1=[tf2.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf2.text=str;
            NSLog(@"%@",tf2.text);
        }
    }
    else if(btn.tag==3){
        int box1=[tf3.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf3.text=str;
            NSLog(@"%@",tf3.text);
        }
    }
    else if(btn.tag==4){
        int box1=[tf4.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf4.text=str;
            NSLog(@"%@",tf4.text);
        }
    }
    else if(btn.tag==5){
        int box1=[tf5.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf5.text=str;
            NSLog(@"%@",tf5.text);
        }
    }
    else if(btn.tag==6){
        int box1=[tf6.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf6.text=str;
            NSLog(@"%@",tf6.text);
        }
    }
    else if(btn.tag==7){
        int box1=[tf7.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf7.text=str;
            NSLog(@"%@",tf7.text);
        }
    }
    else if(btn.tag==8){
        int box1=[tf8.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf8.text=str;
            NSLog(@"%@",tf8.text);
        }
    }
    else if(btn.tag==9){
        int box1=[tf9.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf9.text=str;
            NSLog(@"%@",tf9.text);
        }
    }
    else if(btn.tag==10){
        int box1=[tf10.text intValue];
        if(box1 != 1){
            box1--;
            NSString *str=[NSString stringWithFormat: @"%d", box1];
            NSLog(@"%@",str);
            tf10.text=str;
            NSLog(@"%@",tf10.text);
        }
    }
    [self averagevalue];
}

- (IBAction)deleteEntry:(id)sender
{
    if (dateOfCurrentItem)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Är du säker på att du vill radera formuläret?"
                                                     delegate:self
                                            cancelButtonTitle:@"Avbryt"
                                            otherButtonTitles:@"Radera", nil];
        alert.tag = 2;
        [alert show];
        [alert release];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"This is not a saved entry to delete. This is a fresh page."
                                                     delegate:self
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (IBAction)generateGraph:(id)sender
{
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    NSString *olderDate = nil;
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
//    sqlite3 *exerciseDB;
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt  *statement;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT date FROM EXERCISE7 ORDER BY id DESC"
                              ];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* date = (char*) sqlite3_column_text(statement,0);
                
                if (date != NULL)
                {
                    NSLog(@"Date OF CURRENT ITEM = %@", dateOfCurrentItem);
                    NSDate *presentDate = [formatter dateFromString:dateOfCurrentItem];
                    NSDate *oldDate = [formatter dateFromString:[NSString stringWithUTF8String:date]];
                    
                    if ([presentDate compare:oldDate] == NSOrderedDescending)
                    {
                        olderDate = [[[NSString alloc] initWithUTF8String:date] autorelease];
                        break;
                    }
                }
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    
    if (dateOfCurrentItem && olderDate)
    {
        DinKompass *dinKom;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            dinKom = [[DinKompass alloc]initWithNibName:@"DinKompass" bundle:nil];
        }else
        {
            dinKom = [[DinKompass alloc]initWithNibName:@"DinKompass_iPad" bundle:nil];
        }
        
        dinKom.presentDate = [[NSString alloc] initWithString:dateOfCurrentItem];
        dinKom.oldDate = [[NSString alloc] initWithString:olderDate];
        dinKom.isComparisonGraph = YES;
        //    dinKom.delegate = self;
        [self.navigationController pushViewController:dinKom animated:YES];
    }
    else
    {
        UIAlertView *insertAlert = [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select one form to generate Kompass." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
        [insertAlert show];
    }
}

- (IBAction)reminderOnOff:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        _reminderOnButton.enabled = NO;
        _reminderOffButton.enabled = YES;
        
        _reminderDatePicker.enabled = YES;
        
        _weekSegmentControl.enabled = YES;
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Reminder"];
    }
    else
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        _reminderOffButton.enabled = NO;
        _reminderOnButton.enabled = YES;
        
        _reminderDatePicker.enabled = NO;
        
        _weekSegmentControl.enabled = NO;
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Reminder"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index {
//	// 1 - Define label text style
//	static CPTMutableTextStyle *labelText = nil;
//	if (!labelText) {
//		labelText= [[CPTMutableTextStyle alloc] init];
//		labelText.color = [CPTColor grayColor];
//	}
//	// 2 - Calculate portfolio total value
//	NSDecimalNumber *portfolioSum = [NSDecimalNumber zero];
//	for (NSDecimalNumber *price in [[CPDStockPriceStore sharedInstance] dailyPortfolioPrices]) {
//		portfolioSum = [portfolioSum decimalNumberByAdding:price];
//	}
//	// 3 - Calculate percentage value
//	NSDecimalNumber *price = [[[CPDStockPriceStore sharedInstance] dailyPortfolioPrices] objectAtIndex:index];
//	NSDecimalNumber *percent = [price decimalNumberByDividingBy:portfolioSum];
//	// 4 - Set up display label
//	NSString *labelValue = [NSString stringWithFormat:@"$%0.2f USD (%0.1f %%)", [price floatValue], ([percent floatValue] * 100.0f)];
//	// 5 - Create and return layer with label text
//	return [[CPTTextLayer alloc] initWithText:labelValue style:labelText];
//}
//
//-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index {
//	if (index < [[[CPDStockPriceStore sharedInstance] tickerSymbols] count]) {
//		return [[[CPDStockPriceStore sharedInstance] tickerSymbols] objectAtIndex:index];
//	}
//	return @"N/A";
//}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
//    
//    if ([title isEqualToString:@"Delete"]) {
//        NSLog(@"Delete.");
//        sqlite3_stmt    *statement;
//        if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
//            
//            NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE7 WHERE date='%@'", dateoflivskompass];
//            
//            const char *del_stmt = [sql UTF8String];
//            
//            sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
//            if (sqlite3_step(statement) == SQLITE_ROW) {
//                
//                NSLog(@"sss");
//            }
//            
//            sqlite3_finalize(statement);
//            sqlite3_close(exerciseDB);
//            
//            
//        }
//        
//    }
//}

- (void)dealloc {
    [scrollView release];
    if (lok) {
        [lok release];
    }
    if (dateOfCurrentItem) {
        [dateOfCurrentItem release];
    }
    [settingsView release];
    [subView release];
    [_reminderOnButton release];
    [_reminderOffButton release];
    [_weekSegmentControl release];
    [_reminderDatePicker release];
    [super dealloc];
}
@end
