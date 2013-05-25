//
//  DayEventViewController.h
//  Välkommen till TFH-appen
//
//  Created by AppDev on 19/05/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <EventKit/EventKit.h>
#import "Va_lkommenAppDelegate.h"
#import "ShowEventsBO.h"

@interface DayEventViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray *timeslotsArray;
    NSMutableArray *arrayEvents;
    NSMutableArray *arrayShowEvents;
    UIScrollView *scrollView;
     IBOutlet UIView *popupView2;
    IBOutlet UIButton *dayBtn;
    CGPoint point;
    int xAxies;
    int yAxies;
    Va_lkommenAppDelegate *appDelegate;
}

@property (nonatomic, retain) NSString *lblTitle;

-(void)loadScheduleView;
- (void)refreshEventsLoad;
- (NSArray *)fetchEventsForToday : (NSDate *)startDate;


@end
