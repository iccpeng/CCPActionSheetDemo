# CCPActionSheetDemo

##a.解决的需求:

####0.微信样式底部弹窗

####1.带有动画效果的弹窗提示框

####2.多项选择视图

##b.效果图



##c.使用示例

####1.微信样式底部弹窗示例代码如下

- (IBAction)clickStyle1Button:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    //选择数组
   
 NSArray *dataArray = [NSArray arrayWithObjects:@"小视频", @"拍照",@"从手机相册选择",@"取消",nil];
    
 CCPActionSheetView *actionSheetView = [[CCPActionSheetView alloc]initWithActionSheetArray:dataArray];
   
 //点击完成后的回调
   
 [actionSheetView cellDidSelectBlock:^(NSString *indexString, NSInteger index) {
        
        weakSelf.selectedContentLabel.text = [NSString stringWithFormat:@"%ld----%@",(long)index,indexString];
        
    }];
}

####2.带有动画效果的弹窗示例代码如下

- (IBAction)clickStyle2Button:(UIButton *)sender {
 
//自定义的弹窗view
    
 UIImageView *testView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
   
 testView.userInteractionEnabled = YES;
   
 testView.image = [UIImage imageNamed:@"image0"];

 CCPActionSheetView *alertview = [[CCPActionSheetView alloc] initWithAlertView:testView];
 
//动画样式

 alertview.viewAnimateStyle = ViewAnimateScale;
 
}


####3.多项选择示例代码如下

- (IBAction)clickMakeChoiceBtn:(UIButton *)sender {

   //测试数据源数组

    NSArray *dataArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21", nil];
    
//ClickSureBtnBlock —> 确定按钮的回调,将拼接好的字符串,以及选择成功的数组回调到当前VC

//ClickCancelBtnBlock —> 取消按钮的回调

    CCPMultipleChoiceView *ChoiceView = [[CCPMultipleChoiceView alloc] initWithDataArr:dataArray andClickSureBtnBlock:^(NSString *combinedString, NSArray *backArray) {
    
        self.choiceResultLabel.text = combinedString;
        
        NSLog(@"%@",backArray);
        
    } andClickCancelBtnBlock:^{
        
    }];
//测试已经选中的数据源数组  

如果不需要进入选择视图时显示已经选择的选项则  设置      ChoiceView.selectedArray = nil;

//如果需要进入选择视图时显示已经选择的选项 则设置已经选中的数据源数组  

//@[@"1",@"3",@"10",@"0",@"20"]; 为对应的选中数据的下标

 ChoiceView.selectedArray = @[@"1",@"3",@"10",@"0",@"20"];
 
}

