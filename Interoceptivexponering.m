//
//  Interoceptivexponering.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/6/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Interoceptivexponering.h"
#import "MTPopupWindow.h"
#import "InteroceptiveCustomCell.h"


#define kAlertViewOne 1
#define kAlertViewTwo 2

#define kQuestionId @"questionId"
#define kQuestion @"question"
#define kAns1 @"ans1"
#define kAns2 @"ans2"


@interface Interoceptivexponering ()
@property (nonatomic, assign) int hours;
@property (nonatomic, assign) int seconds;
@property (nonatomic, assign) int minutes;
@property (nonatomic, assign) int Reseconds;
@property (nonatomic, assign) int Reminutes;

@property (nonatomic) BOOL isSaved;

@end

@implementation Interoceptivexponering
@synthesize ovning,egen,slider,tblView,prc;
@synthesize hoursDisplay;
@synthesize secondsDisplay;
@synthesize minutesDisplay;
@synthesize secondsTimer;
@synthesize seconds;
@synthesize minutes;
@synthesize hours;
@synthesize allItems;

@synthesize selectedIndexPath;

//Gopal
@synthesize isSaved;
@synthesize timerQuestionLabel;


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
    [hoursDisplay release];
    [super dealloc];
    [timerQuestionLabel release];
    [allItems release];
    [timerview release];
    [pupview release];
    [ovning release];
    
}

#pragma mark -- TextViewDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    isSaved = YES;

    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
               
        if (self.selectedIndexPath) {
            NSLog(@"fal %i",self.selectedIndexPath.row);

            NSDictionary *tempDict = [allItems objectAtIndex:self.selectedIndexPath.row];
            [tempDict setValue:ovning.text forKey:kQuestion];
            [tempDict setValue:egen.text forKey:kAns1];
            [tempDict setValue:prc.text forKey:kAns2];
            
        }else {
            if ([allItems count] > 0) {
                NSDictionary *tempDict = [allItems lastObject];
                [tempDict setValue:ovning.text forKey:kQuestion];
                [tempDict setValue:egen.text forKey:kAns1];
                [tempDict setValue:prc.text forKey:kAns2];
            }
        }
        
        
        
        /*if (selectedIndexPath) {
            NSDictionary *temp  =  [allItems objectAtIndex:[selectedIndexPath row]];
            [temp setValue:ovning.text forKey:kQuestion];
            [temp setValue:egen.text forKey:kAns1];
            [temp setValue:prc.text forKey:kAns2];
            
        }
        if (selectedDic) {
            [selectedDic setValue:ovning.text forKey:kQuestion];
            [selectedDic setValue:egen.text forKey:kAns1];
            [selectedDic setValue:prc.text forKey:kAns2];
        }
        else {
            for (int i = 0; i < [allItems count]; i ++) {
                NSDictionary *tempDic = [allItems objectAtIndex:i];
                if ([ovning.text isEqualToString:[tempDic valueForKey:@"question"]]) {
                    [tempDic setValue:ovning.text forKey:kQuestion];
                    [tempDic setValue:egen.text forKey:kAns1];
                    [tempDic setValue:prc.text forKey:kAns2];
                    break;
                }
            }
        }*/
    }else{
        //NSLog(@"%@",textView.text);
    }
    
    
    
    
    return YES;
}


#pragma mark -- ViewLifeCycle Methods 

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Interoceptiv Exponering";
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setBackgroundImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
        
    }
    else {
        
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setBackgroundImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    }
    
    //iPhone ScrollView
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 663)];
    
    
    //iPad ScrollView
    scroll1.scrollEnabled = YES;
    [scroll1 setContentSize:CGSizeMake(320, 1010)];

    
    allItems = [[NSMutableArray alloc] init];

    egen.userInteractionEnabled = NO;
    
    inStr =[[NSString alloc]init];
   
    inStr=@"00";
    
    pupview.hidden=YES;
    timerview.hidden=YES;
    
    
