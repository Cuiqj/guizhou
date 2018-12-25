//
//  CaseViewController.h
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModelsHeader.h"
#import "AccInfoBriefViewController.h"
#import "CitizenInfoBriefViewController.h"
#import "DeformInfoBriefViewController.h"
#import "DeformationInfoViewController.h"
#import "InquireInfoViewController.h"
#import "InquireInfoBriefViewController.h"
#import "PaintBriefViewController.h"
#import "CasePaintViewController.h"
#import "CasePaintViewController.h"
#import "CaseDocumentsViewController.h"
#import "CaseListViewController.h"
#import "CaseIDHandler.h"
#import "CasePhoto.h"

#import "CaseInfoPickerViewController.h"

#import "CitizenListViewController.h"
#import "CaseDescListViewController.h"
#import "DateSelectController.h"

#import "CaseDocuments.h"
#import "RoadSegmentPickerViewController.h"


@interface CaseViewController : UIViewController<UITextFieldDelegate,CaseIDHandler,DatetimePickerHandler,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,RoadSegmentPickerDelegate,ReloadPaintDelegate>

@property (nonatomic,weak) IBOutlet UIScrollView *infoView;
@property (weak, nonatomic) IBOutlet UITextField *textCasePrefix;
@property (nonatomic,weak) IBOutlet UITextField *textCasemark2;
@property (nonatomic,weak) IBOutlet UITextField *textCasemark3;
@property (nonatomic,weak) IBOutlet UITextField *textWeatheer;
@property (weak,nonatomic) IBOutlet UITextField *textSide;
@property (weak,nonatomic) IBOutlet UITextField *textPlace;
@property (weak,nonatomic) IBOutlet UITextField *textRoadSegment;
@property (weak,nonatomic) IBOutlet UITextField *textStationStartKM;
@property (weak,nonatomic) IBOutlet UITextField *textStationStartM;
@property (weak,nonatomic) IBOutlet UITextField *textStationEndKM;
@property (weak,nonatomic) IBOutlet UITextField *textStationEndM;
@property (weak,nonatomic) IBOutlet UITextField *textHappenDate;
@property (weak,nonatomic) IBOutlet UITextField *textCitizenName;
@property (weak, nonatomic) IBOutlet UILabel *labelPhotoIndex;
@property (weak, nonatomic) IBOutlet UITextField *textCaseDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segInfoPage;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonEdit;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonNewCase;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonSave;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonCamera;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonPickFromLibrary;
@property (weak, nonatomic) IBOutlet UITableView *docListView;
@property (weak, nonatomic) IBOutlet UITableView *docTemplatesView;


@property (nonatomic,retain) NSString *caseID;
@property (nonatomic,retain) CaseInfo *caseInfo;

@property (nonatomic,retain) AccInfoBriefViewController *accInfoBriefVC;
@property (nonatomic,retain) CitizenInfoBriefViewController *citizenInfoBriefVC;
@property (nonatomic,retain) DeformInfoBriefViewController *deformInfoVC;
@property (nonatomic,retain) InquireInfoBriefViewController *inquireInfoBriefVC;
@property (nonatomic,retain) PaintBriefViewController *paintBriefVC;

@property (nonatomic,assign) BOOL needsMove;

//案件处理类型
@property (nonatomic,assign) NSInteger caseProcessType;

- (IBAction)btnImageFromCamera:(id)sender;
- (IBAction)btnImageFromLibrary:(id)sender;
- (IBAction)btnClickToEditor:(id)sender;
- (IBAction)btnNewCase:(id)sender;
- (IBAction)selectWeather:(id)sender;
- (IBAction)selectRoadSegmet:(UITextField *)sender;
- (IBAction)selectRoadSide:(UITextField *)sender;
- (IBAction)selectRoadPlace:(UITextField *)sender;
- (IBAction)selectCaseDesc:(id)sender;
- (IBAction)selectCaseProcessType:(id)sender;
- (IBAction)selectDateAndTime:(id)sender;
- (IBAction)btnSaveCaseInfo:(id)sender;
- (IBAction)btnPreviousCase:(id)sender;

- (IBAction)changeInfoPage:(UISegmentedControl *)sender;

-(void)saveCaseInfoForCase:(NSString *)caseID;
-(void)loadCaseInfoForCase:(NSString *)caseID;

@end
