    //
//  CalendarViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "RegiDinaveckarCalendarViewController.h"
#import "SettingRegistViewController.h"
#import "ASDepthModalViewController.h"
#import "RegiDinaveckarDayCalendarViewController.h"

#define kStartDate @"startDate"
#define kEndDate   @"endDate"
#define kStatus    @"status"
#define kDayTime   @"dayTime"
#define kEventDes  @"eventDes"
#define kSub1Id    @"Sub1Id"

//SUB1TOTAL
#define kTSub1Id @"TSub1Id"
#define kTDate @"TDate"
#define kTTotal @"TTotal"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

static const unsigned int DAYS_IN_WEEK                        = 7;




@interface RegiDinaveckarCalendarViewController ()

@property (nonatomic, strong) NSString *currentStatuBtn;


@end

@implementation RegiDinaveckarCalendarViewController
@synthesize dayView;
@synthesize scrollView;
@synthesize settingRegViewCntrl;
//@synthesize monLabel1,tueLabel2,wedLabel3,thrLabel4,friLabel5,satLabel6,sunLabel7;
@synthesize monButton1,tueButton2,wedButton3,thrButton4,friButton5,satButton6,sunButton7;
@synthesize dataArray,weekdays,week;
//@synthesize mainWeekLabel;
@synthesize popupView,totalView;
@synthesize hoursTextField1,hoursTextField2;
@synthesize mintsTextField1,mintsTextField2;
@synthesize eventDesTextView;
@synthesize currentStatuBtn;
@synthesize slider,sliderLabel;
//@synthesize isEventNotify,isTotalNotify;

/////////////////////////***************************///////////

@synthesize buttonString;
@synthesize editIndexValue;
@synthesize raderaBtn;
@synthesize totalDataArray;
@synthesize totalBtnTag;
@synthesize regiDinaDayCalendarVC;
@synthesize selectedDictionary;


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

    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    else {
        return YES;
    }
    return 0;
}



-(NSString*)yearStringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
-(NSString*)monthStringFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"d/M"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@",selectedDictionary);
    
    NSString *titleStrin = nil;
    
    NSString *yearLabel1 = [self yearStringFromDate:[selectedDictionary valueForKey:kStartDate]];
    NSString *yearLabel2 = [self yearStringFromDate:[selectedDictionary valueForKey:kEndDate]];
    if([yearLabel1 isEqualToString:yearLabel2]){
       titleStrin  = [NSString stringWithFormat:@"%@ - %@ (%@)",[self monthStringFromDate:[selectedDictionary valueForKey:kStartDate]],[self monthStringFromDate:[selectedDictionary valueForKey:kEndDate]],yearLabel1];
    }else{
        titleStrin  = [NSString stringWithFormat:@"%@ (%@) - %@ (%@)",[self monthStringFromDate:[selectedDictionary valueForKey:kStartDate]],yearLabel1,[self monthStringFromDate:[selectedDictionary valueForKey:kEndDate]],yearLabel2];
    }
    self.navigationItem.title = titleStrin;
    
    [self.scrollView setContentSize:CGSizeMake(320, 699)];
    self.popupView.layer.cornerRadius = 12;
    self.popupView.layer.shadowOpacity = 0.7;
    self.popupView.layer.shadowOffset = CGSizeMake(6, 6);
    self.popupView.layer.shouldRasterize = YES;
    self.popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.totalView.layer.cornerRadius = 12;
    self.totalView.layer.shadowOpacity = 0.7;
    self.totalView.layer.shadowOffset = CGSizeMake(6, 6);
    self.totalView.layer.shouldRasterize = YES;
    self.totalView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    raderaBtn.enabled = NO;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setImage:image forState:UIControlStateNormal];
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
    
    UIImage *image = [UIImage imageNamed:@"setting_alarm_button.png"];
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [okBtn setBackgroundImage:image forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(settButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    
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
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SUB1EVENT (id INTEGER PRIMARY KEY AUTOINCREMENT,subId TEXT,date TEXT,startDate TEXT,endDate TEXT,status TEXT,dayDate TEXT,eventDescription TEXT)";
        const char *sql_stmt1 = "CREATE TABLE IF NOT EXISTS SUB1TOTAL (id INTEGER PRIMARY KEY AUTOINCREMENT,subTId TEXT,date TEXT,total TEXT)";
        
        if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create database");
        }
        if (sqlite3_exec(exerciseDB, sql_stmt1, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"Failed to create total database");
        }
        
        sqlite3_close(exerciseDB);
        
    } else {
        NSLog(@"Failed to open/create database");
    }
    
}