//    UITapGestureRecognizer *tapGesture3 =
//    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ovninglabelalert:)] autorelease];
//    [ovning addGestureRecognizer:tapGesture3];
    
    
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE5 (ID INTEGER PRIMARY KEY AUTOINCREMENT,QUESTIONID INTEGER DEFAULT 0, DATE TEXT,OVNINGAR TEXT,EGEN TEXT, ANGEST TEXT)";
        
        if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create database");
        }
        
        sqlite3_close(exerciseDB);
        
    } else {
        NSLog(@"Failed to open/create database");
    }
}

-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [self getDetailsFromInteroceptivexponeringDB];
}


#pragma mark PopOverViewController

-(IBAction)titlelabelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Interoceptivexponering.html" insideView:self.view];
}

-(IBAction)titlelabel1alert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"ovningsbeskrivningar.html" insideView:self.view];
}



#pragma Timer

//time Method
- (void)timerFireMethod:(NSTimer *) theTimer
{
    
    if(self.seconds ==0 && self.minutes ==0 && self.hours == 0){
        
        [self.secondsTimer invalidate];

        
        NSDictionary * temp_dict=[self.allItems objectAtIndex:[allItems count]-1];
        NSString * string_body = [NSString stringWithFormat:@"%@ : Tiden är ute",[temp_dict objectForKey:@"question"]];
        
        UILocalNotification * local = [[UILocalNotification alloc]  init];
        local.alertBody = string_body;
        
        NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Key1", @"key", nil];
        local.userInfo = infoDict;

        
        local.alertAction = nil;
        
        local.soundName = UILocalNotificationDefaultSoundName;
        
        local.fireDate = [NSDate date];
        [[UIApplication sharedApplication] scheduleLocalNotification:local];
        
        
    }else{
        
        NSLog(@"running ");
       
        if (self.minutes == 0  && self.hours !=0) {
            self.hours--;
            self.minutes = 59;
            self.seconds = 60;
        }
        if (self.seconds == 0 && self.minutes != 0) {
            self.minutes--;
            self.seconds = 60;
        }
         self.seconds--;
        
    }
    self.hoursDisplay.text = [NSString stringWithFormat:@"%.2d",self.hours];
    self.secondsDisplay.text = [NSString stringWithFormat:@"%.2d", self.seconds];


    self.minutesDisplay.text = [NSString stringWithFormat:@"%.2d", self.minutes];
}


#pragma mark Question PopOverView

-(void)ovninglabelalert:(id)sender {
    
    egen.userInteractionEnabled = YES;
    scroll.scrollEnabled=NO;
    pupview.hidden = NO;
    self.selectedIndexPath = nil;
    ovning.text=@"";
    egen.text=@"";
    prc.text=@"0";
    slider.value=0;
    //[self.view addSubview:pupview];
    //[UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView commitAnimations];
}



#pragma mark Close PopOver Timer

