//
//  Va_lkommenAppDelegate.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Va_lkommenAppDelegate.h"
#import "Va_lkommenViewController.h"
#import "AktivitetsplanenViewController.h"
#import "Dinaomraden.h"
#import "CalendarViewController.h"


#define kEventNotificationDataKey @"EventNotification"
#define kTotalNotificationDataKey @"TotalNotification"


@implementation Va_lkommenAppDelegate

@synthesize viewController = _viewController;
@synthesize dateSelected;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    application.applicationIconBadgeNumber = 0;  
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            
            self.viewController = [[Va_lkommenViewController alloc] initWithNibName:@"Va_lkommenViewController_iPhone" bundle:[NSBundle mainBundle]];
    
        } else {
            
            self.viewController = [[Va_lkommenViewController alloc] initWithNibName:@"Va_lkommenViewController_iPhone4" bundle:[NSBundle mainBundle]];
            
        }
        
        
    } else {
        self.viewController = [[Va_lkommenViewController alloc] initWithNibName:@"Va_lkommenViewController_iPad" bundle:[NSBundle mainBundle]];
    }
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_iPhone.png"] forBarMetrics:UIBarMetricsDefault];
    }else {
       [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_iPad.png"] forBarMetrics:UIBarMetricsDefault]; 
    }
    
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
    // Detect the Notification after a user taps it
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif)
    {
        NSLog(@"Recieved Notification %@",localNotif);
    }
    
    return YES;
    
    

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    CalendarViewController *calendarView;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height > 480)
        {
            
            calendarView = [[CalendarViewController alloc] initWithNibName:@"CalendarView" bundle:nil];
        }else {
            calendarView = [[CalendarViewController alloc] initWithNibName:@"CalendarView_iPhone4" bundle:nil];
        }
    }else {
        calendarView = [[CalendarViewController alloc] initWithNibName:@"CalendarView_iPad" bundle:nil];
    }
    
    if ([[notification.userInfo valueForKey:kEventNotificationDataKey] isEqualToString:@"Event"]) {
        NSLog(@"Event");
        calendarView.isEventNotify = YES;

    }
    else if ([[notification.userInfo valueForKey:kTotalNotificationDataKey] isEqualToString:@"Total"]) {
        NSLog(@"Total");
        calendarView.isTotalNotify = YES;
    }
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:calendarView];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_iPhone.png"] forBarMetrics:UIBarMetricsDefault];
    }else {
        [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_iPad.png"] forBarMetrics:UIBarMetricsDefault];
    }
    [self.window setRootViewController:navController];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
