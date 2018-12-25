//
//  CaseDocumentsViewController.h
//  GuiZhouRMMobile
//
//  Created by yu hongwu on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaseIDHandler.h"
#import "CasePrintViewController.h"
#import "CaseDocuments.h"

@protocol CaseDocumentsDelegate <NSObject>
-(void)reloadPDFView;
@end





@interface CaseDocumentsViewController : UIViewController<UIPrintInteractionControllerDelegate,UINavigationControllerDelegate,UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate,CaseDocumentsDelegate> {
    CGPoint svos;
}

@property (nonatomic,weak) IBOutlet UIScrollView  * editorView;
@property (nonatomic,weak) IBOutlet UIWebView     * pdfView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonPrintPreview;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonPrintFull;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonPrintForm;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonPreDoc;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonNextDoc;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonReDefault;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonDeleteDoc;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonSetMargin;
@property (nonatomic,assign) DocPrinterState docPrinterState;
@property (nonatomic,retain) CasePrintViewController *docPrinter;
@property (nonatomic,copy) NSString * caseID;
@property (nonatomic,copy) NSString * fileName;
@property (nonatomic,weak) id<CaseIDHandler> docReloadDelegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButton;

- (IBAction)pageControl:(id)sender;
- (IBAction)btnPrintFormedPDF:(id)sender;
- (IBAction)btnPrintFullPDF:(id)sender;
- (IBAction)btnPrintPreview:(id)sender;

- (IBAction)btnPreDoc:(UIButton *)sender;
- (IBAction)btnNextDoc:(UIButton *)sender;
- (IBAction)btnRegenerateDefaultInfo:(id)sender;
- (IBAction)btnDeleteDoc:(id)sender;

- (IBAction)barButtonSave:(UIBarButtonItem *)sender;
- (IBAction)setMargin:(UIButton *)sender;

@end
