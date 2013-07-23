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
#import "RegistreringDinaveckarViewController.h"

@interface Registreringsvecka ()
@end

@implementation Registreringsvecka
@synthesize calendarView,regDinaveckarView;


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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!calendarView) {
                calendarView = [[CalendarViewController alloc]initWithNibName:@"CalendarView" bundle:nil];
            }
        }else{
            if (!calendarView) {
                calendarView = [[CalendarViewController alloc]initWithNibName:@"CalendarView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!calendarView) {
            calendarView = [[CalendarViewController alloc]initWithNibName:@"CalendarView_iPad" bundle:nil];
        }
    }
    calendarView.isEventNotify = NO;
    calendarView.isTotalNotify = NO;
    
    [self.navigationController pushViewController:calendarView animated:YES];
}


-(IBAction)ILabel:(id)sender {
     [MTPopupWindow showWindowWithHTMLFile:@"Registreringsvecka.html" insideView:self.view];
}


-(IBAction)dinavaor:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!regDinaveckarView) {
                regDinaveckarView = [[RegistreringDinaveckarViewController alloc]initWithNibName:@"RegistreringDinaveckaView" bundle:nil];
            }
        }else{
            if (!regDinaveckarView) {
                regDinaveckarView = [[RegistreringDinaveckarViewController alloc]initWithNibName:@"RegistreringDinaveckaView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!regDinaveckarView) {
            regDinaveckarView = [[RegistreringDinaveckarViewController alloc]initWithNibName:@"RegistreringDinaveckaView_iPad" bundle:nil];
        }
    }

    [self.navigationController pushViewController:regDinaveckarView animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
