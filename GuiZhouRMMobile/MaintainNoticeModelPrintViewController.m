//
//  MaintainNoticeModelPrintViewController.m
//  GuiZhouRMMobile
//
//  Created by maijunjin on 15/10/9.
//
//


#import "MaintainNoticeModelPrintViewController.h"
#import "RoadSegmentPickerViewController.h"
#import "DeformationInfoViewController2.h"
#import "Systype.h"
typedef enum _kUITextFieldTag {
    kUITextFieldTagBase = 0x11,
    kUITextFieldTagProver1,
    kUITextFieldTagProver1Duty,
    kUITextFieldTagProver1Code,
    kUITextFieldTagProver2,
    kUITextFieldTagProver2Duty,
    kUITextFieldTagProver2Code,
    kUITextFieldTagRecorder,
    kUITextFieldTagRecorderDuty,
    kUITextFieldTagRecorderCode
} kUITextFieldTag;

static NSString * const xmlName = @"MaintainNoticeModelTable";

@interface MaintainNoticeModelPrintViewController() <UITextFieldDelegate, NormalListSelectDelegate>
@property (nonatomic, retain) MaintainNotice *maintainNotice;
@property (nonatomic, retain) NSString *roadsegment_id;
@property (nonatomic,retain) UIPopoverController *caseInfoPickerpopover;
@property (nonatomic, strong) NSArray *employeeNames;
@property (nonatomic,retain) NSMutableArray *deformList;
@property (nonatomic) BOOL flag;
@end

@implementation MaintainNoticeModelPrintViewController

@synthesize caseID = _caseID;
@synthesize maintainNotice = _maintainNotice;
@synthesize inspectionRecord_id = _inspectionRecord_id;


-(void)viewDidLoad{
    self.flag = YES;
    [super setCaseID:self.caseID];
    self.inspectionRecord_id = self.caseID;
    [self LoadPaperSettings:xmlName];
    CGRect viewFrame = CGRectMake(0.0, 0.0, VIEW_FRAME_WIDTH, VIEW_FRAME_HEIGHT);
    self.view.frame = viewFrame;
    if (![self.inspectionRecord_id isEmpty]) {
        self.maintainNotice = [MaintainNotice maintainNoticeForInspectionRecord:self.inspectionRecord_id];
        if (self.maintainNotice == nil) {
            self.maintainNotice = [MaintainNotice newDataObject];
            self.maintainNotice.inspectionRecord_id = self.inspectionRecord_id;
            [[AppDelegate App] saveContext];
            [self generateDefaultInfo:self.maintainNotice];
        }
        [self pageLoadInfo];
    }
    
    NSMutableArray *employeeNames = [NSMutableArray array];
    for (EmployeeInfo *employee in [EmployeeInfo allEmployeeInfo]) {
        [employeeNames addObject:employee.name];
    }
    self.employeeNames = employeeNames;
    self.subscriber_name.delegate = self;
    self.textroadsegment_name.delegate = self;
    self.textroadasset.delegate = self;
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
}

- (void)initControlsInteraction
{



}


- (void)pageLoadInfo{
    
    
    
    self.textdescription.text = self.maintainNotice.mydescription;
    self.textmaintain_cd.text = self.maintainNotice.maintain_cd;
    self.textremark.text = self.maintainNotice.remark;
    self.textroadasset.text = self.maintainNotice.roadasset;
    self.reason.text = self.maintainNotice.reason;
    self.subscriber_name.text = self.maintainNotice.subscriber_name;
    self.roadsegment_id = self.maintainNotice.roadsegment_id;
    NSString *roadName=[Road roadNameFromID:self.maintainNotice.roadsegment_id];
    self.textroadsegment_name.text = roadName;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    self.textsubscriber_date.text = [dateFormatter stringFromDate:self.maintainNotice.subscriber_date];
    
}

