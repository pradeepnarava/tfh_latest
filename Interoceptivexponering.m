//
//  Interoceptivexponering.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/6/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Interoceptivexponering.h"
#import "MTPopupWindow.h"


#define kAlertViewOne 1
#define kAlertViewTwo 2

@interface Interoceptivexponering ()

@property (nonatomic, assign) int seconds;
@property (nonatomic, assign) int minutes;
@property (nonatomic, assign) int Reseconds;
@property (nonatomic, assign) int Reminutes;


@property (nonatomic, assign) NSString *scb;

@property (nonatomic) BOOL isSaved;

@end

@implementation Interoceptivexponering
@synthesize ovning,egen,slider,tblView,prc,scb,listexercise5,list_exercise5,listofovningars1,listof_sliderValue1,list_egen1;
@synthesize secondsDisplay;
@synthesize minutesDisplay;
@synthesize secondsTimer;
@synthesize seconds;
@synthesize minutes;
@synthesize allItems;
@synthesize items;
@synthesize question,anwser,vlues;


//Gopal
@synthesize isSaved;
@synthesize timerQuestionLabel;


int d=0;
int s;
int tagValueForBtn;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
    [timerQuestionLabel release];
    [timerview release];
    [pupview release];
    [ovning release];
}

#pragma mark -- TextViewDelegate Methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    isSaved = YES;
    
    
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


#pragma mark -- ViewLifeCycle Methods 

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Interoceptiv Exponering";
    
    //iPhone ScrollView
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 663)];
    
    //iPad ScrollView
    scroll1.scrollEnabled = YES;
    [scroll1 setContentSize:CGSizeMake(320, 1010)];
    
    question = [[NSString alloc] init];
    anwser   = [[NSString alloc] init];
    vlues    = [[NSString alloc] init];
    allItems = [[NSMutableArray alloc] init];
    items    = [[NSMutableDictionary alloc] init];
    
    
    inStr =[[NSString alloc]init];
    instr1=[[NSString alloc]init];
    str1  =[[NSMutableString alloc]init];
    str2  =[[NSMutableString alloc]init];
    str3  =[[NSMutableString alloc]init];
    str11 =[[NSMutableString alloc]init];
    str21 =[[NSMutableString alloc]init];
    str31 =[[NSMutableString alloc]init];
    
    
    listofovningars=[[NSMutableArray alloc]init];
    listof_sliderValue=[[NSMutableArray alloc]init];
    listofovningars1=[[NSMutableArray alloc]init];
    listof_sliderValue1=[[NSMutableArray alloc]init];
    listexercise5=[[NSMutableArray alloc]init];
    list_exercise5=[[NSMutableArray alloc]init];
    list_egen=[[NSMutableArray alloc]init];
    list_egen1=[[NSMutableArray alloc]init];
    [list_exercise5 addObject:@"Null"];
    
    
    scb=@"";
    inStr=@"00";
    
    pupview.hidden=YES;
    timerview.hidden=YES;
    
    
    UITapGestureRecognizer *tapGesture3 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ovninglabelalert:)] autorelease];
    [ovning addGestureRecognizer:tapGesture3];
    
    
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
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
        NSLog(@"Failed to open/create database");
    }
}




- (void)viewWillAppear:(BOOL)animated {
    [self.tblView reloadData];
}


#pragma mark PopOverViewController

-(IBAction)titlelabelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Interoceptivexponering.html" insideView:self.view];
}

-(IBAction)titlelabel1alert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"ovningsbeskrivningar.html" insideView:self.view];
}



//time Method
- (void)timerFireMethod:(NSTimer *) theTimer
{
    
    if(self.seconds ==0 && self.minutes ==0){
        
    }else{
        self.seconds--;
        if (self.seconds == 0 && self.minutes != 0) {
            self.minutes--;
            self.seconds = 60;
        }
    }
    self.secondsDisplay.text = [NSString stringWithFormat:@"%d", self.seconds];
    
    self.minutesDisplay.text = [NSString stringWithFormat:@"%d", self.minutes];
}


//First Question TapGesture

-(void)ovninglabelalert:(id)sender{
    

    scroll.scrollEnabled=NO;
    pupview.hidden = NO;

    [self.view bringSubviewToFront:pupview];

    
    [UIView beginAnimations:@"curlInView" context:nil];
    
    [UIView setAnimationDuration:3.0];
    
    [UIView commitAnimations];
    
    /*
    if ([inStr isEqualToString:@"0"]) {
        [listof_sliderValue insertObject:inStr atIndex:0];
    }else{
        if(listofovningars1.count>0){
            [listof_sliderValue1 insertObject:inStr atIndex:s];
        }else{
            [listof_sliderValue insertObject:inStr atIndex:listofovningars.count-1];
        }
    }*/
}



//Close Button Clicked

