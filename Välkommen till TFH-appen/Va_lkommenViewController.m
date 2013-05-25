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
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    ovc=[[OveningarViewController alloc]initWithNibName:@"OveningarViewController" bundle:nil];
	// Do any additional setup after loading the view, typically from a nib.
    
  
    UINavigationBar *navBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed:@"topbar2.png"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


-(IBAction)oveningarbutton:(id)sender{
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


- (BOOL)shouldAutorotate
{
    return YES;
}


 - (void )didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}

@end
