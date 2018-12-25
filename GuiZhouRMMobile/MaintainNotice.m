//
//  MaintainNoticeModel.m
//  GuiZhouRMMobile
//
//  Created by maijunjin on 15/10/9.
//
//

#import "MaintainNotice.h"

@implementation MaintainNotice
@dynamic subscriber_name;
@dynamic myid;
@dynamic organization_id;
@dynamic reason;
@dynamic subscriber_date;
@dynamic remark;
@dynamic maintain_cd;
@dynamic date_underwrite;
@dynamic mydescription;
@dynamic roadasset;
@dynamic roadsegment_id;
@dynamic inspectionRecord_id;
@dynamic isuploaded;
- (id)initWithinitWithMaintainNotice:(MaintainNotice *)maintainNotice{
    
    self = [super init];
    if (self && maintainNotice) {
        self.subscriber_name = maintainNotice.subscriber_name;
        self.myid = maintainNotice.myid;
        self.organization_id = maintainNotice.organization_id;
        self.reason = maintainNotice.reason;
        self.subscriber_date = maintainNotice.subscriber_date;
        self.remark = maintainNotice.remark;
        self.maintain_cd = maintainNotice.maintain_cd;
        self.date_underwrite = maintainNotice.date_underwrite;
        self.mydescription = maintainNotice.mydescription;
        self.roadasset = maintainNotice.roadasset;
        self.roadsegment_id = maintainNotice.roadsegment_id;
        
    } else {
        return nil;
    }
    return self;

}
+ (id) maintainNoticeForInspectionRecord:(NSString *)inspectionRecord_id{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"MaintainNotice" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"inspectionRecord_id==%@",inspectionRecord_id];
    fetchRequest.predicate=predicate;
    fetchRequest.entity=entity;
    NSArray *fetchResult=[context executeFetchRequest:fetchRequest error:nil];
    if (fetchResult.count>0) {
        return [fetchResult objectAtIndex:0];
    } else {
        return nil;
    }
}
@end