- (IBAction)closeBtn:(id)sender
{
    NSMutableDictionary  *_items = [[NSMutableDictionary alloc] init];

    pupview.hidden=YES;
    
    if (tagValueForBtn == 8 || tagValueForBtn == 9) {
        timerview.hidden = YES;
    }else {
        [self.view addSubview:timerview];
        timerview.hidden = NO;
    }

    egen.hidden=NO;
    slider.hidden=NO;
    prc.hidden=NO;
    startTime.enabled =YES;
    //BOOL isExits = NO;
    
    /*if ([allItems count] > 0) {
        for (int i =0 ; i < [allItems count]; i ++) {
            NSDictionary *tempDict = [allItems objectAtIndex:i];
            if ([ovning.text isEqualToString:[tempDict valueForKey:kQuestion]]) {
                [tempDict setValue:ovning.text forKey:kQuestion];
                [tempDict setValue:egen.text forKey:kAns1];
                [tempDict setValue:prc.text forKey:kAns2];
                isExits = YES;
            }else {

            }
        }
        if (isExits== NO) {
            [_items setValue:ovning.text forKey:kQuestion];
            [_items setValue:egen.text forKey:kAns1];
            [_items setValue:prc.text forKey:kAns2];
            [allItems addObject:_items];
        }
    }else {
        [_items setValue:ovning.text forKey:kQuestion];
        [_items setValue:egen.text forKey:kAns1];
        [_items setValue:prc.text forKey:kAns2];
        [allItems addObject:_items];
    }*/
    
   
    if ([allItems count] > 0) {
    
        [_items setValue:[NSNumber numberWithInt:[allItems count]+1] forKey:kQuestionId];
        [_items setValue:ovning.text forKey:kQuestion];
        [_items setValue:egen.text forKey:kAns1];
        [_items setValue:prc.text forKey:kAns2];
        [allItems addObject:_items];
    }else {
        [_items setValue:[NSNumber numberWithInt:1] forKey:kQuestionId];
        [_items setValue:ovning.text forKey:kQuestion];
        [_items setValue:egen.text forKey:kAns1];
        [_items setValue:prc.text forKey:kAns2];
        [allItems addObject:_items];
    }
    
   
    [self.tblView reloadData];
    
    
    NSLog(@"closeButton Clicked allItems is %@",allItems);
    
    
    [UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView commitAnimations];
    
    
        self.hoursDisplay.text = [NSString stringWithFormat:@"%.2d",self.hours];
        self.secondsDisplay.text = [NSString
                                stringWithFormat:@"%.2d", self.seconds];
   
    
    self.minutesDisplay.text = [NSString
                                stringWithFormat:@"%.2d", self.minutes];
    self.Reseconds=self.seconds;
    self.Reminutes=self.minutes;
}


#pragma mark NyttButtonClicked
- (IBAction)ntyyButtonClicked:(id)sender {
    
    egen.userInteractionEnabled = YES;
    scroll.scrollEnabled=NO;
    pupview.hidden = NO;
    self.selectedIndexPath = nil;
    ovning.text=@"";
    egen.text=@"";
    prc.text=@"0";
    slider.value=0;
    [self.view addSubview:pupview];
    //[UIView beginAnimations:@"curlInView" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView commitAnimations];
}

#pragma mark Close Timer


- (IBAction)closetimer:(id)sender{
    [startTime setUserInteractionEnabled:YES];
    timerview.hidden=YES;
    scroll.scrollEnabled=YES;
    egen.hidden=NO;
    slider.hidden=NO;
    prc.hidden=NO;
    [self.secondsTimer invalidate];
    self.secondsTimer= nil;
    hoursDisplay.text =@"00";
    secondsDisplay.text=@"00";
    minutesDisplay.text=@"00";
}


#pragma mark Start Timer

- (IBAction)starttimer:(id)sender{
    UIButton *b = (UIButton *)sender;
    [b setUserInteractionEnabled:NO];
    self.secondsTimer = [NSTimer
                         scheduledTimerWithTimeInterval:1.0
                         target:self
                         selector:@selector(timerFireMethod:)
                         userInfo:nil
                         repeats:YES];
}



#pragma mark Reset Timer


- (IBAction)Restarttimer:(id)sender {
    [startTime setUserInteractionEnabled:YES];
    [self.secondsTimer invalidate];
    self.secondsTimer= nil;
   
    self.hoursDisplay.text = [NSString stringWithFormat:@"%.2d",self.hours];
    
    self.secondsDisplay.text = [NSString
                                    stringWithFormat:@"%.2d", self.Reseconds];

    self.minutesDisplay.text = [NSString
                                stringWithFormat:@"%.2d", self.Reminutes];
    self.seconds= self.Reseconds;
    self.minutes= self.Reminutes;
    
}


