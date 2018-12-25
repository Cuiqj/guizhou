//
//  MaintainNoticeModelPrintViewController.h
//  GuiZhouRMMobile
//
//  Created by maijunjin on 15/10/9.
//
//

#import <Foundation/Foundation.h>
#import "CasePrintViewController.h"
#import	"MaintainNotice.h"
#import "RoadSetHandler.h"
#import "CaseIDHandler2.h"
@interface MaintainNoticeModelPrintViewController : CasePrintViewController<RoadSetHandler,CaseIDHandler2>
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_cd;
@property (weak, nonatomic) IBOutlet UITextField *textroadasset;
@property (weak, nonatomic) IBOutlet UITextField *reason;
@property (weak, nonatomic) IBOutlet UITextView *textdescription;

@property (weak, nonatomic) IBOutlet UITextField *subscriber_name;
@property (weak, nonatomic) IBOutlet UITextField *textsubscriber_date;

@property (weak, nonatomic) IBOutlet UITextView *textremark;
@property (nonatomic,retain)NSString *inspectionRecord_id;

- (void)generateDefaultInfo:(MaintainNotice *)maintainNotice;
@property (weak, nonatomic) IBOutlet UITextField *textroadsegment_name;

- (IBAction)selectRoadSegment:(UITextField *)sender;
- (IBAction)selectRoadasset:(UITextField *)sender;
- (IBAction)selectReason:(id)sender;
- (IBAction)selectSubscriber_name:(id)sender;
- (IBAction)selectSubscriber_date:(UITextField *)sender;

@end
