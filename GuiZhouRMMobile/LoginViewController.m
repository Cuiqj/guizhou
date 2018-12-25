//
//  LoginViewController.m
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-9-21.
//
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (nonatomic,assign) NSInteger touchTextTag;
@property (nonatomic,retain) UIPopoverController *pickerPopover;
@property (nonatomic,retain) NSString *loginUserID;
@end

@implementation LoginViewController
@synthesize textUser;
@synthesize textPassword;
@synthesize textInspector1;
@synthesize textInspector2;
@synthesize textInspector3;
@synthesize textInspector4;
@synthesize touchTextTag = _touchTextTag;
@synthesize loginUserID = _loginUserID;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:animated];
    }
    
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [self setTextUser:nil];
    [self setTextPassword:nil];
    [self setTextInspector1:nil];
    [self setTextInspector2:nil];
    [self setTextInspector3:nil];
    [self setTextInspector4:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)btnOK:(UIBarButtonItem *)sender {
    if (![self.textUser.text isEmpty]) {
//        NSString *password = [self.textPassword.text encryptedString];
//        UserInfo *userInfo = [UserInfo userInfoForUserID:self.loginUserID];
//        if ([password isEqualToString:userInfo.password]) {
        if (1) {
            [[NSUserDefaults standardUserDefaults] setValue:self.loginUserID forKey:USERKEY];
            [self.delegate reloadUserLabel];
            
            NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:1];
            if (![self.textInspector1.text isEmpty]) {
                [temp addObject:self.textInspector1.text];
            }
            if (![self.textInspector2.text isEmpty]) {
                [temp addObject:self.textInspector2.text];
            }
            if (![self.textInspector3.text isEmpty]) {
                [temp addObject:self.textInspector3.text];
            }
            if (![self.textInspector4.text isEmpty]) {
                [temp addObject:self.textInspector4.text];
            }
            NSArray *inspectorArray = [NSArray arrayWithArray:temp];
            [[NSUserDefaults standardUserDefaults] setObject:inspectorArray forKey:INSPECTORARRAYKEY];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self dismissModalViewControllerAnimated:YES];
        } else {
            void(^ShowAlert)(void)=^(void){
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误" message:@"密码错误!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            };
            MAINDISPATCH(ShowAlert);
        }
    }    
}

- (IBAction)userSelect:(UITextField *)sender {
    if ((self.touchTextTag == sender.tag) && ([self.pickerPopover isPopoverVisible])) {
       [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        self.touchTextTag=sender.tag;
        UserPickerViewController *acPicker=[[UserPickerViewController alloc] init];
        acPicker.delegate=self;
        if (sender.tag == 10) {
            acPicker.pickerState = kUser;
        } else {
            acPicker.pickerState = kEmployee;
        }
        self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:acPicker];
        [self.pickerPopover setPopoverContentSize:CGSizeMake(140, 200)];
        [self.pickerPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        acPicker.pickerPopover=self.pickerPopover;
    }     
}

- (void)setUser:(NSString *)name andUserID:(NSString *)userID{
    if (self.touchTextTag==10) {
        self.loginUserID=userID;
    }
    [(UITextField *)[self.view viewWithTag:self.touchTextTag] setText:name];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}
@end
