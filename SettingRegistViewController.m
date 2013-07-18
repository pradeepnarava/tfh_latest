//
//  SettingRegistViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "SettingRegistViewController.h"

@interface SettingRegistViewController ()
{
    UIDatePicker *timePicker;
    UIActionSheet *actionSheet;
    IBOutlet UIButton *startTimeButton;
    IBOutlet UIButton *stopTimeButton;
}

@end

@implementation SettingRegistViewController
@synthesize popupScrollView;



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
    [self sampleData];
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

}

-(IBAction)onoffButtonClicked:(id)sender {
    if ([sender tag] == 10) {
        popupScrollView.hidden = NO;
    }
    else if ([sender tag]==11) {
        popupScrollView.hidden = YES;
    }
}


-(IBAction)hourSelected:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"selectedCheckButton tag is %i",btn.tag);
    
    for (UIButton *radioButton in [popupScrollView  subviews]) {
        if (radioButton.tag != btn.tag && [radioButton isKindOfClass:[UIButton class]] &&  radioButton.tag == 20 && radioButton.tag == 21 && radioButton.tag == 22 && radioButton.tag == 23 ) {
            [radioButton setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        }
    }
    
    [btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
}




static NSString *startTimeStr = @"2013-07-18 21:40:00";
static NSString *endTimeStr = @"2013-07-18 23:40:00";
static NSString *kRemindMeNotificationDataKey = @"kRemindMeNotificationDataKey";


-(NSDate*)dateFromStr:(NSString*)str {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *currentDate = [dateFormatter dateFromString:str];
    
    return currentDate;
}


-(void)sampleData {
    
    NSDate *sTime = [self dateFromStr:startTimeStr];
    NSDate *eTime = [self dateFromStr:endTimeStr];
    
    while ([eTime compare:[sTime dateByAddingTimeInterval:1*60*60]] == NSOrderedDescending ||[eTime compare:[sTime dateByAddingTimeInterval:1*60*60]] == NSOrderedSame ) {
        NSLog(@"%@",sTime);
        
        Class cls = NSClassFromString(@"UILocalNotification");
        if (cls != nil) {
            
           /* UILocalNotification *notif = [[cls alloc] init];
            notif.fireDate = sTime;
            notif.timeZone = [NSTimeZone defaultTimeZone];
            
            notif.alertBody = @"Testing Local Notification";
            notif.alertAction = @"Will show notif from calendar DB after 1 hour";
            notif.soundName = UILocalNotificationDefaultSoundName;
            
            notif.repeatInterval = NSDayCalendarUnit;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notif];
            [notif release];*/
            sTime = [sTime dateByAddingTimeInterval:1*60*60];
        }
    }
    
}


-(IBAction)startTimeButton:(id)sender
{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    toolbar.backgroundColor = [UIColor clearColor];
    toolbar.opaque = NO;
    toolbar.translucent = YES;
    toolbar.frame = CGRectMake(0,0, 320, 44);
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(60,2,200, 40)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont boldSystemFontOfSize:18];
    lblTitle.text = @"Första påminnelsen";
    lblTitle.textAlignment = UITextAlignmentCenter;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:lblTitle];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone	 target:self action:@selector(dismissActionSheet)];
    
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(applyStartTime)];
    
    
    
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *items = [NSArray arrayWithObjects: cancelButton,flexibleSpace1,item,flexibleSpace2,applyButton,nil];
    [toolbar setItems:items animated:YES];
    
    
    
    timePicker = [[UIDatePicker alloc]init];
    timePicker.frame = CGRectMake(0,44, 320, 216);
    timePicker.datePickerMode = UIDatePickerModeTime;
    //timePicker.date = [dateFormatter dateFromString:startTimeButton.titleLabel.text];
    
    
    
    actionSheet = [[UIActionSheet alloc] init];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 500)];
    [actionSheet addSubview:toolbar];
    [actionSheet addSubview:timePicker];
    //timePicker.date = [dateFormatter dateFromString:startTimeButton.titleLabel.text];
    
    
}


-(IBAction)endTimeButton:(id)sender {
    
}


-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
