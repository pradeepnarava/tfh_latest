//
//  SettingRegistViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "SettingRegistViewController.h"
#import "SettingsData.h"

#define kOnOff @"onoff"
#define ktag @"tag"
#define konetimer @"onetimereminder"
#define kstarttime @"starttime"
#define kendtime @"endtime"
#define ktotaltime @"totaltime"
#define ktotalonoff @"totalonoff"

#define kYYYYMMDDHHMM @"yyyy-MM-dd HH:mm"
#define kHHMMSS @"HH:mm"

@interface SettingRegistViewController ()
{
    UIDatePicker *timePicker;
    UIActionSheet *actionSheet;
    IBOutlet UIButton *oneHourButton,*twoHourButton,*threeHourButton,*sixHourButton;
    IBOutlet UIButton *startTimeButton;
    IBOutlet UIButton *stopTimeButton;
    IBOutlet UIButton *totalTimeButton;
    IBOutlet UILabel *oneTimeNotificationLabel,*totalLabel;
    NSString *hoursTimeString;
}

@property (nonatomic,strong)   NSString *hoursTimeString;
@property (nonatomic,strong)   NSMutableArray *settingsArray;

@end

@implementation SettingRegistViewController
@synthesize popupScrollView;
@synthesize hoursTimeString;
@synthesize settingsArray;


int hoursValue;
int tagValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark ViewLifeCycle


-(void)settData {
    SettingsData *sharedData = [SettingsData sharedData];
    
    for (int i = 0; i < [sharedData count]; i ++) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        NSDictionary *dic = [sharedData objectAtIndex:i];
        NSArray *keys = [dic allKeys];
        for (int j =0; j < [keys count]; j++) {
            [tempDic setValue:[dic objectForKey:[keys objectAtIndex:j]] forKey:[keys objectAtIndex:j]];
        }
        
        [settingsArray addObject:tempDic];
    }
    NSLog(@"%@",settingsArray);
}



-(void)screens {
    NSLog(@"%@",settingsArray);
    if (([[[settingsArray objectAtIndex:0] valueForKey:kOnOff] isEqualToString:@"YES"])) {
        
        if ([[[settingsArray objectAtIndex:1] valueForKey:ktag] isEqualToString:@"1"]) {
            [oneHourButton setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        }
        if ([[[settingsArray objectAtIndex:1] valueForKey:ktag] isEqualToString:@"2"]) {
            [oneHourButton setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        }
        if ([[[settingsArray objectAtIndex:1] valueForKey:ktag] isEqualToString:@"3"]) {
            [oneHourButton setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        }
        if ([[[settingsArray objectAtIndex:1] valueForKey:ktag] isEqualToString:@"6"]) {
            [oneHourButton setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        }
        
        if ([[settingsArray objectAtIndex:1] valueForKey:konetimer]) {
            NSArray *te =[[[settingsArray objectAtIndex:1] valueForKey:konetimer] componentsSeparatedByString:@":"];
            
            NSString *text = [NSString stringWithFormat:@"%@ hrs %@ mins", [te objectAtIndex:0], [te objectAtIndex:1]];
            oneTimeNotificationLabel.text = text;
        }
        
        if ([[settingsArray objectAtIndex:2] valueForKey:kstarttime]) {
            [startTimeButton setTitle:[[settingsArray objectAtIndex:2] valueForKey:kstarttime] forState:UIControlStateNormal];
        }
        if ([[settingsArray objectAtIndex:2] valueForKey:kendtime]) {
            
            [stopTimeButton setTitle:[[settingsArray objectAtIndex:2] valueForKey:kendtime] forState:UIControlStateNormal];
        }
    }else {
        self.popupScrollView.hidden = YES;
    }
    
    if ([[[settingsArray objectAtIndex:3] valueForKey:ktotalonoff] isEqualToString:@"YES"]) {
        NSLog(@"total time is ^^^^ %@",[[settingsArray objectAtIndex:3] valueForKey:ktotaltime]);
        [totalTimeButton setTitle:[[settingsArray objectAtIndex:3] valueForKey:ktotaltime] forState:UIControlStateNormal];

    }else {
        totalTimeButton.hidden = YES;
        totalLabel.hidden = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.popupScrollView setContentSize:CGSizeMake(320, 430)];
    hoursTimeString = [[NSString alloc] init];
    settingsArray = [[NSMutableArray alloc]init];
    [self settData];
    [self screens];
    self.title = @"Settings";
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



#pragma mark ON--OFF Button 

-(void)ad {
    //for (int i =0; i < [settingsArray count]; i++) {
        NSMutableDictionary *tem = [[settingsArray objectAtIndex:0] mutableCopy];
        
        [tem setValue:@"YES" forKey:kOnOff];
        
        //[settingsArray writeToFile:[[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"] atomically:YES];
   // }
    NSLog(@"seett %@",settingsArray);
    
}

-(IBAction)onoffButtonClicked:(id)sender {
    
    if ([sender tag] == 10) {
        popupScrollView.hidden = NO;
        [self ad];
        [self screens];
    }
    else if ([sender tag]==11) {
        popupScrollView.hidden = YES;
    }else if ([sender tag] == 15){
        totalTimeButton.hidden = NO;
        totalLabel.hidden = NO;
    }else if ([sender tag] == 16) {
        totalLabel.hidden = YES;
        totalTimeButton.hidden = YES;
    }
}


-(void)oneTime {
    
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
    lblTitle.text = @"En gång om dagen kl";
    lblTitle.textAlignment = UITextAlignmentCenter;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:lblTitle];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone	 target:self action:@selector(dismissActionSheet)];
    
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(applyBrightness)];
    
    
    
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *items = [NSArray arrayWithObjects: cancelButton,flexibleSpace1,item,flexibleSpace2,applyButton,nil];
    [toolbar setItems:items animated:YES];
    

    timePicker = [[UIDatePicker alloc]init];
    timePicker.frame = CGRectMake(0,44, 320, 216);
    timePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    [timePicker addTarget:self action:@selector(dateAction:) forControlEvents:UIControlEventValueChanged];
    
    actionSheet = [[UIActionSheet alloc] init];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 500)];
    [actionSheet addSubview:toolbar];
    [actionSheet addSubview:timePicker];
    
}

