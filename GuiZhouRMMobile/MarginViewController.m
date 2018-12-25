//
//  MarginViewController.m
//  GuiZhouRMMobile
//
//  Created by maijunjin on 15-3-13.
//
//

#import "MarginViewController.h"

@interface MarginViewController ()

@end

@implementation MarginViewController

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
    self.leftMarginUISlider.maximumValue = 300;
    self.leftMarginUISlider.popUpViewCornerRadius = 0.0;
    [self.leftMarginUISlider setMaxFractionDigitsDisplayed:0];
    self.leftMarginUISlider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    self.leftMarginUISlider.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    self.leftMarginUISlider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    self.topMarginUISlider.maximumValue = 300;
    self.topMarginUISlider.popUpViewCornerRadius = 0.0;
    [self.topMarginUISlider setMaxFractionDigitsDisplayed:0];
    self.topMarginUISlider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    self.topMarginUISlider.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    self.topMarginUISlider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    self.leftMarginUISlider.value = self.leftMarginLength;
    self.topMarginUISlider.value = self.topMarginLength;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLeftMarginUISlider:nil];
    [self setTopMarginUISlider:nil];
    [self setLeftMarginUISlider:nil];
    [self setTopMarginUISlider:nil];
    [super viewDidUnload];
}
- (IBAction)setLeftMargin:(id)sender {
    [self.delegate setLeftMargin:self.leftMarginUISlider.value];
    [self.caseDocumentsDelegate reloadPDFView];
}

- (IBAction)setTopMargin:(id)sender {
    [self.delegate setTopMargin:self.topMarginUISlider.value];
    [self.caseDocumentsDelegate reloadPDFView];
}

@end
