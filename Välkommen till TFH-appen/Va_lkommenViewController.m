//
//  Va_lkommenViewController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Va_lkommenViewController.h"
#import "MTPopupWindow.h"

/*
@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"topbar_ipad.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
*/


@interface Va_lkommenViewController ()

@end

@implementation Va_lkommenViewController
@synthesize ovc;

- (void)viewDidLoad
{
 
    [super viewDidLoad];

    self.navigationItem.title = @"KBT Appen";
    
    //UINavigationBar *navBar = self.navigationController.navigationBar;

    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //self.navigationItem.title=@"KBT Appen";
        //UIImage *image1 = [UIImage imageNamed:@"topbar2.png"];
        //[navBar setBackgroundImage:image1 forBarMetrics:UIBarMetricsDefault];
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setTitle:@"Tillbaka" forState:UIControlStateNormal];
        [okBtn setBackgroundImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        //[self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:okBtn]];
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
        
    }
    else {
        //UIImage *image1 = [UIImage imageNamed:@"topbar4.png"];
        //[navBar setBackgroundImage:image1 forBarMetrics:UIBarMetricsDefault];
        //self.navigationItem.title=@"KBT Appen";
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setTitle:@"Tillbaka" forState:UIControlStateNormal];
        [okBtn setBackgroundImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        //[self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:okBtn]];
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
        
    }*/

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
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            ovc = [[OveningarViewController alloc]initWithNibName:@"OveningarViewController_iPhone" bundle:nil];
        }else{
            ovc = [[OveningarViewController alloc]initWithNibName:@"OveningarViewController_iPhone4" bundle:nil];
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
      [MTPopupWindow showWindowWithHTMLFile:@"ompsykisk.html" insideView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


-(void)dealloc {
    [super dealloc];
    [ovc release];
}
@end
