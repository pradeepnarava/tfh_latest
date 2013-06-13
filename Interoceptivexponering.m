//
//  Interoceptivexponering.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/6/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Interoceptivexponering.h"
#import "MTPopupWindow.h"
int d=0;
int s;
@interface Interoceptivexponering ()
@property (nonatomic, assign) int seconds;
@property (nonatomic, assign) int minutes;
@property (nonatomic, assign) int Reseconds;
@property (nonatomic, assign) int Reminutes;
@property (nonatomic, assign) NSString *scb;

@end

@implementation Interoceptivexponering
@synthesize ovning,egen,slider,tblView,prc,scb,text2,text1,tabeldates,listexercise5,list_exercise5,listofovningars1,listof_sliderValue1,list_egen1;
@synthesize secondsDisplay;
@synthesize minutesDisplay;
@synthesize secondsTimer;
@synthesize seconds;
@synthesize minutes;
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
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
          instr1=textView.text;
        if(listofovningars1.count>0){
            [list_egen1 insertObject:textView.text atIndex:s];
        }else{
      
        [list_egen addObject:instr1];
           NSLog(@"instr1%@",instr1);
        }
    }else{
             NSLog(@"%@",textView.text);
    }
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Interoceptiv exponering";
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 720)];
    scroll1.scrollEnabled = YES;
    [scroll1 setContentSize:CGSizeMake(320, 1010)];
    scb=@"";
    inStr=[[NSString alloc]init];
    inStr=@"0";
    instr1=[[NSString alloc]init];
    str1=[[NSMutableString alloc]init];
    str2=[[NSMutableString alloc]init];
    str3=[[NSMutableString alloc]init];
    str11=[[NSMutableString alloc]init];
    str21=[[NSMutableString alloc]init];
    str31=[[NSMutableString alloc]init];
    
    datesView.hidden=YES;
    listofovningars=[[NSMutableArray alloc]init];
    listof_sliderValue=[[NSMutableArray alloc]init];
    listofovningars1=[[NSMutableArray alloc]init];
    listof_sliderValue1=[[NSMutableArray alloc]init];
    listexercise5=[[NSMutableArray alloc]init];
    list_exercise5=[[NSMutableArray alloc]init];
    list_egen=[[NSMutableArray alloc]init];
      list_egen1=[[NSMutableArray alloc]init];
   [list_exercise5 addObject:@"Null"];
    raderaButton.hidden=YES;
    pupview.hidden=YES;
    timerview.hidden=YES;
    egen.hidden=YES;
    prc.hidden=YES;
    slider.hidden=YES;
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
    
   
		const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE5 (ID INTEGER PRIMARY KEY AUTOINCREMENT, DATE TEXT,OVNINGAR TEXT,EGEN TEXT, ANGEST TEXT)";
            
            if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create database");
            }
            
            sqlite3_close(exerciseDB);
            
        } else {
            //status.text = @"Failed to open/create database";
        }
    
    
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
   // scroll.scrollEnabled=NO;
    if ([inStr isEqualToString:@"0"]) {
         [listof_sliderValue insertObject:inStr atIndex:0];
    }else{
        if(listofovningars1.count>0){
            [listof_sliderValue1 insertObject:inStr atIndex:s];
        }else{
       [listof_sliderValue insertObject:inStr atIndex:listofovningars.count-1];
        }
    }
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
    
    //[MTPopupWindow showWindowWithHTMLFile:@"Beteendeaktivering.html" insideView:self.view];
}
- (IBAction)closeBtn:(id)sender
{
    [cb1 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    [cb2 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    [cb3 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    [cb4 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    [cb5 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    [cb6 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    [cb7 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    [cb8 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    [cb9 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    [cb10 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
    pupview.hidden=YES;
 //   scroll.scrollEnabled=YES;
    if(listofovningars1.count>0){
            [listofovningars1 insertObject:ovning.text atIndex:s];
    }else{
       [listofovningars addObject:ovning.text];
    }
     // NSLog(@"%@",listof_sliderValue);
    // 
      [self.tblView reloadData];
    egen.hidden=NO;
    slider.hidden=NO;
    prc.hidden=NO;
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
    scroll.scrollEnabled=YES;
    //ovning.text=scb;
    egen.hidden=NO;
    slider.hidden=NO;
    prc.hidden=NO;
    text1.hidden=NO;
     text2.hidden=NO;
    [self.secondsTimer invalidate];
    self.secondsTimer= nil;
    secondsDisplay.text=@"00";
    minutesDisplay.text=@"00";
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
        if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
            NSLog(@"%@",scb);
          
                [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
                ovning.text=@"Skaka huvudet (30 sek)";
            
                NSLog(@"%@",  ovning.text);
                self.seconds=30;
                 self.minutes=0;
         
        
            
        }else{
            [btn
             setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",  ovning.text);
            self.seconds=00;
            self.minutes=00;
        }
              
    }else if(btn.tag == 2){
         if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
           
        [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
       ovning.text=@"Tajta kläder (60 min)";
        NSLog(@"%@",ovning.text);
                self.minutes=00;
                self.seconds=60;
         
         }else{
             [btn
              setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
             ovning.text=@"";
             NSLog(@"%@",ovning.text);
             self.seconds=00;
             self.minutes=00;
         }

    }else if(btn.tag == 3){
        if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
         
        [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
        ovning.text=@"Huvudet mellan benen (90 sek)";
        NSLog(@"%@",ovning.text);
                self.seconds=30;
                self.minutes=1;
           
        }else{
            [btn
             setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",ovning.text);
            self.seconds=00;
             self.minutes=00;
        }

    }
    
    else if(btn.tag == 4){
            if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
        
        [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
      ovning.text=@"Spring på stället (2 min)";
        NSLog(@"%@",ovning.text);
                self.minutes=1;
                self.seconds=60;
           
            }else{
                [btn
                 setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
                ovning.text=@"";
                NSLog(@"%@",ovning.text);
                self.seconds=00;
                self.minutes=00;
            }

    }else if(btn.tag == 5){
           if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
          
        [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
       ovning.text=@"Fullständig kroppsspänning (1 min)";
        NSLog(@"%@",ovning.text);
                self.minutes=00;
                self.seconds=60;
                
          
           }else{
               [btn
                setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
               ovning.text=@"";
               NSLog(@"%@",ovning.text);
               self.seconds=00;
               self.minutes=00;
           }

    }else if(btn.tag == 6){
        if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
       
        [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
       ovning.text=@"Hålla andan (30 sek)";
        NSLog(@"%@",ovning.text);
                self.seconds=30;
                self.minutes=00;
          
        }else{
            [btn
             setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",ovning.text);
            self.seconds=00;
            self.minutes=00;        }
    }else if(btn.tag == 7){
         if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
        
        [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
        ovning.text=@"Hyperventilera (90 sek)";
        NSLog(@"%@",ovning.text);
                self.seconds=30;
                self.minutes=1;
     
         }else{
             [btn
              setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
             ovning.text=@"";
             NSLog(@"%@",ovning.text);
             self.seconds=00;
              self.minutes=00;
         }
    }else if(btn.tag == 8){
          if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
                  [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
     ovning.text=@"Svälj snabbt (fem gånger)";
              self.seconds=00;
              self.minutes=00;
        NSLog(@"%@",ovning.text);
      
          }else{
              [btn
               setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
              ovning.text=@"";
              NSLog(@"%@",ovning.text);
              self.seconds=00;
              self.minutes=00;
          }
    }else if(btn.tag == 9){
        if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
         
        [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
        ovning.text=@"Drick kaffe";
            self.seconds=00;
            self.minutes=00;
        NSLog(@"%@",ovning.text);
    
        }else{
            [btn
             setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",ovning.text);
            self.seconds=00;
            self.minutes=00;
        }
    }else if(btn.tag == 10){
        if(btn.currentImage==[UIImage imageNamed:@"unchecked.png"]){
            
        [btn setImage:[UIImage imageNamed:@"checked.png"]  forState:UIControlStateNormal];
       ovning.text=@"Vatten i munnen (2 min)";
        NSLog(@"%@",ovning.text);
                self.minutes=1;
                 self.seconds=60;
      
        }else{
            [btn
             setImage:[UIImage imageNamed:@"unchecked.png"]  forState:UIControlStateNormal];
            ovning.text=@"";
            NSLog(@"%@",ovning.text);
            self.seconds=00;
            self.minutes=00;
        }
    }else{
        
    }




}

-(IBAction)updateside:(id)sender
{if([egen.text isEqualToString:@""]){
    
}else{
  
    slider = (UISlider*)sender;
    NSLog(@"Slider Value: %.1f", [slider value]);
    NSNumber *myNumber = [NSNumber numberWithDouble: [slider value]];
    NSInteger myInt = [myNumber intValue];
    inStr = [NSString stringWithFormat:@"%d", myInt];
  //  inStr = [inStr stringByAppendingString:@" %"];
    prc.text=inStr;
    NSLog(@"inStr Value: %@", inStr);
     [cellButton setBackgroundImage:[UIImage imageNamed:@"listbuttons.png"] forState:UIControlStateNormal];
     [cellButton setTitle:inStr forState:UIControlStateNormal];
    // [self.tblView reloadData];
}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 40;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows;
	
	if(tableView == tabeldates) rows = [listexercise5 count];
	if(tableView == tblView) rows = [listofovningars count];
	
	return rows;
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
    
    
    if(tableView==tblView){
        if(listofovningars.count>0){
    NSString *str=[NSString stringWithFormat:@"%@",[listofovningars objectAtIndex:row]];
   cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:12.0];
    cell.textLabel.text = str;
    cellButton = [[UIButton alloc]init];
    [cellButton addTarget:self action:@selector(ClicktableButton:)forControlEvents:UIControlEventTouchDown];
    [cellButton setBackgroundImage:[UIImage imageNamed:@"listbuttons.png"] forState:UIControlStateNormal];
        NSLog(@"slidervalue%@",[listof_sliderValue objectAtIndex:row]);
    [cellButton setTitle:[listof_sliderValue objectAtIndex:row] forState:UIControlStateNormal];
    cellButton.frame = CGRectMake(220, 5, 60, 30);
    [cell addSubview:cellButton];
    [cellButton release];
        }else{
            NSString *str=[NSString stringWithFormat:@"%@",[listofovningars1 objectAtIndex:row]];
            cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:12.0];
            cell.textLabel.text = str;
            cellButton = [[UIButton alloc]init];
            [cellButton addTarget:self action:@selector(ClicktableButton:)forControlEvents:UIControlEventTouchDown];
            [cellButton setBackgroundImage:[UIImage imageNamed:@"listbuttons.png"] forState:UIControlStateNormal];
            NSLog(@"slidervalue%@",[listof_sliderValue1 objectAtIndex:row]);
            [cellButton setTitle:[listof_sliderValue1 objectAtIndex:row] forState:UIControlStateNormal];
            cellButton.frame = CGRectMake(220, 5, 60, 30);
            [cell addSubview:cellButton];
            [cellButton release];
        }
     
    }else{
       
        cell.textLabel.text = [listexercise5 objectAtIndex:row];
    }
    // Deciding which data to put into this particular cell.
    // If it the first row, the data input will be "Data1" from the array.
       return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==tblView){
    cell.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"cellbg1.png"]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Upon selecting an event, create an EKEventViewController to display the event.
    if(tableView==tabeldates){
	NSDictionary *dictionary = [self.listexercise5 objectAtIndex:indexPath.row];
    NSLog(@"%@",dictionary);
        d=indexPath.row;
        [list_exercise5 removeAllObjects];
      
  SelectedDate=[NSString stringWithFormat:@"%@", dictionary];
   NSLog(@"%@",SelectedDate);
        [list_exercise5 addObject:SelectedDate];
        raderaButton.hidden=NO;
        if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
            
            NSString *sql = [NSString stringWithFormat: @"SELECT * FROM EXERCISE5 WHERE date='%@'", SelectedDate];
            
            const char *del_stmt = [sql UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* c1 = (char*) sqlite3_column_text(statement,2);
                NSString *tmp1;
                if (c1 != NULL){
                    tmp1 = [NSString stringWithUTF8String:c1];
                    NSLog(@"value form db :%@",tmp1);
                   
                    NSArray *array = [tmp1 componentsSeparatedByString:@","];
                    
                    for (int i=0; i < [array count]; i++) {
                        NSString *str4 = [array objectAtIndex:i];
                        if([str4 isEqualToString:@""]){
                            
                        }else{
                            [listofovningars addObject:str4];
                           // [listofovningars addObject:str4];
                        }
                    }
                                    // NSLog(@"%@",[listofovningars1 objectAtIndex:0]);
                }
                char* c2 = (char*) sqlite3_column_text(statement,3);
                NSString *tmp2;
                if (c2 != NULL){
                    tmp2 = [NSString stringWithUTF8String:c2];
                    NSLog(@"value form db :%@",tmp2);
                    NSArray *array = [tmp2 componentsSeparatedByString:@","];
                    
                    for (int i=0; i < [array count]; i++) {
                        NSString *str4 = [array objectAtIndex:i];
                        if([str4 isEqualToString:@""]){
                            
                        }else{
                        [list_egen addObject:str4];
                            //  [list_egen addObject:str4];
                        }
                    }
                  //  NSLog(@"%@",[list_egen1 objectAtIndex:0]);

                }
                
                char* c3 = (char*) sqlite3_column_text(statement,4);
                NSString *tmp3;
                if (c3!= NULL){
                    tmp3= [NSString stringWithUTF8String:c3];
                    NSLog(@"value form db :%@",tmp3);
                    NSArray *array = [tmp3 componentsSeparatedByString:@","];
                    
                    for (int i=0; i < [array count]; i++) {
                        NSString *str4 = [array objectAtIndex:i];
                        if([str4 isEqualToString:@""]){
                            
                        }else{
                        [listof_sliderValue addObject:str4];
                            //[listof_sliderValue addObject:str4];
                        }
                    }
                  //  NSLog(@"%@",[listof_sliderValue1 objectAtIndex:0]);

                }
                
            
                 [tblView reloadData];
            }
           

            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
            
        }
    }else{
        s=indexPath.row;
        NSLog(@"%u",s);
        egen.hidden=NO;
        prc.hidden=NO;
        slider.hidden=NO;
        NSLog(@"%@",[listofovningars objectAtIndex:0]);
        ovning.text= [listofovningars objectAtIndex:indexPath.row];
        egen.text=[list_egen objectAtIndex:indexPath.row];
        prc.text=[listof_sliderValue objectAtIndex:indexPath.row];
    }
   }

-(IBAction)SparaButton:(id)sender{
   

    
    NSDate* date = [NSDate date];
    
    //Create the dateformatter object
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    
    //Set the required date format
    
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    //Get the string date
    
    NSString* str = [formatter stringFromDate:date];
    
    NSLog(@"date%@",str);
    
  
        NSLog(@"yes");
    
       raderaButton.hidden=YES;
    
    
    
    if([ovning.text isEqualToString:@""] &&[egen.text isEqualToString:@""] &&[prc.text isEqualToString:@""] ){
        
        
    }
    
    else{
        NSLog(@"yes");
         [listof_sliderValue insertObject:inStr atIndex:listofovningars.count-1];
        for(int i=0;i<listofovningars.count;i++){
            //
            [str1 appendString :[listofovningars objectAtIndex:i]];
            [str1 appendString:@","];
            NSLog(@"str1%@",str1);
            // str2=[[NSString alloc]init];
            [str2 appendString:[listof_sliderValue objectAtIndex:i]];
            [str2 appendString:@","];
            NSLog(@"str2%@",str2);
            // str3=[[NSString alloc]init];
            [str3 appendString:[list_egen objectAtIndex:i]];
            [str3 appendString:@","];
            NSLog(@"str3%@",str3);
        }

        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
        {
           
            if([[list_exercise5 objectAtIndex:0] isEqualToString:@"Null"]){
                if([cellButton.currentTitle isEqualToString:@""]){
                    
                }else{
            NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE5 (date,ovningar,egen,angest) VALUES (\"%@\", \"%@\", \"%@\" ,\"%@\")", str, str1,str3, str2 ];
            
            const char *insert_stmt = [insertSQL UTF8String];
            
            sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                [listofovningars removeAllObjects];
               
                ovning.text=@"";
                egen.text=@"";
                prc.text=@"";
                slider.value=0;
              //  [listofovningars removeAllObjects];
                [list_egen removeAllObjects];
                [listof_sliderValue removeAllObjects];
                [tblView reloadData];
                //egen.hidden=YES;
             //   prc.hidden=YES;
              //  slider.hidden=YES;
              //  text1.hidden=YES;
               // text2.hidden=YES;
            } else {
                NSLog(@"no");
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(exerciseDB);
                }
            }else{
                  [listof_sliderValue1 insertObject:inStr atIndex:s];
                for(int i=0;i<listofovningars1.count;i++){
                    //
                
                    [str11 appendString :[listofovningars1 objectAtIndex:i]];
                    [str11 appendString:@","];
                    NSLog(@"str1%@",str1);
                    // str2=[[NSString alloc]init];
                    [str21 appendString:[listof_sliderValue1 objectAtIndex:i]];
                    [str21 appendString:@","];
                    NSLog(@"str2%@",str2);
                    // str3=[[NSString alloc]init];
                    [str31 appendString:[list_egen1 objectAtIndex:i]];
                    [str31 appendString:@","];
                    NSLog(@"str3%@",str3);
                }

                NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISE5 SET ovningar='%@', egen='%@', angest='%@' WHERE date='%@' ", str11,str31, str21 , [listexercise5 objectAtIndex:d]];
                const char *del_stmt = [query UTF8String];
                
                if (sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL)==SQLITE_OK){
                    if(SQLITE_DONE != sqlite3_step(statement))
                        NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
                    NSLog(@"sss");
                   ovning.text=@"";
                    egen.text=@""; prc.text=@"";
                    slider.value=0;
                    [list_exercise5 removeAllObjects];
                    d=0;
                    [list_exercise5 addObject:@"Null"];
                }
                
                
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
                
                
                
     
            }

            }
    
        }



}


-(IBAction)newcolm:(id)sender{
    if([ovning.text isEqualToString:@""] &&[egen.text isEqualToString:@""] && [prc.text isEqualToString:@""] ){
        
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
            ovning.text=@"";
            egen.text=@"";
            prc.text=@"";
            slider.value=0;
            [list_exercise5 removeAllObjects];
            d=0;
            [list_exercise5 addObject:@"Null"];
            
        }else{
            
        }
    
}
-(IBAction)CloseButton:(id)sender{
    pupview.hidden=YES;
    scroll.scrollEnabled=YES;
        timerview.hidden = YES;
    datesView.hidden=YES;
    scroll.scrollEnabled=YES;
    [listof_sliderValue removeAllObjects];
    [list_egen removeAllObjects];
    [listofovningars removeAllObjects];
   }
-(IBAction)nextbutton:(id)sender{
    datesView.hidden=NO;
    scroll.scrollEnabled=NO;
    [listexercise5 removeAllObjects];
      [self getlistofDates];
}
-(void)getlistofDates{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT date FROM EXERCISE5 ORDER BY date DESC"
                              ];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"%u",SQLITE_ROW);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char* date = (char*) sqlite3_column_text(statement,0);
                NSString *tmp;
                if (date != NULL){
                    tmp = [NSString stringWithUTF8String:date];
                    NSLog(@"value form db :%@",tmp);
                    [listexercise5 addObject:tmp];
                }
            }
            if (sqlite3_step(statement) != SQLITE_ROW) {
                NSLog(@"%u",listexercise5.count);
                if (listexercise5.count==0) {
                    datesView.hidden = YES;
                    scroll.scrollEnabled=YES;
                }
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    
    [self.tabeldates reloadData];
}
-(IBAction)raderaclick:(id)sender{
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE5 WHERE date='%@'", [listexercise5 objectAtIndex:d]];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"sss");
            
        }
        raderaButton.hidden=YES;
        ovning.text=@"";
        egen.text=@"";
        prc.text=@"";
        slider.value=0;
        [list_exercise5 removeAllObjects];
        d=0;
        [list_exercise5 addObject:@"Null"];
        sqlite3_finalize(statement);
        sqlite3_close(exerciseDB);
        
        
    }
    
    [self.tabeldates reloadData];
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