-(void)viewWillAppear:(BOOL)animated {
    
  
    [self week:[selectedDictionary valueForKey:kStartDate]];
    
    self.dataArray = [[NSMutableArray alloc] init];
    self.totalDataArray = [[NSMutableArray alloc] init];
    
    //[self displayButton];
    [self getDataSub1Events];
    [self getDataSub1Total];
    
}

-(void)viewDidAppear:(BOOL)animated {
 
}

-(void)viewDidDisappear:(BOOL)animated{
 
    
}

-(void)viewWillDisappear:(BOOL)animated{
 
    self.dataArray = nil;
    self.totalDataArray = nil;
}


-(void)dealloc {
    [dataArray release];
    [totalDataArray release];
    [super dealloc];
}


#pragma mark SettingViewController

-(void)settButtonClicked {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!settingRegViewCntrl) {
                settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView" bundle:nil];
            }
        }else{
            if (!settingRegViewCntrl) {
                settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!settingRegViewCntrl) {
            settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView_iPad" bundle:nil];
        }
    }
    
    [self.navigationController pushViewController:settingRegViewCntrl animated:YES];
}



-(void)displayButton {

    for (int i =0; i <[[self.scrollView subviews] count]; i++) {
        
        UIButton *btn = [[self.scrollView subviews] objectAtIndex:i];
        if ([btn isKindOfClass:[UIButton class]]) {
            
            NSString *statusString = nil;
            NSDate *date=nil;
            NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
            NSString *subString =  [btag substringFromIndex:1];

            NSString *s = [NSString stringWithFormat:@"%c",[btag characterAtIndex:0]];
           

            if ([s intValue] == 1) {
                date = [self.weekdays objectAtIndex:0];
                
            }else if ([s intValue] == 2) {
                date = [self.weekdays objectAtIndex:1];
                
            }else if ([s intValue] == 3){
                date = [self.weekdays objectAtIndex:2];
                
            }else if ([s intValue] == 4) {
                date = [self.weekdays objectAtIndex:3];
                
            }else if ([s intValue] == 5) {
                date = [self.weekdays objectAtIndex:4];
                
            }else if ([s intValue] == 6) {
                date = [self.weekdays objectAtIndex:5];
                
            }else if ([s intValue] == 7) {
                date = [self.weekdays objectAtIndex:6];
            }
            
            NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];

            for (int g =0; g<[dataArray count]; g++) {
                NSMutableDictionary *tempDict = [dataArray objectAtIndex:g];
                if ([[tempDict valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]){
                    
                    if ([[tempDict valueForKey:kStatus] isEqualToString:@"+"]){
                        statusString = @"+";
                    }else if ([[tempDict valueForKey:kStatus] isEqualToString:@"-"]){
                        statusString = @"-";
                    }else if ([[tempDict valueForKey:kStatus] isEqualToString:@"Neutral"]){
                        statusString = @"Neutral";
                    }
                    
                    [btn setTitle:[tempDict valueForKey:kEventDes] forState:UIControlStateNormal];
                    
                    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
                    
                    longPressGesture.minimumPressDuration = 1.0;
                    [btn addGestureRecognizer:longPressGesture];
                }
            }
            
            if ([statusString isEqualToString:@"+"]) {
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_positive.png"] forState:UIControlStateNormal];
            }else if ([statusString isEqualToString:@"-"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_negative.png"] forState:UIControlStateNormal];
            }else if ([statusString isEqualToString:@"Neutral"]){
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_emptycell_neutral.png"] forState:UIControlStateNormal];
            }else {
                [btn setBackgroundImage:[UIImage imageNamed:@"kalendar_cell_empty.png"] forState:UIControlStateNormal];
                [btn setTitle:@"" forState:UIControlStateNormal];
            }
        }
    }
}





- (void)longPress:(UIGestureRecognizer *)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        
        UIButton *btn = (UIButton*)[gesture view];
        NSDate *date=nil;
        
        NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
        NSString *subString =  [btag substringFromIndex:1];
        NSString *s = [NSString stringWithFormat:@"%c",[btag characterAtIndex:0]];
        if ([s intValue] == 1) {
            date = [self.weekdays objectAtIndex:0];
            
        }else if ([s intValue] == 2) {
            date = [self.weekdays objectAtIndex:1];
            
        }else if ([s intValue] == 3){
            date = [self.weekdays objectAtIndex:2];
            
        }else if ([s intValue] == 4) {
            date = [self.weekdays objectAtIndex:3];
            
        }else if ([s intValue] == 5) {
            date = [self.weekdays objectAtIndex:4];
            
        }else if ([s intValue] == 6) {
            date = [self.weekdays objectAtIndex:5];
            
        }else if ([s intValue] == 7) {
            date = [self.weekdays objectAtIndex:6];
        }
        
        NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
        
        buttonString = [[tm objectAtIndex:0] retain];
        
        for (int q= 0; q<[dataArray count]; q++) {
            NSMutableDictionary *temp = [dataArray objectAtIndex:q];
            
            if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
                editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete" message:[temp valueForKey:kEventDes] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
                
                [alert show];
                [alert release];
                break;
            }
        }
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
    }else {
        [self raderaClicked:nil];
        [self displayButton];
    }
}



