//
//  MaintainNoticeModel.h
//  GuiZhouRMMobile
//
//  Created by maijunjin on 15/10/9.
//
//

#import <Foundation/Foundation.h>

@interface MaintainNotice : NSManagedObject <UploadDataProtocol>

@property (nonatomic, retain) NSString * subscriber_name;
@property (nonatomic, retain) NSString * myid;
@property (nonatomic, retain) NSString * organization_id;
@property (nonatomic, retain) NSString * reason;
@property (nonatomic, retain) NSDate * subscriber_date;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSString * maintain_cd;
@property (nonatomic, retain) NSDate * date_underwrite;
@property (nonatomic, retain) NSString * mydescription;
@property (nonatomic, retain) NSString * roadasset;
@property (nonatomic, retain) NSString * roadsegment_id;
@property (nonatomic, retain) NSString * inspectionRecord_id;
@property (nonatomic, retain) NSNumber * isuploaded;
- (id)initWithinitWithMaintainNotice:(MaintainNotice *)maintainNotice;
+ (id) maintainNoticeForInspectionRecord:(NSString *)inspectionRecord_id;
@end
