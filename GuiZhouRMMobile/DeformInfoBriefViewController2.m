//
//  DeformInfoBriefViewController.m
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DeformInfoBriefViewController2.h"
#import "CaseDeformation2.h"
#import "Citizen.h"
#import "DeformationCell.h"

@interface DeformInfoBriefViewController2 ()
-(void)reloadInfo;
-(void)showAlertView;

@property (nonatomic,retain) NSMutableArray *citizenList;
@end

@implementation DeformInfoBriefViewController2
@synthesize deformTableView = _deformTableView;
@synthesize citizenPickerView = _citizenPickerView;
@synthesize caseID = _caseID;
@synthesize citizenList = _citizenList;
@synthesize delegate = _delegate;
@synthesize delegate2 = _delegate2;
@synthesize deformList = _deformList;
//显示位置标记，在案件主页面显示，整数值为0，在清单编辑页面显示，整数值为1；
@synthesize viewLocal = _viewLocal;


-(void)viewWillAppear:(BOOL)animated{
    [self reloadInfo];
    if (self.viewLocal==0) {
        [self.view setBackgroundColor:[UIColor whiteColor]];
    } else {
        [self.view setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)viewDidLoad
{    
    [self.citizenPickerView.layer setCornerRadius:4];
    [self.deformTableView.layer setCornerRadius:4];
    [self.citizenPickerView.layer setMasksToBounds:YES];
    [self.deformTableView.layer setMasksToBounds:YES];
    [self.citizenPickerView setBounces:NO];    
    
    NSString *imagePath=[[NSBundle mainBundle] pathForResource:@"左栏背景" ofType:@"png"];
    UIImage *citizenPickerBackImage=[UIImage imageWithContentsOfFile:imagePath];
    UIGraphicsBeginImageContext(self.citizenPickerView.frame.size);
    [citizenPickerBackImage drawInRect:self.citizenPickerView.bounds];
    citizenPickerBackImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *citizenPickerBackgroundView=[[UIImageView alloc] initWithImage:citizenPickerBackImage];
    self.citizenPickerView.backgroundView=citizenPickerBackgroundView;    
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setDeformTableView:nil];
    [self setCaseID:nil];
    [self.citizenList removeAllObjects];
    [self setCitizenList:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self setCitizenPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSInteger numberOfSection=0;
    switch (tableView.tag) {
        case 1000:
            //车号选择列表
            numberOfSection=1;
            break;
        case 1001:
            //路产损坏清单
            numberOfSection=2;
            break;
        default:
            break;
    }
    return numberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numberOfRows=0;
    switch (tableView.tag) {
        case 1000:
            //车号选择列表
            numberOfRows=self.citizenList.count;
            break;
        case 1001:
            //路产损坏清单
        {
            if (section==0) {
                numberOfRows=self.deformList.count;
            }
            if (section==1) {
                numberOfRows=0;
            }    
        }
            break;
        default:
            break;
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    switch (tableView.tag) {
        case 1000:
            //车号选择列表
        {
            static NSString *CellIdentifier=@"CitizenPickerCell";
            cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.textLabel.text=[self.citizenList objectAtIndex:indexPath.row];
            NSString *imagePath=[[NSBundle mainBundle] pathForResource:@"左栏按钮" ofType:@"png"];
            UIImage *backImage=[[UIImage imageWithContentsOfFile:imagePath] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
            UIImageView *backView=[[UIImageView alloc] initWithImage:backImage];
            cell.selectedBackgroundView=backView;
            return cell;
        }
            break;
        case 1001:
            //路产损坏清单
        {
            //路产损坏列表
            if (indexPath.section==0) {
                static NSString *CellIdentifier = @"DefomationCell";
                DeformationCell *cell = (DeformationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                CaseDeformation *deformation=[self.deformList objectAtIndex:indexPath.row];
                cell.assetNameLabel.text = deformation.roadasset_name;
                cell.assetPriceLabel.text = @"";
                if (self.viewLocal == 0) {
                    cell.assetQuantityLabel.text = @"";
                    [cell.assetQuantityLabel setHidden:YES];
                } else {
                    if ([deformation.unit rangeOfString:@"米"].location != NSNotFound) {
                        cell.assetTotalAmountLabel.text=[NSString stringWithFormat:@"%.2f%@",deformation.quantity.doubleValue,deformation.unit];
                    } else {
                        cell.assetTotalAmountLabel.text=[NSString stringWithFormat:@"%d%@",deformation.quantity.integerValue,deformation.unit];
                    }
                }
                cell.assetQuantityLabel.text = @"";
                cell.assetTotalAmountLabel.textColor=[UIColor scrollViewTexturedBackgroundColor];
                return cell;
            }
            //总金额计算
            if (indexPath.section==1) {
                return nil;
            }
        }
            break;
        default:
            return nil;
            break;
    }
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle cellEditingStyle=0;
    switch (tableView.tag) {
        case 1000:
            //车号选择列表
            cellEditingStyle=UITableViewCellEditingStyleNone;
            break;
        case 1001:
            //路产损坏清单
        {
            if (indexPath.section==0 && self.viewLocal==1) {
                cellEditingStyle=UITableViewCellEditingStyleDelete;
            } else {
                cellEditingStyle=UITableViewCellEditingStyleNone;
            }

        }
            break;
        default:
            break;
    }
    return cellEditingStyle;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}  

//删除路产记录
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    [context deleteObject:[self.deformList objectAtIndex:indexPath.row]];
    [[AppDelegate App] saveContext];
    [self.deformList removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    NSString *content = @"";
    for (CaseDeformation2 *caseDeformation2 in self.deformList) {
        content = [content stringByAppendingString:caseDeformation2.roadasset_name];
        if ([caseDeformation2.unit rangeOfString:@"米"].location != NSNotFound) {
            content = [content stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",caseDeformation2.quantity.doubleValue,caseDeformation2.unit]];
        } else {
            content = [content stringByAppendingString:[NSString stringWithFormat:@"%ld%@",(long)caseDeformation2.quantity.integerValue,caseDeformation2.unit]];
        }
        content = [content stringByAppendingString:@"，"];
    }
    if ([self.deformList count] > 0) {
       content = [content substringToIndex:content.length - 1];
    }
    [self.delegate2 setContent:content];
    
}

//添加路产损坏记录
-(void)addDeformationForRoadAsset:(RoadAssetPrice *)aRoadAsset andQuantity:(double)quantity withRemark:(NSString *)aRemark{
    if (![self.caseID isEmpty]) {
        CaseDeformation2 *newDeformation = [CaseDeformation2 newDataObject];
        newDeformation.caseinfo_id=self.caseID;
        newDeformation.price=aRoadAsset.price;
        newDeformation.quantity=[NSNumber numberWithDouble:quantity];
        newDeformation.rasset_size=aRoadAsset.spec;
        newDeformation.unit=aRoadAsset.unit_name;
        newDeformation.remark=aRemark;
        newDeformation.roadasset_name=aRoadAsset.name;
        newDeformation.total_price=[NSNumber numberWithDouble:aRoadAsset.price.doubleValue*quantity];
        newDeformation.assetId=aRoadAsset.roadasset_id;
        newDeformation.depart_num = aRoadAsset.depart_num;
        [[AppDelegate App] saveContext];
        //在TableView添加行
        [self.deformList addObject:newDeformation];
        [self.deformTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.deformList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        NSString *content = @"";
        for (CaseDeformation2 *caseDeformation2 in self.deformList) {
            content = [content stringByAppendingString:caseDeformation2.roadasset_name];
            if ([caseDeformation2.unit rangeOfString:@"米"].location != NSNotFound) {
                content = [content stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",caseDeformation2.quantity.doubleValue,caseDeformation2.unit]];
            } else {
                content = [content stringByAppendingString:[NSString stringWithFormat:@"%ld%@",(long)caseDeformation2.quantity.integerValue,caseDeformation2.unit]];
            }
            content = [content stringByAppendingString:@"，"];
        }
        if ([self.deformList count] > 0) {
           content = [content substringToIndex:content.length - 1];
        }
        [self.delegate2 setContent:content];
            

    }    
}

-(void)showAlertView{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"错误" message:@"无车号信息，无法记录损坏路产，请检查车辆信息记录是否存在！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}


//根据caseID初始化，重载信息
-(void)reloadInfo{
    self.caseID=[self.delegate getCaseIDdelegate];
    if (self.deformList == nil) {
        self.deformList=[[NSMutableArray alloc] initWithCapacity:1];
    } else {
        [self.deformList removeAllObjects];
    }
    [self.citizenPickerView setHidden:YES];
    if (self.viewLocal==0) {
        self.deformTableView.frame=CGRectMake(0, 0, 654, 336);
    } else if (self.viewLocal==1) {
        self.deformTableView.frame=CGRectMake(30,34, 966, 413);
    }
    self.deformList=[[CaseDeformation2 allDeformationsForCase:self.caseID] mutableCopy];
    [self.deformTableView reloadData];
    [self.view setNeedsDisplay];
}

//根据左边选择的类别，读取相应的损坏清单
-(void)reloadDeformTableView{
    if (self.deformList==nil) {
        self.deformList=[[NSMutableArray alloc] initWithCapacity:1];
    } else {
        [self.deformList removeAllObjects];
    }
    self.deformList=[[CaseDeformation2 allDeformationsForCase:self.caseID] mutableCopy];
    NSString *content = @"";
    for (CaseDeformation2 *caseDeformation2 in self.deformList) {
        content = [content stringByAppendingString:caseDeformation2.roadasset_name];
        if ([caseDeformation2.unit rangeOfString:@"米"].location != NSNotFound) {
            content = [content stringByAppendingString:[NSString stringWithFormat:@"%.2f%@",caseDeformation2.quantity.doubleValue,caseDeformation2.unit]];
        } else {
           content = [content stringByAppendingString:[NSString stringWithFormat:@"%ld%@",(long)caseDeformation2.quantity.integerValue,caseDeformation2.unit]];
        }
        content = [content stringByAppendingString:@"，"];
    }
    if ([self.deformList count] > 0) {
        content = [content substringToIndex:content.length - 1];
    }
    [self.delegate2 setContent:content];
    [self.deformTableView reloadData];
}

@end
