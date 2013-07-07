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
    // Override point for customization after application launch.
    
    
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
    //[navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbar2.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
    UILocalNotification *localNotif =
	[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif)
        
    {
		NSLog(@"Recieved Notification %@",localNotif);
	}
    
    return YES;
    
    

}
- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
	// Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notif.userInfo);
    if ([[notif.userInfo valueForKey:@"notifyKey"] isEqualToString:@"Reminder"])
    {
        Dinaomraden *dr;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            if ([[UIScreen mainScreen] bounds].size.height > 480)
            {
                dr = [[Dinaomraden alloc]initWithNibName:@"Dinaomraden" bundle:nil];
            }
            else
            {
                dr = [[Dinaomraden alloc]initWithNibName:@"Dinaomraden" bundle:nil];
                
            }
        }
        else
        {
            dr = [[Dinaomraden alloc]initWithNibName:@"Dinaomraden_iPad" bundle:nil];
        }
        
        UINavigationController *nav = [[UINavigationController alloc] init];
        [nav pushViewController:dr animated:YES];
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    else
    {
        AktivitetsplanenViewController *asvc=[[AktivitetsplanenViewController alloc]initWithNibName:@"" bundle:[NSBundle mainBundle]];
         UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:asvc];
        [self.window addSubview:nav.view];
    }
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
