//
//  Utvardering.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/3/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "Utvardering.h"
#import "MTPopupWindow.h"
@interface Utvardering ()

@end

@implementation Utvardering
@synthesize checkBoxLabel,checkBoxLabel1,checkBoxLabel2,checkBox,checkBox2,checkBox1,mainlabel;
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
    
    
    self.navigationItem.title=@"Utvardering";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;

//    mainlabel.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGesture =
//    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mlabelalert:)] autorelease];
//    [mainlabel addGestureRecognizer:tapGesture];
    
    vss=[[Veckostatistik alloc]initWithNibName:@"Veckostatistik" bundle:nil];
    [super viewDidLoad];
  
}
-(IBAction)mlabelalert:(id)sender{
    [MTPopupWindow showWindowWithHTMLFile:@"￼￼Utvardering.html" insideView:self.view];
}

-(IBAction)checkBoxSelect:(id)sender
{
   checkBox= (UIButton *)sender;
    
    if (checkBox.tag == 0)
    {
        checkBox.tag=1;
        [checkBox setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
        selected_checkbox=checkBoxLabel.text;
        NSLog(@"%@",selected_checkbox);
    }
    else
    {
        checkBox.tag=0;
        [checkBox setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        selected_checkbox=@"";
        NSLog(@"sssss");
    }
    
}
-(IBAction)checkBoxSelect1:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 0)
    {
        btn.tag=1;
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
        selected_checkbox1=checkBoxLabel1.text;
        NSLog(@"%@",selected_checkbox1);
    }
    else
    {
        btn.tag=0;
        [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        selected_checkbox1=@"";
        NSLog(@"%@",selected_checkbox1);
    }

}

-(IBAction)checkBoxSelect2:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 0)
    {
        btn.tag=1;
        [btn setImage:[UIImage imageNamed:@"check.png"]  forState:UIControlStateNormal];
        selected_checkbox2=checkBoxLabel2.text;
        NSLog(@"%@",selected_checkbox2);
    }
    else
    {
       btn.tag=0;
        [btn setImage:[UIImage imageNamed:@"uncheck.png"]  forState:UIControlStateNormal];
        selected_checkbox2=@"";
        NSLog(@"%@",selected_checkbox2);

    }

}
-(IBAction)PageB:(id)sender{
    [self.navigationController pushViewController:vss animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