#pragma mark Stop Timer
//Timer Stop
- (IBAction)stoptimer:(id)sender{
    [startTime setUserInteractionEnabled:YES];
    [self.secondsTimer invalidate];
    self.secondsTimer= nil;
}



#pragma mark PopOver View

-(IBAction)selectedcheckbox:(id)sender{
    
   // NSArray *tempArray = [[NSArray alloc] initWithObjects:@"Skaka huvudet (30 sek)",@"Tajta kläder (60 min)",@"Huvudet mellan benen (90 sek)",@"Spring på stället (2 min)",@"Fullständig kroppsspänning (1 min)"@"Hålla andan (30 sek)",@"Hyperventilera (90 sek)",@"Svälj snabbt (fem gånger)",@"Drick kaffe",@"Vatten i munnen (2 min)",nil];
    UIButton *btn = (UIButton *)sender;
    tagValueForBtn = btn.tag;
    NSLog(@"selectedCheckButton tag is %i",btn.tag);
    
    for (UIButton *radioButton in [pupview  subviews]) {
        if (radioButton.tag != btn.tag && [radioButton isKindOfClass:[UIButton class]] &&  radioButton.tag != 11 && radioButton.tag != 12) {
            [radioButton setImage:[UIImage imageNamed:@"LUncheck.png"] forState:UIControlStateNormal];
        }
    }
    
    [btn setImage:[UIImage imageNamed:@"LChecked.png"] forState:UIControlStateNormal];
    
    switch (btn.tag) {
        case 1:
            ovning.text=@"Skaka huvudet (30 sek)";
            self.hours=00;
            self.seconds=30;
            self.minutes=00;
            break;
        case 2:
            ovning.text=@"Tajta kläder (60 min)";
            self.hours=01;
            self.minutes=00;
            self.seconds=00;
            break;
        case 3:
            ovning.text=@"Huvudet mellan benen (90 sek)";
            self.hours=00;
            self.minutes=01;
            self.seconds=30;
            break;
        case 4:
            ovning.text=@"Spring på stället (2 min)";
            self.hours=00;
            self.minutes=02;
            self.seconds=00;
            break;
        case 5:
            ovning.text=@"Fullständig kroppsspänning (1 min)";
            self.hours=00;
            self.minutes=01;
            self.seconds=00;
            break;
        case 6:
            ovning.text=@"Hålla andan (30 sek)";
            self.hours=00;
            self.seconds=30;
            self.minutes=00;
            break;
        case 7:
            
            ovning.text=@"Hyperventilera (90 sek)";
            self.hours=00;
            self.minutes=01;
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
            self.hours=00;
            self.minutes=01;
            self.seconds=59;
            break;
        default:
            break;
    }
    
    timerQuestionLabel.text = ovning.text;
}


#pragma mark UISilder Value Changes

