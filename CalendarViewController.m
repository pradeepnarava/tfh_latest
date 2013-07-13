//
//  CalendarViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "CalendarViewController.h"
#import "SettingRegistViewController.h"

@interface CalendarViewController () {
    
    NSDate* currentDate;
    NSMutableArray *dateArray;
    NSDateFormatter *dateFormatter;
    NSDateFormatter *dateOfDay;
    NSDateFormatter *day;
    NSDateFormatter *topDate;
    NSDateFormatter *year;
    NSDateFormatter *hour;

}

@end

@implementation CalendarViewController
@synthesize scrollView;
@synthesize settingRegViewCntrl;
@synthesize monLabel1,tueLabel2,wedLabel3,thrLabel4,friLabel5,satLabel6,sunLabel7;
@synthesize monButton1,tueButton2,wedButton3,thrButton4,friButton5,satButton6,sunButton7;
@synthesize dateArray;



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
    
    [scrollView setContentSize:CGSizeMake(320, 726)];
    
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
    
    
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    dateOfDay = [[NSDateFormatter alloc]init];
    [dateOfDay setDateStyle:NSDateFormatterNoStyle];
    [dateOfDay setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    [dateOfDay setDateFormat:@"dd"];
    [dateOfDay setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    day = [[NSDateFormatter alloc]init];
    [day setDateStyle:NSDateFormatterNoStyle];
    [day setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    [day setDateFormat:@"EEE"];
    [day setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    topDate = [[NSDateFormatter alloc]init];
    [topDate setDateStyle:NSDateFormatterNoStyle];
    [topDate setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    [topDate setDateFormat:@"dd MMM"];
    [topDate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    year = [[NSDateFormatter alloc]init];
    [year setDateStyle:NSDateFormatterNoStyle];
    [year setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    [year setDateFormat:@"yyyy"];
    [year setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    hour = [[NSDateFormatter alloc]init];
    [hour setDateStyle:NSDateFormatterNoStyle];
    [hour setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    [hour setDateFormat:@"HH"];
    [hour setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    //[self setDate];
    
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
    UIButton *button = (UIButton*)[sender tag];
    NSLog(@"button tag is %i",button.tag);
    
    
    
}

#pragma mark TotalButtonClicked 

-(IBAction)totalButtonClicked:(id)sender
{
    
    UIButton *button = (UIButton*)[sender tag];
    NSLog(@"button tag is %i",button.tag);
    
    
}

#pragma mark Calendar Day Button Clicked
-(IBAction)calendarDayCellClicked:(id)sender
{
    
    UIButton *button = (UIButton*)[sender tag];
    NSLog(@"button tag is %i",button.tag);
    
}


#pragma mark Calendar 

- (IBAction)forwardCalendar:(id)sender
{
    
}


- (IBAction)backwardCalender:(id)sender
{
    
}



/*-(void)setDate
{
    
    dateArray = [[NSMutableArray alloc]init];
    
    for (int i =1; i <= 7; i++)
    {
        if (viewLoad)
        {
            currentDate = [NSDate date];
        }
        else
        {
            currentDate = [dateFormatter dateFromString: lastDate];
        }
        NSDateComponents *comps1 = [[NSDateComponents alloc] init];
        [comps1 setMonth:0];
        [comps1 setDay:+i];
        [comps1 setHour:0];
        NSCalendar *calendar1 = [NSCalendar currentCalendar];
        NSDate *newDate1 = [calendar1 dateByAddingComponents:comps1 toDate:currentDate options:0];
        [dateArray addObject:newDate1];
    }
    
    [self updateScreen];
}

-(void)updateScreen
{
    firstDateLabel.text = [dateOfDay stringFromDate:[dateArray objectAtIndex:0]];
    secondDateLabel.text = [dateOfDay stringFromDate:[dateArray objectAtIndex:1]];
    thirdDateLabel.text = [dateOfDay stringFromDate:[dateArray objectAtIndex:2]];
    fourthDateLabel.text = [dateOfDay stringFromDate:[dateArray objectAtIndex:3]];
    fifthDateLabel.text = [dateOfDay stringFromDate:[dateArray objectAtIndex:4]];
    sixthDateLabel.text = [dateOfDay stringFromDate:[dateArray objectAtIndex:5]];
    seventhDateLabel.text = [dateOfDay stringFromDate:[dateArray objectAtIndex:6]];
    
    [dayButton1 setTitle:[day stringFromDate:[dateArray objectAtIndex:0]] forState:UIControlStateNormal];
    [dayButton2 setTitle:[day stringFromDate:[dateArray objectAtIndex:1]] forState:UIControlStateNormal];
    [dayButton3 setTitle:[day stringFromDate:[dateArray objectAtIndex:2]] forState:UIControlStateNormal];
    [dayButton4 setTitle:[day stringFromDate:[dateArray objectAtIndex:3]] forState:UIControlStateNormal];
    [dayButton5 setTitle:[day stringFromDate:[dateArray objectAtIndex:4]] forState:UIControlStateNormal];
    [dayButton6 setTitle:[day stringFromDate:[dateArray objectAtIndex:5]] forState:UIControlStateNormal];
    [dayButton7 setTitle:[day stringFromDate:[dateArray objectAtIndex:6]] forState:UIControlStateNormal];
    
    
    sendDate = [topDate stringFromDate:[dateArray objectAtIndex:0]];
    NSString *labelString = [NSString stringWithFormat:@"%@ to %@ %@",[topDate stringFromDate:[dateArray objectAtIndex:0]],[topDate stringFromDate:[dateArray objectAtIndex:6]],[year stringFromDate:[dateArray objectAtIndex:6]]];
    
    monthLabel.text = labelString;
}

-(void)dateForCalender
{
    NSString *dateStr = @"2010may23";
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMMdd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
    dateStr = [dateFormat stringFromDate:date];
}

*/




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