-(IBAction)raderaButtonClicked:(id)sender {
    [ASDepthModalViewController dismiss];
    [self raderaClicked:nil];
    
}


-(void)raderaClicked:(id)sender {
    
    
    if (editIndexValue) {
        NSDictionary *deleDict = [dataArray objectAtIndex:[editIndexValue intValue]];
        [dataArray removeObject:deleDict];
        [self deleteRecord:deleDict];
    }
    editIndexValue = nil;
    
    
}



-(IBAction)empty:(id)sender {
    
    
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:0];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit=NO;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
    
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            currentStatuBtn = [temp valueForKey:kStatus];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
           
                hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[[sDA objectAtIndex:0] intValue]];
           
                hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[[eDA objectAtIndex:0] intValue]];
           

            isExit = YES;
            raderaBtn.enabled =YES;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
       
            hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
       
            hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
       
        
        raderaBtn.enabled = NO;
        editIndexValue= nil;
    }
    
    
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
}


-(IBAction)empty1:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:1];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit=NO;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            
            currentStatuBtn = [temp valueForKey:kStatus];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            
            hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[[eDA objectAtIndex:0] intValue]];
            
            
            isExit = YES;
            raderaBtn.enabled =YES;
        }
    }
    
    if (!isExit) {
        eventDesTextView.text = @"";
        
        hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
        
        hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
        
        raderaBtn.enabled = NO;
        editIndexValue= nil;
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}


-(IBAction)empty2:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:2];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit=NO;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            
            currentStatuBtn = [temp valueForKey:kStatus];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            
            hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[[sDA objectAtIndex:0] intValue]];
            hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[[eDA objectAtIndex:0] intValue]];
            isExit = YES;
            raderaBtn.enabled =YES;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        
        hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
        
        hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
        raderaBtn.enabled = NO;
        editIndexValue= nil;
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
}


-(IBAction)empty3:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    
    date = [self.weekdays objectAtIndex:3];
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit=NO;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];

        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            
            currentStatuBtn = [temp valueForKey:kStatus];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            
                hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[[sDA objectAtIndex:0] intValue]];
                hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[[eDA objectAtIndex:0] intValue]];
            

            isExit = YES;
            raderaBtn.enabled =YES;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
        hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
        raderaBtn.enabled =NO;
        editIndexValue= nil;
    }
    
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}


