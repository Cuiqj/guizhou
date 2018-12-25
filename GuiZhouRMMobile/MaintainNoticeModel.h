//
//  ParkingNodeModel.h
//  GuiZhouRMMobile
//
//  Created by Sniper One on 12-10-29.
//
//

#import "UpDataModel.h"
#import "MaintainNotice.h"

@interface MaintainNoticeModel : UpDataModel
@property (nonatomic, retain) NSString * subscriber_name;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * organization_id;
@property (nonatomic, retain) NSString * reason;
@property (nonatomic, retain) NSString * subscriber_date;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSString * maintain_cd;
@property (nonatomic, retain) NSString * date_underwrite;
@property (nonatomic, retain) NSString * description;
@property (nonatomic, retain) NSString * roadasset;
@property (nonatomic, retain) NSString * roadsegment_id;



- (id)initWithMaintainNotice:(MaintainNotice *)maintainNotice;
@end