//Slider Value Changes
-(IBAction)updateside:(id)sender
{
    
        
        slider = (UISlider*)sender;
        NSLog(@"Slider Value: %.1f", [slider value]);
        NSNumber *myNumber = [NSNumber numberWithDouble:[slider value]];
        NSInteger myInt = [myNumber intValue];
        
        inStr = [NSString stringWithFormat:@"%d", myInt];
        prc.text=inStr;
        
        
        NSLog(@"%@ %@, %@",ovning.text,egen.text,prc.text);
        
        if (self.selectedIndexPath) {
            NSDictionary *tempDict = [allItems objectAtIndex:self.selectedIndexPath.row];
            [tempDict setValue:ovning.text forKey:kQuestion];
            [tempDict setValue:egen.text forKey:kAns1];
            [tempDict setValue:prc.text forKey:kAns2];
            
        }
        else {
            if ([allItems count] > 0) {
                NSDictionary *tempDict = [allItems lastObject];
                [tempDict setValue:ovning.text forKey:kQuestion];
                [tempDict setValue:egen.text forKey:kAns1];
                [tempDict setValue:prc.text forKey:kAns2];
            }
        }
        
        
        /*if (selectedIndexPath) {
            NSDictionary *temp  =  [allItems objectAtIndex:[selectedIndexPath row]];
            [temp setValue:ovning.text forKey:kQuestion];
            [temp setValue:egen.text forKey:kAns1];
            [temp setValue:prc.text forKey:kAns2];
            
        }
        if (selectedDic) {
            [selectedDic setValue:ovning.text forKey:kQuestion];
            [selectedDic setValue:egen.text forKey:kAns1];
            [selectedDic setValue:prc.text forKey:kAns2];
            
        }else {
            
            for (int i = 0; i < [allItems count]; i ++) {
                NSDictionary *tempDic = [allItems objectAtIndex:i];
                if ([ovning.text isEqualToString:[tempDic valueForKey:kQuestion]]) {
                    [tempDic setValue:ovning.text forKey:kQuestion];
                    [tempDic setValue:egen.text forKey:kAns1];
                    [tempDic setValue:prc.text forKey:kAns2];
                    break;
                }
            }
        }*/
        
        [self.tblView reloadData];
        
        NSLog(@"updated the slide values of allitems is $$$$$$$$$$$$$$ %@",allItems);
}


#pragma mark -- TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [allItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifer = @"CellIdentifier";
    
    InteroceptiveCustomCell *cell = (InteroceptiveCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    
    if (cell == nil) {
        NSArray *objects =[[NSBundle mainBundle] loadNibNamed:@"InteroceptiveCustomCell" owner:self options:nil];
        
        for (id object in objects) {
            if ([object isKindOfClass:[InteroceptiveCustomCell class]]) {
                
                cell = (InteroceptiveCustomCell*)object;
            }
        }
    }
    
    NSUInteger row = [indexPath row];
    
    NSDictionary *tempDict = [allItems objectAtIndex:row];
    
    NSInteger myInt = [[[allItems objectAtIndex:indexPath.row] valueForKey:kAns2] intValue];
    if (myInt < 20 ) {
        cell.greenImage.image = [UIImage imageNamed:@"minimized-green.png"];
    }
    else {
       cell.greenImage.image = [UIImage imageNamed:@"minimized-white.png"]; 
    }
    NSArray *TEMP = [[tempDict valueForKey:kQuestion] componentsSeparatedByString:@"("];

    cell.title.text   = [[TEMP objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.detailValue.text = [tempDict valueForKey:kAns2];

    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"DisplayCell");
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    egen.userInteractionEnabled = YES;

    self.selectedIndexPath = [[NSIndexPath alloc] init];
    
    
    self.selectedIndexPath = indexPath;
    
    NSLog(@"didSelectedRowAtIndexpath is %d",self.selectedIndexPath.row);
   
    
    ovning.text = [[allItems objectAtIndex:indexPath.row] valueForKey:kQuestion];
    egen.text = [[allItems objectAtIndex:indexPath.row] valueForKey:kAns1];
    prc.text = [[allItems objectAtIndex:indexPath.row] valueForKey:kAns2];
    
    NSInteger myInt = [prc.text intValue];
    [slider setValue:myInt animated:YES];
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark SparatButton-- Save to Database

- (BOOL)findContact:(NSNumber*)questionId
{
    const char *dbpath = [databasePath UTF8String];
   
    BOOL isFind = NO;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        
        NSInteger questionID = [questionId integerValue];
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT questionid FROM EXERCISE5 WHERE questionid=\"%d\"", questionID];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                isFind  = YES;
        
            } else {
                isFind  =  NO;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    
    return isFind;
}


-(void)insertIntoDatabase:(NSDictionary*)recordDic {
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    NSString* str = [formatter stringFromDate:[NSDate date]];
    
    NSLog(@"converted date string %@",str);
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger questionId = [[recordDic valueForKey:kQuestionId] integerValue];
        
        NSLog(@"Insert Value is %i",questionId);
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO EXERCISE5 (questionid,date,ovningar,egen,angest) VALUES (\"%d\", \"%@\", \"%@\", \"%@\" ,\"%@\")",questionId, str, [recordDic valueForKey:kQuestion],[recordDic valueForKey:kAns1],[recordDic valueForKey:kAns2]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"YES");
            isSaved = NO;
        } else {
            NSLog(@"NO");
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
        }
        
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}


