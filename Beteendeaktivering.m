//
//  Beteendeaktivering.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Beteendeaktivering.h"
#import "MTPopupWindow.h"
@interface Beteendeaktivering ()

@end

@implementation Beteendeaktivering
@synthesize titlelabel;
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
    self.navigationItem.title=@"Beteendeaktivering";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    rs=[[Registreringsvecka alloc]initWithNibName:@"Registreringsvecka" bundle:nil];
    psc=[[Plusvecka alloc]initWithNibName:@"Plusvecka" bundle:nil];
    ud=[[Utvardering alloc]initWithNibName:@"Utvardering" bundle:nil];
//    titlelabel.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGesture =
//    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainlabelalert:)] autorelease];
//    [titlelabel addGestureRecognizer:tapGesture];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)mainlabelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Beteendeaktivering.html" insideView:self.view];
}
-(IBAction)sub1:(id)sender{
    [self.navigationController pushViewController:rs animated:YES];
}
-(IBAction)sub2:(id)sender{
    [self.navigationController pushViewController:psc animated:YES];
}
-(IBAction)sub3:(id)sender{
    [self.navigationController pushViewController:ud animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
