//
//  DateSelectingViewController.h
//  Välkommen till TFH-appen
//
//  Created by Sai Jithendra Gogineni on 10/06/13.
//  Copyright (c) 2013 brilliance. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateSelectingViewControllerDelegate;

@interface DateSelectingViewController : UIViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (retain, nonatomic) IBOutlet UITextField *startDateField;
@property (retain, nonatomic) IBOutlet UITextField *endDateField;
@property (retain, nonatomic) IBOutlet UINavigationItem *navBar;

@property (nonatomic, retain) id<DateSelectingViewControllerDelegate> delegate;

- (IBAction)dinUtvecklingClicked:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;

@end

@protocol DateSelectingViewControllerDelegate <NSObject>

- (void)didDatesSelecetedStartDate:(NSString *)startDate andEndDate:(NSString *)endDate;

@end
