//
//  AutoNumerPickerViewController.h
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kCarType = 0,
    kNexus,
    kCarTradeMark,
    kProfession
}AutoNumberPickerType;

@protocol AutoNumberPickerDelegate;

@interface AutoNumerPickerViewController : UITableViewController
@property (nonatomic,assign) AutoNumberPickerType pickerType;
@property (nonatomic,copy) NSString *caseID;
@property (nonatomic,weak) UIPopoverController *popOver;
@property (nonatomic,weak) id<AutoNumberPickerDelegate> delegate;
@end

@protocol AutoNumberPickerDelegate <NSObject>

-(void)setAutoNumberText:(NSString *)aAuotNumber;

@end