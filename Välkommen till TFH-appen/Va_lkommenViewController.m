//
//  Va_lkommenViewController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Va_lkommenViewController.h"
#import "MTPopupWindow.h"
@interface Va_lkommenViewController ()

@end

@implementation Va_lkommenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"KBT Appen";
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Tillbaka"
//                                                                   style:UIBarButtonItemStyleBordered target:nil action:nil];
//    
//   UIImage *image = [UIImage imageNamed:@"backbutton.png"];
//    [backButton setBackgroundImage:image forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    self.navigationItem.backBarButtonItem = backButton;
//    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Tillbaka" style:UIBarButtonItemStyleBordered target:nil action:nil];
    // [btnDone setTintColor:[UIColor Color]];
    UIImage *stretchable = [UIImage imageNamed:@"tillbakabutton.png"] ;
    [btnDone setBackButtonBackgroundImage:stretchable forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setBackBarButtonItem:btnDone];
	// Do any additional setup after loading the view, typically from a nib.
   
  
    UINavigationBar *navBar = self.navigationController.navigationBar;
      if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    UIImage *image = [UIImage imageNamed:@"topbar2.png"];
          [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
      }else{
         UIImage *image = [UIImage imageNamed:@"topbar4.png"];
        [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
      }
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"exerciseDB.db"]];
}


-(IBAction)oveningarbutton:(id)sender{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
             if ([[UIScreen mainScreen] bounds].size.height == 548) {
             ovc=[[OveningarViewController alloc]initWithNibName:@"OveningarViewController" bundle:nil];
             }else{
                 ovc=[[OveningarViewController alloc]initWithNibName:@"OveningarViewController_iPhone4" bundle:nil];
             }
        }else{
             ovc=[[OveningarViewController alloc]initWithNibName:@"OveningarViewController_iPad" bundle:nil];
        }
    [self.navigationController pushViewController:ovc animated:YES];
}

-(IBAction)introduktion:(id)sender{
  [MTPopupWindow showWindowWithHTMLFile:@"Introduktion.html" insideView:self.view];
}

-(IBAction)om:(id)sender{
      [MTPopupWindow showWindowWithHTMLFile:@"om.html" insideView:self.view];
}
-(IBAction)lashorna:(id)sender{
      [MTPopupWindow showWindowWithHTMLFile:@"lashorna.html" insideView:self.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
@end
