//
//  Dinaomraden.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/11/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Dinaomraden.h"

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
    self.navigationItem.title=@"Dina områden";
    
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
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(settingsbutton:)];
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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE7 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  OMRADE TEXT ,AKTIVITET TEXT,AVERAGE TEXT)";
            
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
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)labelalert:(id)sender{
    [self.view bringSubviewToFront:subView];
    subView.hidden = NO;
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
-(IBAction)selectedcheckbox:(id)sender{
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
-(IBAction)CloseBtn:(id)sender{
    subView.hidden = YES;
    settingsView.hidden=YES;
}
-(IBAction)averagevalue{
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
-(IBAction)settingsbutton:(id)sender{
    [self.view bringSubviewToFront:settingsView];
    settingsView.hidden = NO;
    
    
    
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
}
-(IBAction)SaveBtn:(id)sender{
    
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
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE7(date,omrade,aktivitet,average) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\")", str, label.text,textview.text,averageBt.currentTitle];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
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

            
        } else {
            NSLog(@"no");
        }
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
    }

}
-(IBAction)NewBtn:(id)sender{
    if([label.text isEqualToString:@""] && [textview.text isEqualToString:@""] ){
        
    }
    else{
      UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert message" message:@"Please Enter the text above fields"
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
            
        }else{
            
        }
}
-(IBAction)listofvalues:(id)sender{
    lok=[[ListOfKompass alloc]initWithNibName:@"ListOfKompass" bundle:nil];
    [self.navigationController pushViewController:lok animated:YES];
}

-(IBAction)Increase:(id)sender{
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
   }
@end
