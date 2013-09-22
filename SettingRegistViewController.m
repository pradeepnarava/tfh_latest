//
//  SettingRegistViewController.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 12/07/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "SettingRegistViewController.h"
#import "Va_lkommenAppDelegate.h"


#define kEVENTONOFF @"EVENTONOFF"
#define kHOURSTAG @"HOURSTAG"
#define kONEDAY @"ONEDAY"
#define kSTARTTIME @"STARTTIME"
#define kENDTIME @"ENDTIME"
#define kTOTALTIME @"TOTALTIME"
#define kTOTALONOFF @"TOTALONOFF"


#define kEventNotificationDataKey @"EventNotification"
#define kTotalNotificationDataKey @"TotalNotification"

#define kYYYYMMDDHHMM @"yyyy-MM-dd HH:mm"
#define kHHMMSS @"HH:mm"

@interface SettingRegistViewController ()
{
    UIDatePicker *timePicker;
    UIActionSheet *actionSheet;
    IBOutlet UIButton *oneHourButton,*twoHourButton,*threeHourButton,*sixHourButton,*oneDayTimeButton;
    IBOutlet UIButton *startTimeButton;
    IBOutlet UIButton *stopTimeButton;
    IBOutlet UIButton *totalTimeButton;
    IBOutlet UIButton *eventButton,*totalButton;
    IBOutlet UILabel *oneTimeNotificationLabel,*totalLabel;
    IBOutlet UILabel *oneHrLabel,*twoHrLabel,*threeHrLabel,*sixHrLabel,*oneTimeToDayLabel;
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



-(void)eventScreens {

    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:kHOURSTAG]);
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:kEVENTONOFF]) {
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:kHOURSTAG] isEqualToString:@"1"]) {
            [oneHourButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        }else {
            [oneHourButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        }
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:kHOURSTAG] isEqualToString:@"2"]) {
            [twoHourButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        }else {
            [twoHourButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        }
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:kHOURSTAG] isEqualToString:@"3"]) {
            [threeHourButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        }else {
            [threeHourButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        }
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:kHOURSTAG] isEqualToString:@"6"]) {
            [sixHourButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        }else {
            [sixHourButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        }
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:kHOURSTAG] isEqualToString:@"9"]) {
            if([[NSUserDefaults standardUserDefaults]objectForKey:kONEDAY]) {
               
                oneTimeNotificationLabel.text =[[NSUserDefaults standardUserDefaults]objectForKey:kONEDAY];
            }
        }
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:kSTARTTIME]) {
            
            [startTimeButton setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:kSTARTTIME] forState:UIControlStateNormal];
        }
        if ([[NSUserDefaults standardUserDefaults]objectForKey:kENDTIME]) {
            
            [stopTimeButton setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:kENDTIME] forState:UIControlStateNormal];
        }
    }
}

-(void)totalScreens {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kTOTALONOFF]) {
        NSLog(@"total time is ^^^^ %@",[[NSUserDefaults standardUserDefaults] objectForKey:kTOTALTIME]);
        [totalTimeButton setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:kTOTALTIME] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.popupScrollView setContentSize:CGSizeMake(320, 595)];
    
    hoursTimeString = [[NSString alloc] init];

    self.title = @"Påminnelser";
    
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

-(void)viewWillAppear:(BOOL)animated {

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kEVENTONOFF] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [self eventScreens];
        [self eventsShow];
    }else {

        [self eventsHidden];
    }
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:kTOTALONOFF] isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [self totalScreens];
        [self totalShow];
    }
    else {
        [self totalHidden];
    }
}



#pragma mark ON--OFF Button 

-(void)cancelEventUserDefaults {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:kEVENTONOFF]) {
        [userDefault setBool:NO forKey:kEVENTONOFF];
        [userDefault setValue:nil forKey:kHOURSTAG];
        [userDefault setValue:nil forKey:kONEDAY];
        [userDefault setValue:nil forKey:kSTARTTIME];
        [userDefault setValue:nil forKey:kENDTIME];
        [userDefault synchronize];
    }
}