- (IBAction)closeBtn:(id)sender
{
    pupview.hidden=YES;
    
    if (tagValueForBtn == 10 || tagValueForBtn == 11) {
        timerview.hidden = YES;
    }else {
        [self.view bringSubviewToFront:timerview];
        timerview.hidden = NO;
    }
    egen.hidden=NO;
    slider.hidden=NO;
    prc.hidden=NO;
    
    if ([items count] > 0) {
        
        
    }else {
        [items setValue:timerQuestionLabel.text forKey:@"question"];
        [allItems addObject:items];
    }
    /*
    if(listofovningars1.count>0){
        [listofovningars1 insertObject:ovning.text atIndex:s];
    }else{
        [listofovningars addObject:ovning.text];
    }
    */

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


//Close Timer View
- (IBAction)closetimer:(id)sender{
    
    NSLog(@"%@",allItems);
    NSLog(@"%@",[[allItems objectAtIndex:0] valueForKey:@"question"]);
    timerview.hidden=YES;
    scroll.scrollEnabled=YES;
    //ovning.text=scb;
    egen.hidden=NO;
    slider.hidden=NO;
    prc.hidden=NO;
    [self.secondsTimer invalidate];
    self.secondsTimer= nil;
    secondsDisplay.text=@"00";
    minutesDisplay.text=@"00";
}


//Timer Start
- (IBAction)starttimer:(id)sender{
    UIButton *button = (UIButton *)sender;
    button.enabled = NO;
    self.secondsTimer = [NSTimer
                         scheduledTimerWithTimeInterval:1.0
                         target:self
                         selector:@selector(timerFireMethod:)
                         userInfo:nil
                         repeats:YES];
}

//Timer Reset
- (IBAction)Restarttimer:(id)sender {
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

//Timer Stop
- (IBAction)stoptimer:(id)sender{
    [self.secondsTimer invalidate];
    self.secondsTimer= nil;
}



//Popover List View
-(IBAction)selectedcheckbox:(id)sender{
    UIButton *btn = (UIButton *)sender;
    tagValueForBtn = btn.tag;
    NSLog(@"%i",btn.tag);
    
    for (UIButton *radioButton in [pupview  subviews]) {
        if (radioButton.tag != btn.tag && [radioButton isKindOfClass:[UIButton class]] &&  radioButton.tag != 11 && radioButton.tag != 12) {
            [radioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        }
    }
    
    [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
   
    switch (btn.tag) {
        case 1:
            ovning.text=@"Skaka huvudet (30 sek)";
            self.seconds=30;
            self.minutes=00;
            break;
        case 2:
            ovning.text=@"Tajta kläder (60 min)";
            self.minutes=00;
            self.seconds=60;
            break;
        case 3:
            ovning.text=@"Huvudet mellan benen (90 sek)";
            self.minutes=01;
            self.seconds=30;
            break;
        case 4:
            ovning.text=@"Spring på stället (2 min)";
            self.minutes=01;
            self.seconds=60;
            break;
        case 5:
            ovning.text=@"Fullständig kroppsspänning (1 min)";
            self.minutes=00;
            self.seconds=60;
            break;
        case 6:
            ovning.text=@"Hålla andan (30 sek)";
            self.seconds=30;
            self.minutes=00;
            break;
        case 7:
            
            ovning.text=@"Hyperventilera (90 sek)";
            self.minutes=1;
            self.seconds=30;
            break;
        case 8:
            ovning.text=@"Svälj snabbt (fem gånger)";
            break;
        case 9:
            ovning.text=@"Drick kaffe";
            break;
        case 10:
            ovning.text=@"Vatten i munnen (2 min)";
            self.minutes=1;
            self.seconds=60;
            break;
        default:
            break;
    }
    
    timerQuestionLabel.text = ovning.text;
}



-(IBAction)updateside:(id)sender
{
    if([egen.text isEqualToString:@""]){
        NSLog(@"engen Text is : %@",egen.text);
    }else{
        
        slider = (UISlider*)sender;
        NSLog(@"Slider Value: %.1f", [slider value]);
        NSNumber *myNumber = [NSNumber numberWithDouble: [slider value]];
        NSInteger myInt = [myNumber intValue];
        inStr = [NSString stringWithFormat:@"%d", myInt];
        prc.text=inStr;
        NSLog(@"inStr Value: %@", inStr);
        [cellButton setBackgroundImage:[UIImage imageNamed:@"listbuttons.png"] forState:UIControlStateNormal];
        [cellButton setTitle:inStr forState:UIControlStateNormal];
      
    }
}


#pragma mark -- TableView DataSource Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
    
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
    
    if(tableView==tblView){
        if(listofovningars.count>0){
            NSString *str=[NSString stringWithFormat:@"%@",[listofovningars objectAtIndex:row]];
            cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0];
            cell.textLabel.text = str;
            cellButton = [[UIButton alloc]init];
            [cellButton addTarget:self action:@selector(ClicktableButton:)forControlEvents:UIControlEventTouchDown];
            [cellButton setBackgroundImage:[UIImage imageNamed:@"listbuttons.png"] forState:UIControlStateNormal];
            NSLog(@"slidervalue%@",[listof_sliderValue objectAtIndex:row]);
            [cellButton setTitle:[listof_sliderValue objectAtIndex:row] forState:UIControlStateNormal];
            cellButton.frame = CGRectMake(220, 5, 60, 30);
            [cell addSubview:cellButton];
            [cellButton release];
        }else {
            NSLog(@"%@",[listofovningars1 objectAtIndex:row]);
            NSString *str=[NSString stringWithFormat:@"%@",[listofovningars1 objectAtIndex:row]];
            cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0];
            cell.textLabel.textColor = [UIColor blackColor];
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
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Upon selecting an event, create an EKEventViewController to display the event.
    
    s=indexPath.row;
    NSLog(@"%u",s);
    egen.hidden=NO;
    prc.hidden=NO;
    slider.hidden=NO;
    NSLog(@"%@",[listofovningars objectAtIndex:0]);
    ovning.text= [listofovningars objectAtIndex:indexPath.row];
    egen.text=[list_egen objectAtIndex:indexPath.row];
    prc.text=[listof_sliderValue objectAtIndex:indexPath.row];

    pupview.hidden=YES;
    scroll.scrollEnabled=YES;
    timerview.hidden = YES;
    
    scroll.scrollEnabled=YES;
    [listof_sliderValue removeAllObjects];
    [list_egen removeAllObjects];
    [listofovningars removeAllObjects];
}



-(IBAction)SparaButton:(id)sender{
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    
    NSString* str = [formatter stringFromDate:[NSDate date]];
    
    NSLog(@"date%@",str);
    
    if([ovning.text isEqualToString:@""] &&[egen.text isEqualToString:@""] &&[prc.text isEqualToString:@""] ){
        
    }
    else{
        
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
                        NSLog(@"YES");
                        
                    } else {
                        NSLog(@"NO");
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
                    NSLog(@"Updated");
                }
                
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
            }
        }
        
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Sparat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert1 show];
        [alert1 release];
        
    }
}