-(IBAction)empty4:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:4];
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit=NO;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            currentStatuBtn = [temp valueForKey:kStatus];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
           
                hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[[sDA objectAtIndex:0] intValue]];
           
                hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[[eDA objectAtIndex:0] intValue]];
           

            isExit = YES;
            raderaBtn.enabled =YES;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
       
            hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
            hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
       
        raderaBtn.enabled = NO;
        editIndexValue= nil;
    }
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}


-(IBAction)empty5:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:5];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit=NO;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
       
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            currentStatuBtn = [temp valueForKey:kStatus];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            
                hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[[sDA objectAtIndex:0] intValue]];
                hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[[eDA objectAtIndex:0] intValue]];
            

            isExit = YES;
            raderaBtn.enabled =YES;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        
        hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
        
        hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
        
        raderaBtn.enabled = NO;
        editIndexValue= nil;
    }
    
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}


-(IBAction)empty6:(id)sender {
    UIButton *btn = (UIButton*)sender;
    NSDate *date=nil;
    date = [self.weekdays objectAtIndex:6];
    
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit=NO;
    for (int q= 0; q<[dataArray count]; q++) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:q];
        
        if ([[temp valueForKey:kDayTime] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]) {
            editIndexValue = [[NSString stringWithFormat:@"%i",q] retain];
            currentStatuBtn = [temp valueForKey:kStatus];
            NSArray *sDA = [[temp valueForKey:kStartDate] componentsSeparatedByString:@":"];
            NSArray *eDA = [[temp valueForKey:kEndDate] componentsSeparatedByString:@":"];
            eventDesTextView.text = [temp valueForKey:kEventDes];
            
            hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[[sDA objectAtIndex:0] intValue]];
            
            hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[[eDA objectAtIndex:0] intValue]];
            
            
            isExit = YES;
            raderaBtn.enabled =YES;
        }
    }
    if (!isExit) {
        eventDesTextView.text = @"";
        
        hoursTextField1.text = [NSString stringWithFormat:@"%.2i",[subString intValue]-1];
        
        hoursTextField2.text = [NSString stringWithFormat:@"%.2i",[hoursTextField1.text intValue]+1];
        
        raderaBtn.enabled = NO;
        editIndexValue= nil;
    }
    
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.popupView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                              NSLog(@"Modal view closed.");
                          }];
    
}



-(void)getDataSub1Events {
    
    const char *dbpath = [databasePath UTF8String];

    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB1EVENT"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *subId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                NSString *startDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                NSString *endDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)];
                NSString *status = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 5)];
                NSString *daytime = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 6)];
                NSString *eventDescription = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 7)];
        
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:subId forKey:kSub1Id];
                [itemDict setValue:startDate forKey:kStartDate];
                [itemDict setValue:endDate forKey:kEndDate];
                [itemDict setValue:status forKey:kStatus];
                [itemDict setValue:daytime forKey:kDayTime];
                [itemDict setValue:eventDescription forKey:kEventDes];
                
                [dataArray addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    
    [self displayButton];
}


-(void)getDataSub1Total
{
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM SUB1TOTAL"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(exerciseDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while  (sqlite3_step(statement) == SQLITE_ROW) {
                NSString *subTId = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,1)];
                NSString *dayDate = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement,2)];
                NSString *total = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc]init];
                [itemDict setValue:subTId forKey:kTSub1Id];
                [itemDict setValue:dayDate forKey:kTDate];
                [itemDict setValue:total forKey:kTTotal];
                
                [totalDataArray addObject:itemDict];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    
}


-(NSString*)dateFromStringCal:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



