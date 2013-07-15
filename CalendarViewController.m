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
@synthesize currentButtonStatus;



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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertData) name:@"InsertData" object:nil];
    
}



-(void)insertData {
    
    
    [currentButtonStatus setTitle:@"Goapl" forState:UIControlStateNormal];
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
    currentButtonStatus = [[UIButton alloc] init];
    currentButtonStatus = (UIButton*)[sender tag];
    NSLog(@"button tag is %i",[sender tag]);
    //currentButtonStatus = button;
    EventPopOverViewController *evntViewCntrl = [[EventPopOverViewController alloc] initWithNibName:@"EventPopOverView" bundle:nil];
    
    
     [self presentPopupViewController:evntViewCntrl animationType:MJPopupViewAnimationSlideBottomBottom];
}

#pragma mark TotalButtonClicked 

-(IBAction)totalButtonClicked:(id)sender
{
    UIButton *button = (UIButton*)sender;
    NSLog(@"button tag is %i",[button tag]);

}

#pragma mark Calendar Day Button Clicked
-(IBAction)calendarDayCellClicked:(id)sender
{
    
    UIButton *button = (UIButton*)sender;
    NSLog(@"button tag is %i",[button tag]);
    
}


#pragma mark Calendar 



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
    
    self.week = _date;
    
    self.weekdays = [[NSMutableArray alloc] init];
    
    for (int i =1; i <= 7; i++)
    {
        NSDateComponents *comps1 = [[NSDateComponents alloc] init];
        [comps1 setMonth:0];
        [comps1 setDay:+i];
        [comps1 setHour:0];
        NSCalendar *calendar1 = [NSCalendar currentCalendar];
        NSDate *newDate1 = [calendar1 dateByAddingComponents:comps1 toDate:[NSDate date] options:0];
        [self.weekdays addObject:newDate1];
    }
    
    NSLog(@"%@",self.weekdays);
    
	[self updateScreens];
    self.mainWeekLabel.text = [self titleText];
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
