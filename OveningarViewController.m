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
    [scroll setContentSize:CGSizeMake(320, 700)];
  self.navigationItem.title=@"Övningar";
    
   
    
    
    
 
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Tillbaka" style:UIBarButtonItemStyleBordered target:self action:nil];
    UIImage *stretchable = [[UIImage imageNamed:@"backbutton.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:16];
    [btnDone setBackgroundImage:stretchable forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setBackBarButtonItem:btnDone];    // Do any additional setup after loading the view from its nib.
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)exercise1:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
               if ([[UIScreen mainScreen] bounds].size.height == 568) {
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
                if ([[UIScreen mainScreen] bounds].size.height == 568) {
     tfvc=[[TankefallorViewController alloc]initWithNibName:@"TankefallorViewController" bundle:nil];
                }else{
                    tfvc=[[TankefallorViewController alloc]initWithNibName:@"TankefallorViewController_iPhone4" bundle:nil];
                }
         }else
         {
              // tfvc=[[TankefallorViewController alloc]initWithNibName:@"TankefallorViewController_iPad" bundle:nil];
         }
    [self.navigationController pushViewController:tfvc animated:YES];
}
-(IBAction)exercise3:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                   if ([[UIScreen mainScreen] bounds].size.height == 568) {
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
                   // if ([[UIScreen mainScreen] bounds].size.height == 568) {
                 bec=[[BeteendeexperimentController alloc]initWithNibName:@"BeteendeexperimentController" bundle:nil];
                  //  }else{
                  //      bec=[[BeteendeexperimentController alloc]initWithNibName:@"BeteendeexperimentController_iPhone4" bundle:nil];
                   // }
         }else
         {
             
         }
    [self.navigationController pushViewController:bec animated:YES];
}
-(IBAction)exercise5:(id)sender{
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
              ice=[[Interoceptivexponering alloc]initWithNibName:@"Interoceptivexponering" bundle:nil];
            }else
         {
             
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
             
         }
    [self.navigationController pushViewController:lsp animated:YES];
}

@end
