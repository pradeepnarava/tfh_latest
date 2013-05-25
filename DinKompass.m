//
//  DinKompass.m
//  Välkommen till TFH-appen
//
//  Created by Mohammed Abdul Majeed on 5/15/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "DinKompass.h"

@interface DinKompass ()

@end

@implementation DinKompass
@synthesize scatterPlot = _scatterPlot;
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   NSMutableArray *data = [NSMutableArray array];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-10, 100)]];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-8, 95)]];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-6, 85)]];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-4, 70)]];
    //    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-2, 50)]];
    // [data addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
   [data addObject:[NSValue valueWithCGPoint:CGPointMake(2, 3.89)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(4, 4.44)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(6, 5.75)]];
    // [data addObject:[NSValue valueWithCGPoint:CGPointMake(8, 64)]];
     //[data addObject:[NSValue valueWithCGPoint:CGPointMake(10, 100)]];
//self.scatterPlot = [[TUTSimpleScatterPlot alloc] initWithHostingView:_graphHostingView andData:data];
//[self.scatterPlot initialisePlot];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}

@end
