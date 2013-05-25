//
//  Interoceptivexponering.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/6/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Interoceptivexponering.h"
#import "MTPopupWindow.h"
@interface Interoceptivexponering ()
@property (nonatomic, assign) int seconds;
@property (nonatomic, assign) int minutes;
@property (nonatomic, assign) int Reseconds;
@property (nonatomic, assign) int Reminutes;
@property (nonatomic, assign) NSString *scb;

@end

@implementation Interoceptivexponering
@synthesize ovning,egen,slider,tblView,prc,scb,text2,text1;
@synthesize secondsDisplay;
@synthesize minutesDisplay;
@synthesize secondsTimer;
@synthesize seconds;
@synthesize minutes;
@synthesize titlelabel,titlelabel1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
   [self.tblView reloadData];
}
-(void)dealloc{
    [super dealloc];
    [timerview release];
    [pupview release];
   
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Interoceptiv exponering";
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 720)];
    scb=@"";
    listofovningars=[[NSMutableArray alloc]init];
    [self.view addSubview:pupview];
    [self.view addSubview:timerview];
    pupview.hidden=YES;
    timerview.hidden=YES;
   // text1.hidden=YES;
   // text2.hidden=YES;
    ovning.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ovninglabelalert:)] autorelease];
    [ovning addGestureRecognizer:tapGesture3];
   
    [ovning release];
    
//    titlelabel.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGesture =
//    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titlelabelalert:)] autorelease];
//    [titlelabel addGestureRecognizer:tapGesture];
    
    titlelabel1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titlelabel1alert:)] autorelease];
    [titlelabel1 addGestureRecognizer:tapGesture2];
    
    //egen.hidden=YES;
  //  slider.hidden=YES;
   // prc.hidden=YES;
    
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
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE5 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,  NEGATIVE TEXT ,OVNINGAR TEXT,EGEN TEXT, ANGEST TEXT)";
            
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
    
   }


-(IBAction)titlelabelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Interoceptivexponering.html" insideView:self.view];
}

-(IBAction)titlelabel1alert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"ovningsbeskrivningar.html" insideView:self.view];
}
- (void) timerFireMethod:(NSTimer *) theTimer
{
    
        if(self.seconds ==0 && self.minutes ==0){
            
        }else{
            self.seconds--;
            if (self.seconds == 0 && self.minutes != 0) {
            self.minutes--;
            self.seconds = 60;
        }
        
    }
    
    self.secondsDisplay.text = [NSString
                                stringWithFormat:@"%d", self.seconds];
    
    self.minutesDisplay.text = [NSString
                                stringWithFormat:@"%d", self.minutes];
}
// (listing continues)


