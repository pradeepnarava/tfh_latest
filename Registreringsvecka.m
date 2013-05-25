//
//  Registreringsvecka.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Registreringsvecka.h"
#import "MTPopupWindow.h"
@interface Registreringsvecka ()

@end

@implementation Registreringsvecka

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
    self.navigationItem.title=@"Registreringsvecka";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];

}


-(IBAction)sub1button:(id)sender{
    
    aktiViewObj = [[AktivitetsplanenViewController alloc]initWithNibName:@"AktivitetsplanenViewController" bundle:nil];

    [self.navigationController pushViewController:aktiViewObj animated:YES];
}

-(IBAction)ILabel:(id)sender{
     [MTPopupWindow showWindowWithHTMLFile:@"Registreringsvecka.html" insideView:self.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
