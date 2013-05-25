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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)Ilabel:(id)sender{
       [MTPopupWindow showWindowWithHTMLFile:@"Plusvecka.html" insideView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