-(void)backButon  {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark SettingViewController

/*-(void)settButtonClicked {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!settingRegViewCntrl) {
                settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView" bundle:nil];
            }
        }else{
            if (!settingRegViewCntrl) {
                settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!settingRegViewCntrl) {
            settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView_iPad" bundle:nil];
        }
    }
    
    [self.navigationController pushViewController:settingRegViewCntrl animated:YES];
}*/




-(BOOL)findSameTime {
    
    BOOL isTime;
    
    NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
    for (int i = 0; i < [dataArray count]; i++) {
        NSDictionary *tem = [dataArray objectAtIndex:i];
        if ([[tem valueForKey:kStartDate] isEqualToString:startDate]){
            isTime =  YES;
        }else {
            isTime = NO;
        }
    }
    
    return isTime;
}


-(IBAction)okButtonClicked:(id)sender
{
    
    if ([self findSameTime]  && [editIndexValue length] == 0 && editIndexValue == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"KBT Appen" message:@"Already Exits" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
    }
    else {
    [ASDepthModalViewController dismiss];

    if (editIndexValue) {
        NSMutableDictionary *temp = [dataArray objectAtIndex:[editIndexValue intValue]];
        NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
        NSString *endDate =[NSString stringWithFormat:@"%@:%@",hoursTextField2.text,mintsTextField2.text];
        NSString *dayTime = [NSString stringWithFormat:@"%@ %i",buttonString,[hoursTextField1.text intValue]+1];
        [temp setValue:eventDesTextView.text forKey:kEventDes];
        [temp setValue:startDate forKey:kStartDate];
        [temp setValue:endDate forKey:kEndDate];
        [temp setValue:dayTime forKey:kDayTime];
        [temp setValue:currentStatuBtn forKey:kStatus];
    }else {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        NSString *startDate = [NSString stringWithFormat:@"%@:%@",hoursTextField1.text,mintsTextField1.text];
        NSString *endDate =[NSString stringWithFormat:@"%@:%@",hoursTextField2.text,mintsTextField2.text];
        NSString *dayTime = [NSString stringWithFormat:@"%@ %i",buttonString,[hoursTextField1.text intValue]+1];

        if (!currentStatuBtn)
            currentStatuBtn = @"Neutral";
            
        [temp setValue:[NSNumber numberWithInt:[dataArray count]+1] forKey:kSub1Id];
        [temp setValue:eventDesTextView.text forKey:kEventDes];
        [temp setValue:startDate forKey:kStartDate];
        [temp setValue:endDate forKey:kEndDate];
        [temp setValue:dayTime forKey:kDayTime];
        [temp setValue:currentStatuBtn forKey:kStatus];
        [dataArray addObject:temp];
    }
    editIndexValue = nil;
    
    
    [self  databaseInsert];
    }
}


-(IBAction)totalOkButtonClicked:(id)sender {
    
    [ASDepthModalViewController dismiss];
    NSLog(@"%@",editIndexValue);
    if (editIndexValue) {
        NSString *dayTime = [NSString stringWithFormat:@"%@ %@",buttonString,totalBtnTag];
        NSMutableDictionary *teDic = [self.totalDataArray objectAtIndex:[editIndexValue intValue]];
        [teDic setValue:dayTime forKey:kTDate];
        [teDic setValue:sliderLabel.text forKey:kTTotal];
        
    }else {
        NSMutableDictionary *teDic = [[NSMutableDictionary alloc] init];
        NSString *dayTime = [NSString stringWithFormat:@"%@ %@",buttonString,totalBtnTag];
        [teDic setValue:[NSNumber numberWithInt:[self.totalDataArray count]+1] forKey:kTSub1Id];
        [teDic setValue:dayTime forKey:kTDate];
        [teDic setValue:sliderLabel.text forKey:kTTotal];
        [self.totalDataArray addObject:teDic];
    }
    editIndexValue = nil;
    NSLog(@"totalArray is %@",self.totalDataArray);
    [self databaseInsertTotal];
}

-(IBAction)closeButtonAction:(id)sender{
    [ASDepthModalViewController dismiss];
}

-(IBAction)sliderValueChanged:(UISlider*)sender{
    sliderLabel.text = [NSString stringWithFormat:@"%.0f",[sender value]];
}


#pragma mark TotalButtonClicked 

-(IBAction)totalButtonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSDate *date=nil;
    NSString *btag = [NSString stringWithFormat:@"%i",btn.tag];
    NSString *subString =  [btag substringFromIndex:1];
    totalBtnTag = [subString retain];
    NSString *s = [NSString stringWithFormat:@"%c",[btag characterAtIndex:0]];
    
    
    if ([s intValue] == 1) {
        date = [self.weekdays objectAtIndex:0];
        
    }else if ([s intValue] == 2) {
        date = [self.weekdays objectAtIndex:1];
        
    }else if ([s intValue] == 3){
        date = [self.weekdays objectAtIndex:2];
        
    }else if ([s intValue] == 4) {
        date = [self.weekdays objectAtIndex:3];
        
    }else if ([s intValue] == 5) {
        date = [self.weekdays objectAtIndex:4];
        
    }else if ([s intValue] == 6) {
        date = [self.weekdays objectAtIndex:5];
        
    }else if ([s intValue] == 7) {
        date = [self.weekdays objectAtIndex:6];
    }
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    buttonString = [[tm objectAtIndex:0] retain];
    BOOL isExit = NO;
    for (int y=0; y<[self.totalDataArray count]; y++) {
        NSDictionary *tempDict = [self.totalDataArray objectAtIndex:y];
        if ([[tempDict valueForKey:kTDate] isEqualToString:[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[subString intValue]]]){
            editIndexValue = [[NSString stringWithFormat:@"%i",y] retain];
            [sliderLabel setText:[tempDict valueForKey:kTTotal]];
            NSInteger myInt = [[tempDict valueForKey:kTTotal] intValue];
            [slider setValue:myInt animated:YES];
            isExit = YES;
        }
    }
    if (!isExit){
        [sliderLabel setText:@"0"];
        NSInteger myInt = [sliderLabel.text intValue];
        [slider setValue:myInt animated:YES];
        editIndexValue= nil;
    }
    
    ASDepthModalOptions style = ASDepthModalOptionAnimationGrow;
    [ASDepthModalViewController presentView:self.totalView
                            backgroundColor:nil
                                    options:style
                          completionHandler:^{
                          }];
}

