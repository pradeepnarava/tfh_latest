//
//  Va_lkommenAppDelegate.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Va_lkommenViewController;
@class CalendarViewController;

@interface Va_lkommenAppDelegate : UIResponder <UIApplicationDelegate>{
    CalendarViewController *calendarView;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) NSDate *dateSelected;

@end