-(IBAction)newcolm:(id)sender
{
    if([ovning.text isEqualToString:@""] &&[egen.text isEqualToString:@""] && [prc.text isEqualToString:@""] ){
        
    }else{
        if (isSaved == YES) {
            UIAlertView  *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Vill du ta bort all text som du skrivit ner i övningen?"
                                                          delegate:self
                                                 cancelButtonTitle:@"Forsätt"
                                                 otherButtonTitles:@"Avbryt", nil];
            alert.tag=kAlertViewOne;
            [alert show];
            [alert release];
        }
        else {
            ovning.text=@"";
            egen.text=@"";
            prc.text=@"";
            slider.value=0;
            
            [listofovningars removeAllObjects];
            [list_egen removeAllObjects];
            [listof_sliderValue removeAllObjects];
            [tblView reloadData];
            
            
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(alertView.tag  == kAlertViewOne) {
        if (buttonIndex == 0) {
            NSLog(@"new form");
            ovning.text=@"";
            egen.text=@"";
            prc.text=@"";
            slider.value=0;
            [list_exercise5 removeAllObjects];
            d=0;
            [list_exercise5 addObject:@"Null"];
            
        }else{
            
        }
    } else if(alertView.tag == kAlertViewTwo) {
        if (buttonIndex == 0) {
            
            if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
                
                NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE5 WHERE date='%@'", [listexercise5 objectAtIndex:d]];
                
                const char *del_stmt = [sql UTF8String];
                
                sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    NSLog(@"sss");
                    
                }
                
                sqlite3_finalize(statement);
                sqlite3_close(exerciseDB);
                
            }
            
            ovning.text=@"";
            egen.text=@"";
            prc.text=@"";
            slider.value=0;
            [list_exercise5 removeAllObjects];
            d=0;
            [list_exercise5 addObject:@"Null"];
            
            UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Raderat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
            [alert1 show];
            [alert1 release];
        }
        else {
            
        }
    }
}


-(IBAction)CloseButton:(id)sender{
    pupview.hidden=YES;
    scroll.scrollEnabled=YES;
    timerview.hidden = YES;
    scroll.scrollEnabled=YES;
    [listof_sliderValue removeAllObjects];
    [list_egen removeAllObjects];
    [listofovningars removeAllObjects];
}


-(IBAction)nextbutton:(id)sender
{
    scroll.scrollEnabled=NO;
    [listexercise5 removeAllObjects];
    [self getlistofDates];
}

-(void)getlistofDates {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT * FROM EXERCISE5 ORDER BY date DESC"
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
                    
                    scroll.scrollEnabled=YES;
                }
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    
    [self.tblView reloadData];
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
