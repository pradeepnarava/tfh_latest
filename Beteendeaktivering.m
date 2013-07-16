//
//  Beteendeaktivering.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Beteendeaktivering.h"
#import "MTPopupWindow.h"
#import "Registreringsvecka.h"
#import "Plusvecka.h"
#import "Utvardering.h"


@interface Beteendeaktivering ()

@end

@implementation Beteendeaktivering
@synthesize titlelabel;
@synthesize ud;
@synthesize rs;
@synthesize psc;

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
    
    [super viewDidLoad];
}

-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}




-(IBAction)mainlabelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"Beteendeaktivering.html" insideView:self.view];
}



-(IBAction)sub1:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!rs) {
                rs=[[Registreringsvecka alloc]initWithNibName:@"Registreringsvecka" bundle:nil];
            }
        }else{
            if (!rs) {
                rs=[[Registreringsvecka alloc]initWithNibName:@"Registreringsvecka_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!rs) {
            rs=[[Registreringsvecka alloc]initWithNibName:@"Registreringsvecka_iPad" bundle:nil];
        }
    }
    
    [self.navigationController pushViewController:rs animated:YES];
}


-(IBAction)sub2:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!psc) {
                psc=[[Plusvecka alloc]initWithNibName:@"Plusvecka" bundle:nil];
            }
        }else{
            if (!psc) {
                psc=[[Plusvecka alloc]initWithNibName:@"Plusvecka_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!psc) {
            psc=[[Plusvecka alloc]initWithNibName:@"Plusvecka_iPad" bundle:nil];
        }
    }

    [self.navigationController pushViewController:psc animated:YES];
}


-(IBAction)sub3:(id)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!ud) {
                ud=[[Utvardering alloc]initWithNibName:@"Utvardering" bundle:nil];
            }
        }else{
            if (!ud) {
                ud=[[Utvardering alloc]initWithNibName:@"Utvardering_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!ud) {
            ud=[[Utvardering alloc]initWithNibName:@"Utvardering_iPad" bundle:nil];
        }
    }
    
    [self.navigationController pushViewController:ud animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
