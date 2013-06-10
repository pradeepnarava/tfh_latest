//
//  DateSelectingViewController.m
//  Välkommen till TFH-appen
//
//  Created by Sai Jithendra Gogineni on 10/06/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import "DateSelectingViewController.h"

@interface DateSelectingViewController ()

@end

@implementation DateSelectingViewController

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
    _startDateField.inputView = _datePicker;
    _endDateField.inputView = _datePicker;
    
    [_datePicker setMaximumDate:[NSDate date]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIImage *image = [UIImage imageNamed:@"topbar2.png"];
        [_navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }else{
        UIImage *image = [UIImage imageNamed:@"topbar4.png"];
        [_navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_startDateField release];
    [_endDateField release];
    [_datePicker release];
    [_navBar release];
    [super dealloc];
}

- (IBAction)dinUtvecklingClicked:(id)sender
{
    if (![_startDateField.text isEqualToString:@""] && ![_endDateField.text isEqualToString:@""])
    {
        if ([_delegate respondsToSelector:@selector(didDatesSelecetedStartDate:andEndDate:)])
        {
            [_delegate didDatesSelecetedStartDate:_startDateField.text andEndDate:_endDateField.text];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)datePickerValueChanged:(id)sender
{
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    if (_startDateField.isEditing)
        _startDateField.text = [formatter stringFromDate:_datePicker.date];
    else if (_endDateField.isEditing)
        _endDateField.text = [formatter stringFromDate:_datePicker.date];
}

@end
