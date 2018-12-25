//
//  DeformationInfoViewController2.h
//  GuiZhouRMMobile
//
//  Created by maijunjin on 15/9/29.
//
//

#import <UIKit/UIKit.h>
#import "RoadAssetCell.h"
#import "DeformInfoBriefViewController.h"
#import "CaseIDHandler.h"
#import "RoadAssetPrice.h"
#import "NormalListSelectController.h"
#import "DeformInfoBriefViewController2.h"
#import "RoadSetHandler.h"
#import "CaseIDHandler2.h"
@interface DeformationInfoViewController2 : UIViewController<UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,CaseIDHandler,NormalListSelectDelegate>
@property (nonatomic,copy) NSString * caseID;
@property (weak, nonatomic) IBOutlet UITableView *roadAssetListView;
@property (weak, nonatomic) IBOutlet UIPickerView *labelPicker;
@property (nonatomic,retain) DeformInfoBriefViewController2 *deformInfoVC;
@property (nonatomic,weak) id<CaseIDHandler> delegate;
@property (nonatomic,weak) id<CaseIDHandler2> delegate2;
@property (weak, nonatomic) IBOutlet UILabel *labelQuantity;
@property (weak, nonatomic) IBOutlet UITextField *textQuantity;
@property (weak, nonatomic) IBOutlet UILabel *labelLength;
@property (weak, nonatomic) IBOutlet UITextField *textLength;
@property (weak, nonatomic) IBOutlet UILabel *labelWidth;
@property (weak, nonatomic) IBOutlet UITextField *textWidth;
@property (weak, nonatomic) IBOutlet UIButton *btnAddDeform;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UITextField *textPrice;
@property (weak, nonatomic) IBOutlet UIView *addNewAssetView;
@property (weak, nonatomic) IBOutlet UITextField *textAssetName;
@property (weak, nonatomic) IBOutlet UITextField *textSpec;
@property (weak, nonatomic) IBOutlet UITextField *textAssetUnit;
@property (weak, nonatomic) IBOutlet UITextField *textAssetPrice;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonSelectPriceStandard;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
- (IBAction)printEdit:(id)sender;
//设定文书查看状态，编辑模式或者PDF查看模式
@property (nonatomic,assign) DocPrinterState docPrinterState;
- (IBAction)textNumberChanged:(id)sender;
- (IBAction)btnAddDeformation:(id)sender;
- (IBAction)btnDismiss:(id)sender;
- (IBAction)selectPriceStandard:(UIBarButtonItem *)sender;@end