#pragma mark Calendar Day Button Clicked

-(IBAction)calendarDayCellClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSDate *date=nil;
    
    
    
    if ([btn tag] == 1) {
        date = [self.weekdays objectAtIndex:0];
        
    }else if ([btn tag] == 2) {
        date = [self.weekdays objectAtIndex:1];
        
    }else if ([btn tag] == 3){
        date = [self.weekdays objectAtIndex:2];
        
    }else if ([btn tag] == 4) {
        date = [self.weekdays objectAtIndex:3];
        
    }else if ([btn tag] == 5) {
        date = [self.weekdays objectAtIndex:4];
        
    }else if ([btn tag] == 6) {
        date = [self.weekdays objectAtIndex:5];
        
    }else if ([btn tag] == 7) {
        date = [self.weekdays objectAtIndex:6];
    }
    
    NSArray *tm = [[self dateFromStringCal:date] componentsSeparatedByString:@" "];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!regiDinaDayCalendarVC) {
                regiDinaDayCalendarVC = [[RegiDinaveckarDayCalendarViewController alloc]initWithNibName:@"RegiDinaveckarDayCalendarView" bundle:nil];
            }
        }else{
            if (!regiDinaDayCalendarVC) {
                regiDinaDayCalendarVC = [[RegiDinaveckarDayCalendarViewController alloc]initWithNibName:@"RegiDinaveckarDayCalendarView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!regiDinaDayCalendarVC) {
            regiDinaDayCalendarVC = [[RegiDinaveckarDayCalendarViewController alloc]initWithNibName:@"RegiDinaveckarDayCalendarView_iPad" bundle:nil];
        }
    }
    
    regiDinaDayCalendarVC.dayTimenTag =[NSString stringWithFormat:@"%@ %i",[tm objectAtIndex:0],[btn tag]];
    
    [self.navigationController pushViewController:regiDinaDayCalendarVC animated:YES];
}


