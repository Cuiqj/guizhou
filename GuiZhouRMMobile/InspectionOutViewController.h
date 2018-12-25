//
//  InspectionOutViewController.h
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-9-13.
//
//

#import <UIKit/UIKit.h>
//#import "CheckItemDetails.h"
//#import "CheckItems.h"
//#import "TempCheckItem.h"
#import "DateSelectController.h"
#import "InspectionOutCheck.h"
#import "Inspection.h"
#import "InspectionHandler.h"
#import "InspectionRecord.h"

@interface InspectionOutViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textViewDesc;
- (IBAction)btnCancel:(UIBarButtonItem *)sender;
- (IBAction)btnSave:(UIBarButtonItem *)sender;
- (IBAction)btnFormDesc:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

@property (weak, nonatomic) id<InspectionHandler> delegate;

@end
