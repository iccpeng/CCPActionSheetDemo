//
//  ViewController.m
//  CCPActionSheetDemo
//
//  Created by C CP on 16/7/20.
//  Copyright © 2016年 C CP. All rights reserved.
//

#import "ViewController.h"
#import "CCPActionSheetView.h"
#import "CCPMultipleChoiceView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *selectedContentLabel;

@property (nonatomic,strong) CCPActionSheetView *actionSheetView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//多项选择
- (IBAction)clickStyle0Button:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    NSArray *dataArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21", nil];
    
    CCPMultipleChoiceView *ChoiceView = [[CCPMultipleChoiceView alloc] initWithDataArr:dataArray andClickSureBtnBlock:^(NSString *combinedString, NSArray *backArray) {
        weakSelf.selectedContentLabel.text = combinedString;
        NSLog(@"%@",backArray);
        
    } andClickCancelBtnBlock:^{
        
        
    }];
    //已经选中的选项数组
    ChoiceView.selectedArray = @[@"1",@"3",@"10",@"0",@"20"];
    //    ChoiceView.selectedArray = nil;

}

//微信样式的底部选择菜单
- (IBAction)clickStyle1Button:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    NSArray *dataArray = [NSArray arrayWithObjects:@"小视频", @"拍照",@"从手机相册选择",@"取消",nil];
    
  CCPActionSheetView *actionSheetView = [[CCPActionSheetView alloc]initWithActionSheetArray:dataArray];
    
    [actionSheetView cellDidSelectBlock:^(NSString *indexString, NSInteger index) {
        
        weakSelf.selectedContentLabel.text = [NSString stringWithFormat:@"%ld----%@",(long)index,indexString];
        
        
    }];
    
}


//带有遮罩的弹窗 --只需要传入自定义的弹窗 view
- (IBAction)clickStyle2Button:(UIButton *)sender {
    
    UIImageView *testView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    testView.userInteractionEnabled = YES;
    
    testView.image = [UIImage imageNamed:@"image0"];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(180, 0, 120, 120)];
    
    [button setBackgroundImage:[UIImage imageNamed:@"image1"] forState:UIControlStateNormal];
    
    [button setTitle:@"clcikMe" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [testView addSubview:button];
    
    
    CCPActionSheetView *alertview = [[CCPActionSheetView alloc] initWithAlertView:testView];
    self.actionSheetView = alertview;
    if (sender.tag == 100) {
        
        alertview.viewAnimateStyle = ViewAnimateScale;

    } else if (sender.tag == 101) {
        
        alertview.viewAnimateStyle = ViewAnimateFromLeft;

    }else if (sender.tag == 102) {
        
        alertview.viewAnimateStyle = ViewAnimateFromRight;

    }else if (sender.tag == 103) {
        
        alertview.viewAnimateStyle = ViewAnimateFromTop;

    }else if (sender.tag == 104) {
        alertview.viewAnimateStyle = ViewAnimateFromBottom;

        
    }else  {
        alertview.viewAnimateStyle = ViewAnimateNone;
        
    }

}

- (void)clickButton {
    
    [self.actionSheetView closeAlertView:^{
        
        NSLog(@"点击按钮,取消弹窗");
        
    }];
    
}

@end
