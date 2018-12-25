//
//  ParkingNodeModel.m
//  GuiZhouRMMobile
//
//  Created by Sniper One on 12-10-29.
//
//

#import "MaintainNoticeModel.h"

@implementation MaintainNoticeModel
- (id)initWithMaintainNotice:(MaintainNotice *)maintainNotice{
    self = [super init];
    if (self && maintainNotice) {
        self.subscriber_name = maintainNotice.subscriber_name;
        self.id = maintainNotice.myid;
        self.organization_id = maintainNotice.organization_id;
        self.reason = maintainNotice.reason;
        self.subscriber_date = [self.dateFormatter stringFromDate:maintainNotice.subscriber_date];
        self.remark = maintainNotice.remark;
        self.maintain_cd = maintainNotice.maintain_cd;
        self.date_underwrite = [self.dateFormatter stringFromDate:maintainNotice.date_underwrite];
        self.description = maintainNotice.mydescription;
        self.roadasset = maintainNotice.roadasset;
        self.roadsegment_id = maintainNotice.roadsegment_id;
    
    } else {
        return nil;
    }
    return self;
}
@end