-(IBAction)ovninglabelalert:(id)sender{
//   
    [self.view bringSubviewToFront:pupview];
    pupview.hidden = NO;
    
      
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
    
    //[MTPopupWindow showWindowWithHTMLFile:@"Beteendeaktivering.html" insideView:self.view];
}
- (IBAction)closeBtn:(id)sender
{
    [cb1 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb2 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb3 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb4 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb5 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb6 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb7 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb8 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb9 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    [cb10 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
    pupview.hidden=YES;
    [self.view bringSubviewToFront:timerview];
    timerview.hidden = NO;
    
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
   
    
    self.secondsDisplay.text = [NSString
                                stringWithFormat:@"%d", self.seconds];
    
    self.minutesDisplay.text = [NSString
                                stringWithFormat:@"%d", self.minutes];
    self.Reseconds=self.seconds;
    self.Reminutes=self.minutes;
}
- (IBAction)closetimer:(id)sender{
    timerview.hidden=YES;
    //ovning.text=scb;
    egen.hidden=NO;
    slider.hidden=NO;
    prc.hidden=NO;
    text1.hidden=NO;
     text2.hidden=NO;
}
- (IBAction)starttimer:(id)sender{
    self.secondsTimer = [NSTimer
                         scheduledTimerWithTimeInterval:1.0
                         target:self
                         selector:@selector(timerFireMethod:)
                         userInfo:nil
                         repeats:YES];
}
- (IBAction)Restarttimer:(id)sender{
    [self.secondsTimer invalidate];
    self.secondsTimer= nil;
    self.secondsDisplay.text = [NSString
                                stringWithFormat:@"%d", self.Reseconds];
    
    self.minutesDisplay.text = [NSString
                                stringWithFormat:@"%d", self.Reminutes];
    self.seconds=self.Reseconds;
   self.minutes= self.Reminutes;
    self.secondsTimer = [NSTimer
                         scheduledTimerWithTimeInterval:1.0
                         target:self
                         selector:@selector(timerFireMethod:)
                         userInfo:nil
                         repeats:YES];
}

- (IBAction)stoptimer:(id)sender{
    [self.secondsTimer invalidate];
    self.secondsTimer= nil;
}
-(IBAction)selectedcheckbox:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 1)
    {
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            NSLog(@"%@",scb);
            if ([ovning.text isEqualToString:@""]) {
                [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
                ovning.text=@"Skaka huvudet (30 sek)";
                NSLog(@"%@",  ovning.text);
                self.seconds=30;
                 self.minutes=0;
            }
        
            
        }else{
            [btn
             setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",  ovning.text);
            self.seconds=00;
            self.minutes=00;
        }
              
    }else if(btn.tag == 2){
         if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            if ([ovning.text isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
       ovning.text=@"Tajta kläder (60 min)";
        NSLog(@"%@",ovning.text);
                self.minutes=59;
                self.seconds=60;
            }
         }else{
             [btn
              setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
             ovning.text=@"";
             NSLog(@"%@",ovning.text);
             self.seconds=00;
             self.minutes=00;
         }

    }else if(btn.tag == 3){
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            if ([ovning.text isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
        ovning.text=@"Huvudet mellan benen (90 sek)";
        NSLog(@"%@",ovning.text);
                self.seconds=30;
                self.minutes=1;
            }
        }else{
            [btn
             setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",ovning.text);
            self.seconds=00;
             self.minutes=00;
        }

    }
    
    else if(btn.tag == 4){
            if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            if ([ovning.text isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
      ovning.text=@"Spring på stället (2 min)";
        NSLog(@"%@",ovning.text);
                self.minutes=1;
                self.seconds=60;
            }
            }else{
                [btn
                 setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
                ovning.text=@"";
                NSLog(@"%@",ovning.text);
                self.seconds=00;
                self.minutes=00;
            }

    }else if(btn.tag == 5){
           if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            if ([ovning.text isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
       ovning.text=@"Fullständig kroppsspänning (1 min)";
        NSLog(@"%@",ovning.text);
                self.minutes=0;
                self.seconds=60;
                
            }
           }else{
               [btn
                setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
               ovning.text=@"";
               NSLog(@"%@",ovning.text);
               self.seconds=00;
               self.minutes=00;
           }

    }else if(btn.tag == 6){
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            if ([ovning.text isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
       ovning.text=@"Hålla andan (30 sek)";
        NSLog(@"%@",ovning.text);
                self.seconds=30;
                self.minutes=30;
            }
        }else{
            [btn
             setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",ovning.text);
            self.seconds=00;
            self.minutes=00;        }
    }else if(btn.tag == 7){
         if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            if ([ovning.text isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
        ovning.text=@"Hyperventilera (90 sek)";
        NSLog(@"%@",ovning.text);
                self.seconds=30;
                self.minutes=1;
            }
         }else{
             [btn
              setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
             ovning.text=@"";
             NSLog(@"%@",ovning.text);
             self.seconds=00;
              self.minutes=00;
         }
    }else if(btn.tag == 8){
          if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            if ([ovning.text isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
     ovning.text=@"Svälj snabbt (fem gånger)";
        NSLog(@"%@",ovning.text);
            }
          }else{
              [btn
               setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
              ovning.text=@"";
              NSLog(@"%@",ovning.text);
              self.seconds=00;
              self.minutes=00;
          }
    }else if(btn.tag == 9){
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            if ([ovning.text isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
        ovning.text=@"Drick kaffe";
        NSLog(@"%@",ovning.text);
            }
        }else{
            [btn
             setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",ovning.text);
            self.seconds=00;
            self.minutes=00;
        }
    }else if(btn.tag == 10){
        if(btn.currentImage==[UIImage imageNamed:@"uncheck.png"]){
            if ([ovning.text isEqualToString:@""]) {
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
       ovning.text=@"Vatten i munnen (2 min)";
        NSLog(@"%@",ovning.text);
                self.minutes=1;
                 self.seconds=60;
            }
        }else{
            [btn
             setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",ovning.text);
            self.seconds=00;
            self.minutes=00;
        }
    }else{
        
    }




}

-(IBAction)updateside:(id)sender
{
    slider = (UISlider*)sender;
    NSLog(@"Slider Value: %.1f", [slider value]);
    NSNumber *myNumber = [NSNumber numberWithDouble: [slider value]];
    NSInteger myInt = [myNumber intValue];
    NSString *inStr = [NSString stringWithFormat:@"%d", myInt];
    inStr = [inStr stringByAppendingString:@" %"];
    prc.text=inStr;
    NSLog(@"inStr Value: %@", inStr);
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 30;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listofovningars count];
}

// This will tell your UITableView what data to put in which cells in your table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    // Using a cell identifier will allow your app to reuse cells as they come and go from the screen.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    NSUInteger row = [indexPath row];
    NSString *str=[NSString stringWithFormat:@"%@,%@",@"Övningar ",[listofovningars objectAtIndex:row]];
   cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:12.0];
    cell.textLabel.text = str;
    // Deciding which data to put into this particular cell.
    // If it the first row, the data input will be "Data1" from the array.
       return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Upon selecting an event, create an EKEventViewController to display the event.
	//NSDictionary *dictionary = [self.listexercise1 objectAtIndex:indexPath.row];
    //NSLog(@"%@",dictionary);
   // NSString *SelectedDate=[NSString stringWithFormat:@"%@", dictionary];
   // NSLog(@"%@",SelectedDate);
   // Selectedrow=SelectedDate;
}
-(IBAction)SparaButton:(id)sender{
    
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    
  
        NSLog(@"yes");
        sqlite3_stmt    *statement;
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE5 (date,ovningar,egen,angest) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\")", str, ovning.text,egen.text, prc.text ];
            
            const char *insert_stmt = [insertSQL UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                [listofovningars addObject:ovning.text];

                ovning.text=@"";
                egen.text=@"";
                prc.text=@"";
                slider.value=0;
                [self.tblView reloadData];
                egen.hidden=YES;
                prc.hidden=YES;
                slider.hidden=YES;
                text1.hidden=YES;
                text2.hidden=YES;
            } else {
                NSLog(@"no");
            }
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
        }
        
 
    

    
}


-(IBAction)newcolm:(id)sender{
    if([ovning.text isEqualToString:@""] || [egen.text isEqualToString:@""] || [prc.text isEqualToString:@""] ){
        
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
            egen.hidden=YES;
            prc.hidden=YES;
            slider.hidden=YES;
            text1.hidden=YES;
            text2.hidden=YES;
            
        }else{
            
        }
    
}

- (void)viewDidUnload{
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
