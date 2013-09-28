//
//  Va_lkommenAppDelegate.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Va_lkommenAppDelegate.h"
#import "Va_lkommenViewController.h"
#import "Dinaomraden.h"


#import "CalendarViewController.h"
#import "OveningarViewController.h"
#import "Registreringsvecka.h"
#import "Beteendeaktivering.h"


#define kEventNotificationDataKey @"EventNotification"
#define kTotalNotificationDataKey @"TotalNotification"


@implementation Va_lkommenAppDelegate

@synthesize viewController;
@synthesize dateSelected;
@synthesize calendarVC;
@synthesize overnVC;
@synthesize regiveckaVC;
@synthesize beteendeaVC;

- (void)dealloc
{
    [_window release];
    [viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    application.applicationIconBadgeNumber = 0;  
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            
            self.viewController = [[Va_lkommenViewController alloc] initWithNibName:@"Va_lkommenViewController_iPhone" bundle:nil];
    
        } else {
            
            self.viewController = [[Va_lkommenViewController alloc] initWithNibName:@"Va_lkommenViewController_iPhone4" bundle:nil];
        }
    } else {
        self.viewController = [[Va_lkommenViewController alloc] initWithNibName:@"Va_lkommenViewController_iPad" bundle:nil];
    }
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        navController.navigationBar.barStyle = UIBarStyleDefault;
        [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_iPhone.png"] forBarMetrics:UIBarMetricsDefault];
    }else {
        [navController.navigationBar setBarStyle:UIBarStyleDefault];
       [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_iPad.png"] forBarMetrics:UIBarMetricsDefault]; 
    }
    
    
    [navController.navigationBar setTranslucent:NO];
    
    
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
    // Detect the Notification after a user taps it
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif)
    {
       
        NSLog(@"%@",[localNotif userInfo]);
        [self notification:localNotif];
    
    }
    
    
    return YES;

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    /*UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Event"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else {
        */
        
   // }
    
    NSLog(@"got notification");
    
    [self notification:notification];
}


- (void)notification:(UILocalNotification*)notification {
    
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height > 480)
        {
            
            calendarVC = [[CalendarViewController alloc] initWithNibName:@"CalendarView" bundle:nil];
        }else {
            calendarVC = [[CalendarViewController alloc] initWithNibName:@"CalendarView_iPhone4" bundle:nil];
        }
    }else {
        calendarVC = [[CalendarViewController alloc] initWithNibName:@"CalendarView_iPad" bundle:nil];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height > 480)
        {
            
            viewController  = [[Va_lkommenViewController alloc] initWithNibName:@"Va_lkommenViewController_iPhone" bundle:nil];
        }else {
            viewController = [[Va_lkommenViewController alloc] initWithNibName:@"Va_lkommenViewController_iPhone4" bundle:nil];
        }
    }else {
        viewController = [[Va_lkommenViewController alloc] initWithNibName:@"Va_lkommenViewController_iPad" bundle:nil];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height > 480)
        {
            
            overnVC = [[OveningarViewController alloc] initWithNibName:@"OveningarViewController_iPhone" bundle:nil];
        }else {
            overnVC = [[OveningarViewController alloc] initWithNibName:@"OveningarViewController_iPhone4" bundle:nil];
        }
    }else {
        overnVC = [[OveningarViewController alloc] initWithNibName:@"OveningarViewController_iPad" bundle:nil];
    }
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height > 480)
        {
            
            regiveckaVC = [[Registreringsvecka alloc] initWithNibName:@"Registreringsvecka" bundle:nil];
        }else {
            regiveckaVC = [[Registreringsvecka alloc] initWithNibName:@"Registreringsvecka_iPhone4" bundle:nil];
        }
    }else {
        regiveckaVC = [[Registreringsvecka alloc] initWithNibName:@"Registreringsvecka_iPad" bundle:nil];
    }
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height > 480)
        {
            
            beteendeaVC = [[Beteendeaktivering alloc] initWithNibName:@"Beteendeaktivering" bundle:nil];
        }else {
            beteendeaVC = [[Beteendeaktivering alloc] initWithNibName:@"Beteendeaktivering_iPhone4" bundle:nil];
        }
    }else {
        beteendeaVC = [[Beteendeaktivering alloc] initWithNibName:@"Beteendeaktivering_iPad" bundle:nil];
    }
    
    
    
    NSLog(@"%@",notification.userInfo);
    
    if ([[notification.userInfo valueForKey:kEventNotificationDataKey] isEqualToString:@"Event"]) {
        NSLog(@"Event");
        calendarVC.isEventNotify = YES;
        calendarVC.isTotalNotify = NO;
        
    }
    else if ([[notification.userInfo valueForKey:kTotalNotificationDataKey] isEqualToString:@"Total"]) {
        NSLog(@"Total");
        calendarVC.isTotalNotify = YES;
        calendarVC.isEventNotify = NO;
    }
    
    
    UINavigationController *nav = (UINavigationController *) self.window.rootViewController;
    nav.viewControllers = [NSArray arrayWithObjects:viewController,overnVC,beteendeaVC,regiveckaVC,calendarVC,nil];
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        
        [(UINavigationController *)self.window.rootViewController popToViewController:calendarVC animated:YES];
    }
    else
    {
        [(UINavigationController *)self.window.rootViewController popToViewController:calendarVC animated:YES];
    }
    
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
    
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
