//
//  OveningarViewController.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 4/29/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "OveningarViewController.h"

@interface OveningarViewController ()

@end

@implementation OveningarViewController

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
    scroll.scrollEnabled = YES;
    [scroll setContentSize:CGSizeMake(320, 640)];
  self.navigationItem.title=@"Övningar";
    

    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Tillbaka" style:UIBarButtonItemStyleBordered target:nil action:nil];
    // [btnDone setTintColor:[UIColor Color]];
    UIImage *stretchable = [UIImage imageNamed:@"tillbakabutton.png"] ;
    [btnDone setBackButtonBackgroundImage:stretchable forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setBackBarButtonItem:btnDone];      
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)exercise1:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
               if ([[UIScreen mainScreen] bounds].size.height > 480) {
    rt=[[Registreratankar alloc]initWithNibName:@"Registreratankar" bundle:nil];
               }else{
                    rt=[[Registreratankar alloc]initWithNibName:@"Registreratankar_iphone4" bundle:nil];
               }
         }
         else{
               rt=[[Registreratankar alloc]initWithNibName:@"Registreratankar_iPad" bundle:nil];
         }
    [self.navigationController pushViewController:rt animated:YES];
}


-(IBAction)exercise2:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                if ([[UIScreen mainScreen] bounds].size.height >  480) {
                    tfvc=[[TankefallorViewController alloc]initWithNibName:@"TankefallorViewController" bundle:nil];
                }else{
                    tfvc=[[TankefallorViewController alloc]initWithNibName:@"TankefallorViewController_iPhone4" bundle:nil];
                }
         }else
         {
            tfvc=[[TankefallorViewController alloc]initWithNibName:@"TankefallorViewController_iPad" bundle:nil];
         }
    [self.navigationController pushViewController:tfvc animated:YES];
}


-(IBAction)exercise3:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                   if ([[UIScreen mainScreen] bounds].size.height > 480) {
    ut=[[Utmanatankar alloc]initWithNibName:@"Utmanatankar" bundle:nil];
                   }else{
                        ut=[[Utmanatankar alloc]initWithNibName:@"utmanatankar_iPhone4" bundle:nil];
                   }
         }else
         {
             ut=[[Utmanatankar alloc]initWithNibName:@"Utmanatankar_iPad" bundle:nil];
         }
    [self.navigationController pushViewController:ut animated:YES];
}


-(IBAction)exercise4:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                    if ([[UIScreen mainScreen] bounds].size.height > 480) {
                 bec=[[BeteendeexperimentController alloc]initWithNibName:@"BeteendeexperimentController" bundle:nil];
                   }else{
                      bec=[[BeteendeexperimentController alloc]initWithNibName:@"BeteendeexperimentController_iPhone4" bundle:nil];
                }
         }else
         {
             
         }
    [self.navigationController pushViewController:bec animated:YES];
}


-(IBAction)exercise5:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
              if ([[UIScreen mainScreen] bounds].size.height >  480) {
              ice=[[Interoceptivexponering alloc]initWithNibName:@"Interoceptivexponering" bundle:nil];
              }else{
                    ice=[[Interoceptivexponering alloc]initWithNibName:@"Interoceptivexponering_iPhone4" bundle:nil];
              }
            }else
         {
              ice=[[Interoceptivexponering alloc]initWithNibName:@"Interoceptivexponering_iPad" bundle:nil];
         }
    [self.navigationController pushViewController:ice animated:YES];
}


-(IBAction)exercise6:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      
             ba=[[Beteendeaktivering alloc]initWithNibName:@"Beteendeaktivering" bundle:nil];

         }else
         {
             
         }
    [self.navigationController pushViewController:ba animated:YES];
}



-(IBAction)exercise7:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    lsp=[[Livskompassen alloc]initWithNibName:@"Livskompassen" bundle:nil];
         }else
         {
             lsp=[[Livskompassen alloc]initWithNibName:@"Livskompassen_iPad" bundle:nil];
         }
    [self.navigationController pushViewController:lsp animated:YES];
}

@end
