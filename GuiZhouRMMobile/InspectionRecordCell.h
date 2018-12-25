//
//  InspectionRecordCell.h
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-9-3.
//
//

#import <UIKit/UIKit.h>

@interface InspectionRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelRemark;
@property (weak, nonatomic) IBOutlet UILabel *labelStation;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *addSunShi;
@property (weak, nonatomic) IBOutlet UIButton *pringSunshi;
- (IBAction)pringSunshi:(id)sender ;
@end
