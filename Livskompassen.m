//
//  Livskompassen.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/10/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Livskompassen.h"
#import "MTPopupWindow.h"
#import "Dinaomraden.h"
#import "DinKompass.h"

@interface Livskompassen ()

@end

@implementation Livskompassen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Livskompassen";
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Tillbaka" style:UIBarButtonItemStyleBordered target:nil action:nil];
    // [btnDone setTintColor:[UIColor Color]];
    UIImage *stretchable = [UIImage imageNamed:@"tillbakabutton.png"] ;
    [btnDone setBackButtonBackgroundImage:stretchable forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationItem setBackBarButtonItem:btnDone];
    
    //[self.view addSubview:scrollView];
    //scrollView.hidden=YES;
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)pageB:(id)sender
{
    Dinaomraden *dr;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height > 480)
        {
            dr = [[[Dinaomraden alloc]initWithNibName:@"Dinaomraden" bundle:nil] autorelease];
        }
        else
        {
            dr = [[[Dinaomraden alloc]initWithNibName:@"Dinaomraden" bundle:nil] autorelease];
        }
    }
    else
    {
        dr = [[[Dinaomraden alloc]initWithNibName:@"Dinaomraden_iPad" bundle:nil] autorelease];
    }
    [self.navigationController pushViewController:dr animated:YES];
}

-(IBAction)pageC:(id)sender
{
    DinKompass *dk;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height > 480)
        {
            dk = [[[DinKompass alloc]initWithNibName:@"DinKompass" bundle:nil] autorelease];
        }
        else
        {
            dk = [[[DinKompass alloc]initWithNibName:@"DinKompass" bundle:nil] autorelease];
        }
    }
    else
    {
        dk = [[[DinKompass alloc]initWithNibName:@"DinKompass_iPad" bundle:nil] autorelease];
    }
     [self.navigationController pushViewController:dk animated:YES];
}
-(IBAction)iLabel:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"Livskompassen.html" insideView:self.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
}

@end
