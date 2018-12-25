//
//  InspectionUpLoader.m
//  GuiZhouRMMobile
//
//  Created by Sniper One on 12-10-29.
//
//

#import "MaintainNoticeModelUpLoader.h"

@implementation MaintainNoticeModelUpLoader

- (void)upLoadProcess{
    NSArray *upLoadArray = [MaintainNotice uploadArrayOfObject];
    if (upLoadArray.count > 0) {
        self.uploadObjArray = upLoadArray;
        NSMutableArray *recordModelArray = [[NSMutableArray alloc] initWithCapacity:1];
        for (MaintainNotice *record in upLoadArray) {
            MaintainNoticeModel *recordModel = [[MaintainNoticeModel alloc] initWithMaintainNotice:record];
            [recordModelArray addObject:recordModel];
        }



        WebUpLoadInit;
        [service upLoadMaintainNotice:recordModelArray];
    } else {
         [[NSNotificationCenter defaultCenter] postNotificationName:FINISHNOTINAME object:nil];
    }
}

- (void)updateProgress{
    [super updateProgress];
    
    
    for (MaintainNotice *record in self.uploadObjArray) {
        record.isuploaded = @(YES);
    }
    
    
    
    [[AppDelegate App] saveContext];
    [self upLoadProcess];
}
@end
