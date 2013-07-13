//
//  Registreringsvecka.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Registreringsvecka.h"
#import "MTPopupWindow.h"
#import "CalendarViewController.h"

@interface Registreringsvecka ()

@end

@implementation Registreringsvecka
@synthesize calendarView;

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
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
        
    }
    else {
        
        UIImage *image = [UIImage imageNamed:@"tillbaka1.png"];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [okBtn setBackgroundImage:image forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(backButon) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    }
    
    // Do any additional setup after loading the view from its nib.
    
    [super viewDidLoad];

}

-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)sub1button:(id)sender {
    
    
    
    
    if (!calendarView) {
        calendarView = [[CalendarViewController alloc]initWithNibName:@"CalendarView" bundle:nil];
    }

    [self.navigationController pushViewController:calendarView animated:YES];
}


-(IBAction)ILabel:(id)sender {
     [MTPopupWindow showWindowWithHTMLFile:@"Registreringsvecka.html" insideView:self.view];
}


-(IBAction)dinavaor:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
