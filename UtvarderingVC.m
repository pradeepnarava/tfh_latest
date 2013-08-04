//
//  UtvarderingVC.m
//  Välkommen till TFH-appen
//
//  Created by Chandrika on 04/08/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "UtvarderingVC.h"
#import "UtvarderingVeckostatestikVC.h"

@interface UtvarderingVC ()

@end

@implementation UtvarderingVC
@synthesize utvarderingVeckosVC;



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
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"Utvärdering";
    
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
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backButon {
    
    [self.navigationController popViewControllerAnimated:YES];
}





-(IBAction)buttonClicked:(id)sender {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!utvarderingVeckosVC) {
                utvarderingVeckosVC=[[UtvarderingVeckostatestikVC alloc]initWithNibName:@"UtvarderingVeckostatestikView" bundle:nil];
            }
        }else{
            if (!utvarderingVeckosVC) {
                utvarderingVeckosVC=[[UtvarderingVeckostatestikVC alloc]initWithNibName:@"UtvarderingVeckostatestikView_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!utvarderingVeckosVC) {
            utvarderingVeckosVC=[[UtvarderingVeckostatestikVC alloc]initWithNibName:@"UtvarderingVeckostatestikView_iPad" bundle:nil];
        }
    }
    
    [self.navigationController pushViewController:utvarderingVeckosVC animated:YES];

}

@end
