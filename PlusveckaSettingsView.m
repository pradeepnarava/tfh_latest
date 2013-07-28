//
//  PlusveckaSettingsView.m
//  Välkommen till TFH-appen
//
//  Created by Brilliance Tech Sols on 7/21/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "PlusveckaSettingsView.h"

@interface PlusveckaSettingsView ()

@end

@implementation PlusveckaSettingsView
@synthesize scrollVie;
@synthesize oneHour,twoHour,threeHour,fourHour;
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
    scrollVie.hidden = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)hourSelected:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    for (UIButton *radioButton in [self.scrollVie  subviews]) {
        if (radioButton.tag != btn.tag && [radioButton isKindOfClass:[UIButton class]]) {
            if ((radioButton.tag == 20 || radioButton.tag == 21 || radioButton.tag == 22 || radioButton.tag == 23 )) {
                [radioButton setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            }
            
        }
    }
    
    [btn setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
}

-(IBAction)okAction:(id)sender{
    
}

-(IBAction)settingsOnOff:(id)sender{
    if ([sender tag]==0) {
        scrollVie.hidden = YES;
    }else{
        scrollVie.hidden = NO;
    }
}

-(void)backButon {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