-(void)updateIntDatabase:(NSDictionary*)recordsDic {
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    NSString* str = [formatter stringFromDate:[NSDate date]];
    
    NSLog(@"converted date string %@",str);
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger questionId = [[recordsDic valueForKey:kQuestionId] integerValue];
        
        NSString *query=[NSString stringWithFormat:@"UPDATE EXERCISE5 SET questionid='%d', date='%@', ovningar='%@', egen='%@', angest='%@' WHERE questionid='%d'", questionId, str, [recordsDic valueForKey:kQuestion],[recordsDic valueForKey:kAns1],[recordsDic valueForKey:kAns2],questionId];
        
        const char *del_stmt = [query UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Updated");
            isSaved = NO;
            
        }else {
            NSLog(@"Failed to Update");
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
        }
        
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(exerciseDB);
}

-(void)deleteRecordsFromDB:(NSDictionary *)tempDict {
    
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSInteger questionId = [[tempDict valueForKey:kQuestionId] integerValue];
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM EXERCISE5 WHERE questionid='%d'",questionId];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_ROW) {
    
            NSLog(@"sss");
            
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}


-(IBAction)SparaButton:(id)sender {
    
    
    if([ovning.text isEqualToString:@""] &&[egen.text isEqualToString:@""] &&[prc.text isEqualToString:@""] ){
        
    }
    else{
        
        NSLog(@"ALLTEMS  IS %@",allItems);
        
    
        for (int i = 0; i < [allItems count]; i++) {
            
            NSDictionary *tempDic = [allItems objectAtIndex:i];
        
            if ([self findContact:[tempDic valueForKey:kQuestionId]]) {
                NSLog(@"Update Record Insert into Database");
                [self updateIntDatabase:tempDic];
                
            }else {
                NSLog(@"New Record Insert into Database");
                [self insertIntoDatabase:tempDic];
            }
        }

        self.selectedIndexPath = nil;
        UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"Sparat" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok",nil];
        [alert1 show];
        [alert1 release];
    }
}



#pragma mark Nytt -- New Record

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
            
            NSLog(@"new form");
            ovning.text=@"";
            egen.text=@"";
            prc.text=@"0";
            slider.value=0;
            
            
            while ([allItems count] > 0) {
                NSLog(@"%@",allItems);
                NSDictionary *tempDic = [allItems objectAtIndex:0];
                
                [self deleteRecordsFromDB:tempDic];
                [self.allItems removeObject:tempDic];
            }
            
            [self.tblView reloadData];
        }
    }
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(alertView.tag  == kAlertViewOne) {
        if (buttonIndex == 0) {
            while ([allItems count] > 0) {
                NSLog(@"%@",allItems);
                NSDictionary *tempDic = [allItems objectAtIndex:0];
                
                //[self deleteRecordsFromDB:tempDic];
                [self.allItems removeObject:tempDic];
            }

            [self.tblView reloadData];
            NSLog(@"new form");
            ovning.text=@"";
            egen.text=@"";
            prc.text=@"0";
            slider.value=0;
        }
    }
    
}


#pragma mark Getting the Data From the Database

