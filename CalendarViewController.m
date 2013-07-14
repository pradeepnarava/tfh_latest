//
//  CalendarViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "CalendarViewController.h"
#import "SettingRegistViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "MJPopupBackgroundView.h"
#import "EventPopOverViewController.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

static const unsigned int DAYS_IN_WEEK                        = 7;

@interface CalendarViewController ()
@end

@implementation CalendarViewController
@synthesize scrollView;
@synthesize settingRegViewCntrl;
@synthesize monLabel1,tueLabel2,wedLabel3,thrLabel4,friLabel5,satLabel6,sunLabel7;
@synthesize monButton1,tueButton2,wedButton3,thrButton4,friButton5,satButton6,sunButton7;
@synthesize dateArray,weekdays,week;
@synthesize mainWeekLabel;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [scrollView setContentSize:CGSizeMake(320, 770)];
    
    
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
    
    [self week:[NSDate date]];
    
    
    
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
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EXERCISE6 (ID INTEGER PRIMARY KEY AUTOINCREMENT,DATE TEXT,WEEK TEXT,STARTDATE TEXT,ENDDATE TEXT,ENDDATE TEXT,STATUS TEXT,DAYDATE TEXT)";
        
        if (sqlite3_exec(exerciseDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            NSLog(@"Failed to create database");
        }
        
        sqlite3_close(exerciseDB);
        
    } else {
        //status.text = @"Failed to open/create database";
    }
}

-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark SettingViewController

-(void)settButtonClicked {

    if (!settingRegViewCntrl) {
        settingRegViewCntrl = [[SettingRegistViewController alloc] initWithNibName:@"SettingRegistView" bundle:nil];
    }
    [self.navigationController pushViewController:settingRegViewCntrl animated:YES];
}


#pragma mark Calendar Empty Cell

-(IBAction)calendarEmptyCellClicked:(id)sender
{
    //UIButton *button = (UIButton*)[sender tag];
    NSLog(@"button tag is %i",[sender tag]);
    EventPopOverViewController *evntViewCntrl = [[EventPopOverViewController alloc] initWithNibName:@"EventPopOverView" bundle:nil];
     [self presentPopupViewController:evntViewCntrl animationType:MJPopupViewAnimationSlideBottomBottom];
}

#pragma mark TotalButtonClicked 

-(IBAction)totalButtonClicked:(id)sender
{
    //UIButton *button = (UIButton*)[sender tag];
    NSLog(@"button tag is %i",[sender tag]);

}

#pragma mark Calendar Day Button Clicked
-(IBAction)calendarDayCellClicked:(id)sender
{
    
    UIButton *button = (UIButton*)[sender tag];
    NSLog(@"button tag is %i",[button tag]);
    
}


#pragma mark Calendar 

- (IBAction)forwardCalendar:(id)sender
{
    
}

- (IBAction)backwardCalender:(id)sender
{
    
    
}


- (NSString *)titleText {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self.week];
	
	NSArray *monthSymbols = [formatter shortMonthSymbols];
	
	return [NSString stringWithFormat:@"%@, week %i",
			[monthSymbols objectAtIndex:[components month] - 1],
			[components week]];
}



- (NSDate *)firstDayOfWeekFromDate:(NSDate *)date {
	CFCalendarRef currentCalendar = CFCalendarCopyCurrent();
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
	[components setDay:([components day] - ([components weekday] - CFCalendarGetFirstWeekday(currentCalendar)))];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	CFRelease(currentCalendar);
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (void)week:(NSDate *)_date {
    
	NSDate *firstOfWeek = [self firstDayOfWeekFromDate:_date];
	self.week = firstOfWeek;
    
    NSDate *date = self.week;
	NSDateComponents *components;
	NSDateComponents *components2 = [[NSDateComponents alloc] init];
	[components2 setDay:1];
	
	self.weekdays = [[NSMutableArray alloc] init];
	
	for (register unsigned int i=0; i < DAYS_IN_WEEK; i++) {
		[self.weekdays addObject:date];
		components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
		[components setDay:1];
		date = [CURRENT_CALENDAR dateByAddingComponents:components2 toDate:date options:0];
	}
	
    NSLog(@"%@",self.weekdays);
	[self updateScreens];
    self.mainWeekLabel.text = [self titleText];
}



-(void)updateScreens {
    
	for (int i =0; i < [self.weekdays count]; i++) {
        
        NSDate *date = [self.weekdays objectAtIndex:i];
		NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
		NSString *displayText = [NSString stringWithFormat:@"%i",[components day]];
        
        if (i == 0) {
            monLabel1.text = displayText;
        }else if (i==1){
            tueLabel2.text = displayText;
        }else if (i ==2){
            wedLabel3.text = displayText;
        }else if (i ==3){
            thrLabel4.text = displayText;
        }else if (i == 4){
            friLabel5.text = displayText;
        }else if (i == 5){
            satLabel6.text = displayText;
        }else if (i == 6) {
            sunLabel7.text = displayText;
        }
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