#pragma mark Status Button

-(IBAction)statusButtonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 1:
            currentStatuBtn = btn.currentTitle;
            break;
        case 2:
            currentStatuBtn = btn.currentTitle;
            break;
        case 3:
            currentStatuBtn = btn.currentTitle;
            break;
        default:
            currentStatuBtn = @"Neutral";
            break;
    }
}

#pragma mark Calendar 

- (void)week:(NSDate *)_date {
    
    
    self.week = _date;
    
    self.weekdays = [[NSMutableArray alloc] init];
    
    for (int i =0; i < 7; i++)
    {
        NSDateComponents *comps1 = [[NSDateComponents alloc] init];
        [comps1 setMonth:0];
        [comps1 setDay:+i];
        [comps1 setHour:0];
        NSCalendar *calendar1 = [NSCalendar currentCalendar];
        NSDate *newDate1 = [calendar1 dateByAddingComponents:comps1 toDate:_date options:0];
        [self.weekdays addObject:newDate1];
    }
	[self updateScreens];
}



-(void)updateScreens {
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    NSArray *weekdaySymbols = [dateFormatter shortWeekdaySymbols];
    
	for (int i =0; i < [self.weekdays count]; i++) {
        
        NSDate *date = [self.weekdays objectAtIndex:i];
		
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
        NSInteger weekday = [weekdayComponents weekday];
        [gregorian release];
        NSString *weeday =[weekdaySymbols objectAtIndex:weekday-1];
        
        switch (i) {
            case 0:
                [monButton1 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 1:
                [tueButton2 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 2:
                [wedButton3 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 3:
                [thrButton4 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 4:
                [friButton5 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 5:
                [satButton6 setTitle:weeday forState:UIControlStateNormal];
                break;
            case 6:
                [sunButton7 setTitle:weeday forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}






#pragma mark -- DataBase Methods

- (BOOL)findContact:(NSNumber*)questionId
{
    const char *dbpath = [databasePath UTF8String];
    
    BOOL isFind = NO;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        
        NSInteger sub1ID = [questionId integerValue];
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT subId FROM SUB1EVENT WHERE subId=\"%d\"", sub1ID];
        
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

-(void)updateIntDatabase:(NSDictionary*)recordsDic {
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    NSString* str = [formatter stringFromDate:[NSDate date]];
    
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subId = [[recordsDic valueForKey:kSub1Id] integerValue];
        
        NSString *query=[NSString stringWithFormat:@"UPDATE SUB1EVENT SET date='%@', startDate='%@', endDate='%@', status='%@', dayDate='%@', eventDescription='%@' WHERE subId='%d'",str, [recordsDic valueForKey:kStartDate],[recordsDic valueForKey:kEndDate],[recordsDic valueForKey:kStatus],[recordsDic valueForKey:kDayTime],[recordsDic valueForKey:kEventDes],subId];
        
        const char *del_stmt = [query UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Updated");

        }else {
            NSLog(@"Failed to Update");
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
        }
        
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(exerciseDB);
}



-(void)insertIntoDatabase:(NSDictionary*)recordDic {
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"MMM d YYYY HH:mm:ss"];
    NSString* str = [formatter stringFromDate:[NSDate date]];
    
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subId = [[recordDic valueForKey:kSub1Id] integerValue];
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SUB1EVENT (subId,date,startDate,endDate,status,dayDate,eventDescription) VALUES (\"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",subId,str,[recordDic valueForKey:kStartDate],[recordDic valueForKey:kEndDate],[recordDic valueForKey:kStatus],[recordDic valueForKey:kDayTime],[recordDic valueForKey:kEventDes]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"New Record Created");
        }
        else {
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
            NSLog(@"error for insertig data into database NO");
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}


-(void)deleteRecord:(NSDictionary*)deleDic {
    
    if (sqlite3_open([databasePath UTF8String], &exerciseDB) == SQLITE_OK) {
        
        NSInteger subId = [[deleDic valueForKey:kSub1Id] integerValue];
        
        NSString *sql = [NSString stringWithFormat: @"DELETE FROM SUB1EVENT WHERE subId='%d'",subId];
        
        const char *del_stmt = [sql UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, & statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_ROW) {
            
            NSLog(@"sss");
            
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
}



-(void)databaseInsert {
    
    for (int i = 0; i < [dataArray count]; i++) {
        
        NSDictionary *dataDic = [dataArray objectAtIndex:i];
        
        if ([self findContact:[dataDic valueForKey:kSub1Id]]) {
            NSLog(@"Updating");
            [self updateIntDatabase:dataDic];
        }else {
            NSLog(@"New Record");
            [self insertIntoDatabase:dataDic];
        }
    }
}


#pragma mark SUB1TOTAL DATA BASE METHODS

- (BOOL)findContactTotal:(NSNumber*)questionId {
    
    const char *dbpath = [databasePath UTF8String];
    
    BOOL isFind = NO;
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger sub1TID = [questionId integerValue];
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT subTId FROM SUB1TOTAL WHERE subTId=\"%d\"", sub1TID];
        
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

-(void)updateIntDatabaseT:(NSDictionary*)updateDic {
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subTId = [[updateDic valueForKey:kTSub1Id] integerValue];
        
        NSString *query=[NSString stringWithFormat:@"UPDATE SUB1TOTAL SET date='%@', total='%@' WHERE subTId='%d'",[updateDic valueForKey:kTDate], [updateDic valueForKey:kTTotal],subTId];
        
        const char *del_stmt = [query UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, del_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"Updated");
            
        }else {
            NSLog(@"Failed to Update");
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
        }
        
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(exerciseDB);
    
}

-(void)insertIntoDatabaseT:(NSDictionary*)recordDic
{
   
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &exerciseDB) == SQLITE_OK)
    {
        NSInteger subId = [[recordDic valueForKey:kTSub1Id] integerValue];
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SUB1TOTAL (subTId,date,total) VALUES (\"%d\", \"%@\", \"%@\")",subId,[recordDic valueForKey:kTDate],[recordDic valueForKey:kTTotal]];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(exerciseDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"New Record Created");
        }
        else {
            if(SQLITE_DONE != sqlite3_step(statement))
                NSLog(@"Error while updating. %s", sqlite3_errmsg(exerciseDB));
            NSLog(@"error for insertig data into database NO");
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(exerciseDB);
    
}

-(void)deleteRecordT:(NSDictionary*)deleDic {
    
}


-(void)databaseInsertTotal {
    NSLog(@"%@",self.totalDataArray);
    for (int i = 0; i < [self.totalDataArray count]; i++) {
        
        NSDictionary *dataDic = [self.totalDataArray objectAtIndex:i];
        
        if ([self findContactTotal:[dataDic valueForKey:kTSub1Id]]) {
            NSLog(@"Updating");
            [self updateIntDatabaseT:dataDic];
        }else {
            NSLog(@"New Record");
            [self insertIntoDatabaseT:dataDic];
        }
    }
}


#pragma mark UITextField Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y - 60, self.popupView.frame.size.width, self.popupView.frame.size.height)];
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.popupView setFrame:CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y + 60, self.popupView.frame.size.width, self.popupView.frame.size.height)];
}

-(void)textViewDidEndEditing:(UITextView *)textView {

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    [textField addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
    
    return YES;
}


-(void)changeText:(UITextField*)textField {
    
    if (textField == hoursTextField1) {
        if ([textField.text integerValue] >= 24) {
            hoursTextField2.text = @"00";
        }
        else {
            int h1 = [textField.text integerValue];
            h1 += 1;
            hoursTextField2.text = [NSString stringWithFormat:@"%.2i",h1];
        }
    }
    if (textField == mintsTextField1) {
        mintsTextField2.text = mintsTextField1.text;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