-(void)getDetailsFromInteroceptivexponeringDB
{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT * FROM EXERCISE5 ORDER BY questionid ASC"
                              ];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB,query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"%u",SQLITE_ROW);
            while (sqlite3_step(statement) == SQLITE_ROW) {
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
                
                
                char* questionId = (char*) sqlite3_column_text(statement,1);
                
                if (questionId != NULL){
                    NSString *tmp = [NSString stringWithUTF8String:questionId];
                    NSNumber *questionID = [NSNumber numberWithInt:[tmp integerValue]];
                    NSLog(@"value form db :%@ %@",tmp,questionID);
                    [tempDic setValue:questionID forKey:kQuestionId];
                    
                }
                
                char* question = (char*) sqlite3_column_text(statement,3);

                if (question != NULL){
                    NSString *tmp = [NSString stringWithUTF8String:question];
                    NSLog(@"value form db :%@",tmp);
                    [tempDic setValue:tmp forKey:kQuestion];
                
                }
                
                char* ans1  = (char*) sqlite3_column_text(statement,4);

                if (ans1 != NULL){
                    NSString *tmp = [NSString stringWithUTF8String:ans1];
                    NSLog(@"value form db :%@",tmp);
                    [tempDic setValue:tmp forKey:kAns1];
                 
                }
                
                char* ans2 = (char*) sqlite3_column_text(statement,5);

                if (ans2 != NULL){
                   NSString *tmp = [NSString stringWithUTF8String:ans2];
                    NSLog(@"value form db :%@",tmp);
                    [tempDic setValue:tmp forKey:kAns2];

                }

                [allItems addObject:tempDic];
            }
            if (sqlite3_step(statement) != SQLITE_ROW) {
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(exerciseDB);
    }
    
    
    NSLog(@"GETTING DATA %@",allItems);
    
   [self.tblView reloadData];
}



-(IBAction)CloseButton:(id)sender{
    pupview.hidden=YES;
    scroll.scrollEnabled=YES;
    timerview.hidden = YES;
}



- (void)viewDidUnload{
    [self setHoursDisplay:nil];
    [super viewDidUnload];
}



#pragma mark Email

- (IBAction)skickaButtonClicked:(id)sender
{
    UIActionSheet *cameraActionSheet = [[UIActionSheet alloc] initWithTitle:@"Skicka" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Download", @"Email", nil];
    cameraActionSheet.tag = 1;
    [cameraActionSheet showInView:self.view];
}

- (UIImage *)getFormImage
{
    UIImage *tempImage = nil;
    UIGraphicsBeginImageContext(scroll.contentSize);
    {
        CGPoint savedContentOffset = scroll.contentOffset;
        CGRect savedFrame = scroll.frame;
        
        scroll.contentOffset = CGPointZero;
        scroll.frame = CGRectMake(0, 0, scroll.contentSize.width, scroll.contentSize.height);
        
        [scroll.layer renderInContext: UIGraphicsGetCurrentContext()];
        tempImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scroll.contentOffset = savedContentOffset;
        scroll.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return tempImage;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
	if (buttonIndex == 0)
    {
        UIImage *image = [self getFormImage];
        if (image)
        {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Image downloaded" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
    }
    else if (buttonIndex == 1)
    {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *emailDialog = [[MFMailComposeViewController alloc] init];
            emailDialog.mailComposeDelegate = self;
            NSMutableString *htmlMsg = [NSMutableString string];
            [htmlMsg appendString:@"<html><body><p>"];
            [htmlMsg appendString:[NSString stringWithFormat:@"Please find the attached form on %@", [NSDate date]]];
            [htmlMsg appendString:@": </p></body></html>"];
            
            NSData *jpegData = UIImageJPEGRepresentation([self getFormImage], 1);
            
            NSString *fileName = [NSString stringWithString:[NSDate date]];
            fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
            [emailDialog addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
            
            [emailDialog setSubject:@"Form"];
            [emailDialog setMessageBody:htmlMsg isHTML:YES];
            
            
            [self presentViewController:emailDialog animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail cannot be send now. Please check mail has been configured in your device and try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
            
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail sent successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail send failed" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
            break;
        default:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail was not sent." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