- (void)dateAction:(id)sender
{
    NSLog(@"%f", timePicker.countDownDuration);
}


-(void)applyBrightness
{
    int secs = timePicker.countDownDuration;
    int h = secs / 3600;
    int m = secs / 60 % 60;
    
    NSString *text = [NSString stringWithFormat:@"%02d hrs %02d mins", h, m];

    oneTimeNotificationLabel.text = text;
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


-(IBAction)hourSelected:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    hoursValue = btn.tag;
    hoursTimeString = btn.titleLabel.text;
    NSLog(@"selectedCheckButton tag is %i",btn.tag);
    
    for (UIButton *radioButton in [self.popupScrollView  subviews]) {
        if (radioButton.tag != btn.tag && [radioButton isKindOfClass:[UIButton class]]) {
            if ((radioButton.tag == 20 || radioButton.tag == 21 || radioButton.tag == 22 || radioButton.tag == 23 || radioButton.tag == 24)) {
                [radioButton setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            }
            
        }
    }
    
    [btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
    if (btn.tag == 24) {
        [self oneTime];
    }
}

-(IBAction)kalrButtonClicked:(id)sender {
    
    if (([startTimeButton.titleLabel.text length]>0 && [stopTimeButton.titleLabel.text length] >0) && !([startTimeButton.titleLabel.text isEqualToString:@"starttime"] && [stopTimeButton.titleLabel.text isEqualToString:@"stoptime"])) {
        [self localNotification1:[hoursTimeString intValue]];
    }
    if ([totalTimeButton.titleLabel.text length] > 0 && !([totalTimeButton.titleLabel.text isEqualToString:@"totaltime"])) {
        [self   localNotificationTotal];
    }
}


//static NSString *startTimeStr = @"2013-07-19 03:40:00";
//static NSString *endTimeStr = @"2013-07-19 06:40:00";
//static NSString *kRemindMeNotificationDataKey = @"kRemindMeNotificationDataKey";


-(NSDate *)localDateAndTime:(NSString*)time{
    NSLog(@"%@",time);
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *todayDate = [NSString stringWithFormat:@"%@ %@",[_dateFormatter stringFromDate:[NSDate date]],time];
    [_dateFormatter setDateFormat:kYYYYMMDDHHMM];
    NSDate *todayTime = [_dateFormatter dateFromString:todayDate];
    
    return todayTime;
}


-(void)localNotification1:(int)hours {

    if ([startTimeButton.titleLabel.text length] >0 && [stopTimeButton.titleLabel.text length]>0  && !([startTimeButton.titleLabel.text isEqualToString:@"starttime"] && [stopTimeButton.titleLabel.text isEqualToString:@"stoptime"])) {
        
        NSDate *sTime = [self localDateAndTime:startTimeButton.titleLabel.text];
        NSDate *eTime = [self localDateAndTime:stopTimeButton.titleLabel.text];
        
        while ([eTime compare:[sTime dateByAddingTimeInterval:hours*60*60]] == NSOrderedDescending ||[eTime compare:[sTime dateByAddingTimeInterval:hours*60*60]] == NSOrderedSame ) {
            NSLog(@"%@",sTime);
            
            UILocalNotification *notif = [[UILocalNotification alloc] init];
            notif.fireDate = sTime;
            notif.soundName = UILocalNotificationDefaultSoundName;
            notif.repeatInterval = NSDayCalendarUnit;
            notif.alertBody = @"Reminder";
            notif.alertAction = @"Will show notif from calendar DB after 1 hour";
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notif];
            
            sTime = [sTime dateByAddingTimeInterval:hours*60*60];
        }
    }
}

-(void)localNotificationTotal {
    
    if ([totalTimeButton.titleLabel.text length] > 0 && !([totalTimeButton.titleLabel.text isEqualToString:@"totaltime"])) {
    
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        notif.fireDate = [self localDateAndTime:totalTimeButton.titleLabel.text];
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.repeatInterval = NSDayCalendarUnit;
        notif.alertBody = @"Reminder";
        notif.alertAction = @"Will show notif from calendar DB after 1 hour";
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
}

#pragma mark Start Button Clicked

-(IBAction)startTimeButton:(id)sender
{
    tagValue = [sender tag];
    UIButton *but = (UIButton *)sender;
    
    [self createDatePicker:but];
}

#pragma mark Stop Button Clicked 

-(IBAction)endTimeButton:(id)sender {
    tagValue = [sender tag];
    UIButton *but = (UIButton *)sender;
    
    [self createDatePicker:but];
}


#pragma mark TotalTimeButton Clicked

-(IBAction)totalTimeButton:(id)sender {
    tagValue = [sender tag];
    
    UIButton *but = (UIButton*)sender;
    
    [self createDatePicker:but];
}




-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(NSString *)stringFromDateTimes:(NSDate*)_date{
    
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:kYYYYMMDDHHMM];
    NSString *currentDate = [_dateFormatter stringFromDate:_date];
    NSArray *timer = [currentDate componentsSeparatedByString:@" "];
    return [timer objectAtIndex:1];
}


#pragma mark Create DateTimePicker

-(void)createDatePicker:(UIButton*)button  {
    
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

    lblTitle.textAlignment = UITextAlignmentCenter;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:lblTitle];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone	 target:self action:@selector(dismissActionSheet)];
    
    UIBarButtonItem *applyButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(applyTime)];
    
    
    UIBarButtonItem *flexibleSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *flexibleSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *items = [NSArray arrayWithObjects: cancelButton,flexibleSpace1,item,flexibleSpace2,applyButton,nil];
    [toolbar setItems:items animated:YES];
    
    timePicker = [[UIDatePicker alloc]init];
    timePicker.frame = CGRectMake(0,44, 320, 216);
    timePicker.datePickerMode = UIDatePickerModeTime;
    
    if (button.tag == 12) {
        if ([startTimeButton.titleLabel.text length] > 0) {
            //timePicker.date = [self dateFromString:startTimeButton.titleLabel.text];
        }
        lblTitle.text = @"Första påminnelsen";
    }else if (button.tag == 13) {
        if ([stopTimeButton.titleLabel.text length] > 0) {
            // timePicker.date = [self dateFromString:stopTimeButton.titleLabel.text];
        }
        lblTitle.text = @"Sista påminnelsen";
    }else if (button.tag == 14){
        
    }
    
    actionSheet = [[UIActionSheet alloc] init];
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 500)];
    [actionSheet addSubview:toolbar];
    [actionSheet addSubview:timePicker];

}

-(void)applyTime
{
    if (tagValue == 12) {
        [startTimeButton setTitle:[self stringFromDateTimes:timePicker.date] forState:UIControlStateNormal];
    }else if (tagValue == 13) {
        [stopTimeButton setTitle:[self stringFromDateTimes:timePicker.date] forState:UIControlStateNormal];
    }else if (tagValue == 14) {
        [totalTimeButton setTitle:[self stringFromDateTimes:timePicker.date] forState:UIControlStateNormal];
    }
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


-(void)dismissActionSheet
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
