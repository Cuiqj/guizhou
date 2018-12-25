//
//  MarginViewController.h
//  GuiZhouRMMobile
//
//  Created by maijunjin on 15-3-13.
//
//

#import <UIKit/UIKit.h>
#import "SetMarginHandler.h"
#import "ASValueTrackingSlider.h"
#import "CaseDocumentsViewController.h"

@interface MarginViewController : UIViewController{
}
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *leftMarginUISlider;
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *topMarginUISlider;



@property (nonatomic,weak) id<SetMarginHandler> delegate;
@property (nonatomic,weak) id<CaseDocumentsDelegate> caseDocumentsDelegate;
@property (nonatomic,retain) UIPopoverController *pickerPopover;
@property (nonatomic) CGFloat leftMarginLength;
@property (nonatomic) CGFloat topMarginLength;
- (IBAction)setLeftMargin:(id)sender;
- (IBAction)setTopMargin:(id)sender;
@end
