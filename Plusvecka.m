//
//  Plusvecka.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Plusvecka.h"
#import "MTPopupWindow.h"


@interface Plusvecka ()

@end

@implementation Plusvecka
@synthesize selectController;
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
    self.navigationItem.title=@"Plusvecka";
    
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


-(IBAction)Ilabel:(id)sender{
       [MTPopupWindow showWindowWithHTMLFile:@"Plusvecka.html" insideView:self.view];
}

- (IBAction)PlaneraAction:(id)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] bounds].size.height > 480) {
            if (!selectController) {
                selectController = [[SelectRegistreringsveckaViewController alloc]initWithNibName:@"SelectRegistreringsveckaViewController" bundle:nil];
            }
        }else{
            if (!selectController) {
                selectController = [[SelectRegistreringsveckaViewController alloc]initWithNibName:@"SelectRegistreringsveckaViewController_iPhone4" bundle:nil];
            }
        }
    }
    else{
        if (!selectController) {
            selectController = [[SelectRegistreringsveckaViewController alloc]initWithNibName:@"SelectRegistreringsveckaViewController_iPad" bundle:nil];
        }
    }
    
    [self.navigationController pushViewController:selectController animated:YES];
}

- (IBAction)DinaVeckorAction:(id)sender {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