-(void)cancelTotalUserDefaults {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    if ([userDefault objectForKey:kTOTALONOFF]) {
        [userDefault setBool:NO forKey:kTOTALONOFF];
        [userDefault synchronize];
    }
}

-(IBAction)onoffButtonClicked:(id)sender {
    
    if ([sender tag] == 10) {
        [self eventsShow];
        [popupScrollView reloadInputViews];
        [startTimeButton setTitle:@"" forState:UIControlStateNormal];
        [stopTimeButton setTitle:@"" forState:UIControlStateNormal];
    }
    else if ([sender tag]==11) {
        [self eventsHidden];
        [self cancelEventUserDefaults];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }else if ([sender tag] == 15){
        [self totalShow];
        [popupScrollView reloadInputViews];
        [totalTimeButton setTitle:@"" forState:UIControlStateNormal];
    }else if ([sender tag] == 16) {
        [self totalHidden];
        [self cancelTotalUserDefaults];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

-(void)eventsHidden {
    oneHourButton.hidden = YES;
    twoHourButton.hidden = YES;
    threeHourButton.hidden = YES;
    sixHourButton.hidden = YES;
    startTimeButton.hidden = YES;
    stopTimeButton.hidden =YES;
    oneHrLabel.hidden = YES;
    twoHrLabel.hidden = YES;
    threeHrLabel.hidden = YES;
    sixHrLabel.hidden =YES;
    oneTimeNotificationLabel.hidden =YES;
    oneTimeToDayLabel.hidden = YES;
    oneDayTimeButton.hidden = YES;
}



-(void)eventsShow {
    
    oneHourButton.hidden = NO;
    twoHourButton.hidden = NO;
    threeHourButton.hidden = NO;
    sixHourButton.hidden = NO;
    startTimeButton.hidden = NO;
    stopTimeButton.hidden =NO;
    oneHrLabel.hidden = NO;
    twoHrLabel.hidden = NO;
    threeHrLabel.hidden = NO;
    sixHrLabel.hidden =NO;
    oneTimeNotificationLabel.hidden =NO;
    oneTimeToDayLabel.hidden = NO;
    oneDayTimeButton.hidden = NO;
    
}



-(void)totalHidden {
    totalTimeButton.hidden =YES;    
}

-(void)totalShow {
    totalTimeButton.hidden = NO;
}


/*-(void)oneTime {
    
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
}*/



-(IBAction)hourSelected:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    hoursValue = btn.tag;
    hoursTimeString = btn.titleLabel.text;
    NSLog(@"selectedCheckButton tag is %i hoursTimeString %@",btn.tag, hoursTimeString);
    
    for (UIButton *radioButton in [self.popupScrollView  subviews]) {
        if (radioButton.tag != btn.tag && [radioButton isKindOfClass:[UIButton class]]) {
            if ((radioButton.tag == 20 || radioButton.tag == 21 || radioButton.tag == 22 || radioButton.tag == 23 || radioButton.tag == 24)) {
                [radioButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
            }
            
        }
    }
    
    [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    if (btn.tag == 24) {
        [self createDatePicker:btn];
    }
}



-(IBAction)kalrButtonClicked:(id)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (hoursValue == 24) {
        [self localNotification1:0];
        [userDefaults setBool:YES forKey:kEVENTONOFF];
        [userDefaults setValue:hoursTimeString forKey:kHOURSTAG];
        [userDefaults setValue:oneTimeNotificationLabel.text forKey:kONEDAY];
        [userDefaults setValue:nil forKey:kSTARTTIME];
        [userDefaults setValue:nil forKey:kENDTIME];
        [userDefaults synchronize];
    }
    else{
        if (([startTimeButton.titleLabel.text length]>0 && [stopTimeButton.titleLabel.text length] >0)) {
            [self localNotification1:[hoursTimeString intValue]];
            [userDefaults setBool:YES forKey:kEVENTONOFF];
            [userDefaults setValue:hoursTimeString forKey:kHOURSTAG];
            [userDefaults setValue:oneTimeNotificationLabel.text forKey:kONEDAY];
            [userDefaults setValue:startTimeButton.titleLabel.text forKey:kSTARTTIME];
            [userDefaults setValue:stopTimeButton.titleLabel.text forKey:kENDTIME];
            [userDefaults synchronize];
        }
        
    }
    
    if ([totalTimeButton.titleLabel.text length] > 0) {
        [self localNotificationTotal];
        [userDefaults setBool:YES forKey:kTOTALONOFF];
        [userDefaults setValue:totalTimeButton.titleLabel.text forKey:kTOTALTIME];
        [userDefaults synchronize];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    
    if (hoursValue == 24) {
    
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        notif.fireDate = [self localDateAndTime:oneTimeNotificationLabel.text];
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.repeatInterval = NSDayCalendarUnit;
        notif.alertBody = @"Påminnelser";
        notif.alertAction = @"View";
        notif.userInfo = [NSDictionary dictionaryWithObject:@"Event" forKey:kEventNotificationDataKey];
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];

    }
    else {
        if ([startTimeButton.titleLabel.text length] > 0 && [stopTimeButton.titleLabel.text length] > 0 &&( hoursValue == 20 ||hoursValue == 21 || hoursValue == 22 || hoursValue == 23)) {
          
            NSLog(@"start %@",startTimeButton.titleLabel.text);
            NSLog(@"start %@",stopTimeButton.titleLabel.text);
            
            NSDate *sTime = [self localDateAndTime:startTimeButton.titleLabel.text];
            NSDate *eTime = [self localDateAndTime:stopTimeButton.titleLabel.text];
            
            while ([eTime compare:sTime] == NSOrderedDescending ||[eTime compare:sTime] == NSOrderedSame ) {
                NSLog(@"jkfksdajdasfjlskdjflsd %@",sTime);
                
                UILocalNotification *notif = [[UILocalNotification alloc] init];
                notif.fireDate = sTime;
                notif.soundName = UILocalNotificationDefaultSoundName;
                notif.repeatInterval = NSDayCalendarUnit;
                notif.alertBody = @"Påminnelser";
                notif.alertAction = @"View";
                
                notif.userInfo = [NSDictionary dictionaryWithObject:@"Event" forKey:kEventNotificationDataKey];
                
                [[UIApplication sharedApplication] scheduleLocalNotification:notif];
                
                sTime = [sTime dateByAddingTimeInterval:hours*60*60];
            }
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please select at least one" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

-(void)localNotificationTotal {
    
    if ([totalTimeButton.titleLabel.text length] > 0 && !([totalTimeButton.titleLabel.text isEqualToString:@"totaltime"])) {
        
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        notif.fireDate = [self localDateAndTime:totalTimeButton.titleLabel.text];
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.repeatInterval = NSDayCalendarUnit;
        notif.alertBody = @"Påminnelser";
        notif.alertAction = @"View";
        notif.userInfo = [NSDictionary dictionaryWithObject:@"Total" forKey:kTotalNotificationDataKey];
        
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
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"da_US"];
    timePicker = [[UIDatePicker alloc]init];
    timePicker.frame = CGRectMake(0,44, 320, 216);
    timePicker.datePickerMode = UIDatePickerModeTime;

   [timePicker setLocale:locale];

    
    if (button.tag == 12) {
        if ([startTimeButton.titleLabel.text length] > 0) {
            //timePicker.date = [self dateFromString:startTimeButton.titleLabel.text];
        }
        lblTitle.text = @"Första påminnelsen";
    }else if (button.tag == 13) {
        if ([stopTimeButton.titleLabel.text length] > 0) {
            //timePicker.date = [self dateFromString:stopTimeButton.titleLabel.text];
        }
        lblTitle.text = @"Sista påminnelsen";
    }else if (button.tag == 14){
        
    }else if (button.tag == 24){
        lblTitle.text = @"En gång om dagen kl";   
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
    }else if (hoursValue == 24){
        oneTimeNotificationLabel.text = [self stringFromDateTimes:timePicker.date];
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
}






@end