- (void)pageSaveInfo{
    self.maintainNotice.mydescription = self.textdescription.text;
    self.maintainNotice.maintain_cd = self.textmaintain_cd.text;
    self.maintainNotice.remark = self.textremark.text;
    self.maintainNotice.roadasset = self.textroadasset.text;
    self.maintainNotice.reason = self.reason.text;
    self.maintainNotice.subscriber_name = self.subscriber_name.text;
    self.maintainNotice.roadsegment_id = self.roadsegment_id;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd日"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    self.maintainNotice.subscriber_date = [dateFormatter dateFromString:self.textsubscriber_date.text];

    
    
    
	[[AppDelegate App] saveContext];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(NSURL *)toFullPDFWithPath:(NSString *)filePath{
    [self pageSaveInfo];
    if (![filePath isEmpty]) {
        CGRect pdfRect=CGRectMake(0.0, 0.0, paperWidth, paperHeight);
        UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
        UIGraphicsBeginPDFPageWithInfo(pdfRect, nil);
        [self drawStaticTable:xmlName];
        [self drawDateTable:xmlName withDataModel:self.maintainNotice];
        Road *road=[Road roadFromID:self.maintainNotice.roadsegment_id];
        [self drawDateTable:xmlName withDataModel:road];
        NSString *organization_id = [[NSUserDefaults standardUserDefaults] stringForKey:ORGKEY];
        OrgInfo *orgInfo = [OrgInfo orgInfoForOrgID:organization_id];
        [self drawDateTable:xmlName withDataModel:orgInfo];
        UIGraphicsEndPDFContext();
        
        return [NSURL fileURLWithPath:filePath];
    } else {
        return nil;
    }
}


//根据案件记录，完整勘验信息
- (void)generateDefaultInfo:(MaintainNotice *)maintainNotice{
    
//    年+（+机构简称+维+）+字+本机构流水号
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
    NSString *yearString=[dateString substringToIndex:4];
    
    
    
    NSString *organization_id = [[NSUserDefaults standardUserDefaults] stringForKey:ORGKEY];
    OrgInfo *orgInfo = [OrgInfo orgInfoForOrgID:organization_id];
    maintainNotice.organization_id = organization_id;
    
    NSInteger caseMark4InDefaults=[[NSUserDefaults standardUserDefaults] stringForKey:@"CaseMark4"].integerValue;
    NSString *caseMark4 = [[NSString alloc] initWithFormat:@"%ld",caseMark4InDefaults + 1];
    [[NSUserDefaults standardUserDefaults] setObject:caseMark4 forKey:@"CaseMark4"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    maintainNotice.maintain_cd = [NSString stringWithFormat:@"%@(%@维)字%@号",yearString, orgInfo.orgname,caseMark4];
    
    maintainNotice.subscriber_date = [NSDate date];
    maintainNotice.isuploaded = @(NO);
    maintainNotice.myid = [NSString randomID];
    [[AppDelegate App] saveContext];
}






- (BOOL)shouldDocDeleted{
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 500:
            [super presentPopverFrom:textField withDataSource:self.employeeNames];
            break;
        case 200:
            [self roadSegmentPickerPresentPickerState:textField.frame];
            break;
        case 300:
            if (self.flag  == YES) {
                [self performSegueWithIdentifier:@"toDeformInfoEditor2" sender:textField];
                self.flag = NO;
            } else {
                self.flag = YES;
            }
            
            break;
        default:
            break;
    }
    return YES;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"toDeformInfoEditor2"]) {
        DeformationInfoViewController2 *ccdeVC = [segue destinationViewController];
        ccdeVC.delegate = self;
        ccdeVC.delegate2 = self;
        ccdeVC.caseID = self.maintainNotice.myid;
        
    }
}
-(void)setDeform:(NSArray *)array{
//    self.textroadasset.text = ;
} 
- (void)setRoad:(NSString *)aRoadID roadName:(NSString *)roadName{
    self.textroadsegment_name.text = roadName;
    self.roadsegment_id = aRoadID;
    
}
- (void)listSelect:(NormalListSelectController *)listSelectController selectedIndexPath:(NSIndexPath *)tableIndexPath
{
    if (self.popoverIndex == 500) {
        self.subscriber_name.text = [self.employeeNames objectAtIndex:tableIndexPath.row];
    } else if( self.popoverIndex == 400){
        self.reason.text = [[Systype typeValueForCodeName:@"案由（赔补偿）"] objectAtIndex:tableIndexPath.row];
    }
    [self dismissPopoverAnimated:YES];
}

-(NSURL *)toFormedPDFWithPath:(NSString *)filePath{
    [self pageSaveInfo];
    if (![filePath isEmpty]) {
        NSString *formatFilePath = [NSString stringWithFormat:@"%@.format.pdf", filePath];
        CGRect pdfRect=CGRectMake(0.0, 0.0, paperWidth, paperHeight);
        UIGraphicsBeginPDFContextToFile(formatFilePath, CGRectZero, nil);
        UIGraphicsBeginPDFPageWithInfo(pdfRect, nil);
        [self drawDateTable:xmlName withDataModel:self.maintainNotice];
        Road *road=[Road roadFromID:self.maintainNotice.roadsegment_id];
        [self drawDateTable:xmlName withDataModel:road];
        NSString *organization_id = [[NSUserDefaults standardUserDefaults] stringForKey:ORGKEY];
        OrgInfo *orgInfo = [OrgInfo orgInfoForOrgID:organization_id];
        [self drawDateTable:xmlName withDataModel:orgInfo];
        UIGraphicsEndPDFContext();
        
        return [NSURL fileURLWithPath:formatFilePath];
    } else {
        return nil;
    }
}

- (IBAction)selectRoadSegment:(UITextField *)sender {
    [self roadSegmentPickerPresentPickerState:sender.frame];
}

//路段选择弹窗
- (void)roadSegmentPickerPresentPickerState:(CGRect)rect{

        RoadSegmentPickerViewController *icPicker=[[RoadSegmentPickerViewController alloc] initWithStyle:UITableViewStylePlain];
        icPicker.tableView.frame=CGRectMake(0, 0, 150, 243);
        icPicker.pickerState=kRoadSegment;
        icPicker.delegate=self;
        self.caseInfoPickerpopover=[[UIPopoverController alloc] initWithContentViewController:icPicker];
        [self.caseInfoPickerpopover setPopoverContentSize:CGSizeMake(150, 243)];
        [self.caseInfoPickerpopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        icPicker.pickerPopover=self.caseInfoPickerpopover;
}



- (IBAction)selectRoadasset:(UITextField *)sender {
}

- (IBAction)selectReason:(id)sender {
}

- (IBAction)selectSubscriber_name:(id)sender {
}

- (IBAction)selectSubscriber_date:(UITextField *)sender {
}
-(void)setContent:(NSString *)content{
    self.textroadasset.text = content;
}
-(void)backDelegate{
    [self.textroadasset becomeFirstResponder];
    
}

@end
