//
//  Va_lkommenAppDelegate.h
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Va_lkommenViewController;
@class OveningarViewController;
@class Beteendeaktivering;
@class Registreringsvecka;
@class CalendarViewController;

@interface Va_lkommenAppDelegate : UIResponder <UIApplicationDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) OveningarViewController *overnVC;
@property (strong, nonatomic) Beteendeaktivering *beteendeaVC;
@property (strong, nonatomic) Registreringsvecka *regiveckaVC;
@property (strong, nonatomic) CalendarViewController *calendarVC;

@property (strong, nonatomic) Va_lkommenViewController *viewController;
@property (strong, nonatomic) NSDate *dateSelected;

@end
