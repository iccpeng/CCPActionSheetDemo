//
//  CCPMultipleChoiceView.m
//  CCPMultipleChoiceDemo
//
//  Created by C CP on 16/7/16.
//  Copyright © 2016年 C CP. All rights reserved.
//

#import "CCPMultipleChoiceView.h"
#import "CCPMultipleChoiceCell.h"
#import "UIView+CCPExtension.h"
#define CCPWIDTH [UIScreen mainScreen].bounds.size.width
#define CCPHEIGHT [UIScreen mainScreen].bounds.size.height

@interface CCPMultipleChoiceView ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSArray *dataArray;

@property (strong,nonatomic) NSMutableArray *selectDataArray;

@property (strong,nonatomic) NSMutableArray *backArray;

@property (copy,nonatomic) NSString *combinedString;

@property (nonatomic,strong) UITableView *showTableView;

@property (nonatomic,strong) UIView *showTableHeaderView;

@property (nonatomic,assign) CGFloat recodeTableViewHeight;

@end

@implementation CCPMultipleChoiceView

- (UITableView *)showTableView {
    
    if (_showTableView == nil) {
        
        _showTableView = [[UITableView alloc] init];
        
        NSAssert(self.dataArray.count > 0, @"self.dataArray.count = 0 or self.dataArray = nil");
        
        CGFloat showTableViewHeight = (self.dataArray.count + 1) * 44;
        
        if (showTableViewHeight > CCPHEIGHT/3 * 2) {
            
            showTableViewHeight = CCPHEIGHT/3 * 2;
            
        }
        
        self.recodeTableViewHeight = showTableViewHeight;

        _showTableView.frame = CGRectMake(0, CCPHEIGHT, CCPWIDTH, showTableViewHeight);
       
        
    }
    
    return _showTableView;
    
}


- (UIView *)showTableHeaderView {
    
    if (_showTableHeaderView == nil) {
        
        _showTableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CCPWIDTH, 44)];
        
        //cancel button
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 80, 40)];
        [cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [_showTableHeaderView addSubview:cancelBtn];
        cancelBtn.centerY = _showTableHeaderView.centerY;
        
        //sure button
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(CCPWIDTH - 80 - 15, 10, 80 , 40)];
        [sureBtn setTitle:@"sure" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
        [_showTableHeaderView addSubview:sureBtn];
        sureBtn.centerY = _showTableHeaderView.centerY;
        
    }
    
    return _showTableHeaderView;
    
}


- (NSMutableArray *)selectDataArray {
    
    if (_selectDataArray == nil) {
        
        _selectDataArray = [NSMutableArray array];
        
        for (int i = 0; i < self.dataArray.count; i ++) {
            
            [_selectDataArray addObject:@""];
        }
    }
    return _selectDataArray;
}

- (NSMutableArray *)backArray {
    
    if (_backArray == nil) {
        _backArray = [NSMutableArray array];
    }
    return _backArray;
    
}


- (void)setSelectedArray:(NSArray *)selectedArray {
    
    _selectedArray = selectedArray;
    
     NSAssert(selectedArray.count <= self.dataArray.count , @"self.dataArray.count = 0 or self.dataArray = nil");
    
    for (NSString *indexString in selectedArray) {
        
        NSUInteger index = [indexString integerValue];
        
        NSAssert(selectedArray.count <= self.dataArray.count && index <= self.dataArray.count - 1, @"The selectedArray is error");
        
       [self.selectDataArray replaceObjectAtIndex:index withObject:self.dataArray[index]];
        
    }
    
    [self.backArray removeAllObjects];
    
    for (NSString *backString in self.selectDataArray) {
        
        if (![backString isEqualToString:@""]) {
            
            [self.backArray addObject:backString];
        }
    }
    
    self.combinedString = [self.backArray componentsJoinedByString:@","];
    
}

- (void)clickCancelBtn {
    
    if (self.clickCancelBtnBlock) {
        
        self.clickCancelBtnBlock();
    }
    
    [self dissMissView];
}

- (void)clickSureBtn {
    
    if (self.clickSureBtnBlock) {
        
        self.clickSureBtnBlock(self.combinedString,self.backArray);
    }
    [self dissMissView];
}

static NSString *cellIdentifier = @"MultipleChoiceCell";

- (instancetype)initWithDataArr:(NSArray *)dataArray andClickSureBtnBlock:(clickSureBtnBlock)clickSureBtnBlock andClickCancelBtnBlock:(clickCancelBtnBlock)clickCancelBtnBlock {
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.clickSureBtnBlock = clickSureBtnBlock;
        self.clickCancelBtnBlock = clickCancelBtnBlock;
        self.dataArray = dataArray;
        [self.showTableView registerNib:[UINib nibWithNibName:@"CCPMultipleChoiceCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        self.showTableView.dataSource = self;
        self.showTableView.delegate = self;
        self.showTableView.tableHeaderView = self.showTableHeaderView;
        
        [self addSubview:self.showTableView];
        
        [UIView animateWithDuration:.3 animations:^{
            
            self.showTableView.y = CCPHEIGHT - self.recodeTableViewHeight;
            
        }];
        
        UIWindow *currentWindows = [UIApplication sharedApplication].keyWindow;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
        
        currentWindows.backgroundColor = [UIColor redColor];
        [currentWindows addSubview:self];
        
    }
    
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CCPMultipleChoiceCell *multipleChoiceCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    multipleChoiceCell.HUDBtn.selected = [self.selectDataArray[indexPath.row] isEqualToString:@""] ? NO:YES;
    
    multipleChoiceCell.selectedBackgroundView = [[UIView alloc] initWithFrame:multipleChoiceCell.frame];
    multipleChoiceCell.selectedBackgroundView.backgroundColor = [UIColor redColor];
    
    multipleChoiceCell.showInfoLabel.text = self.dataArray[indexPath.row];
    
    return multipleChoiceCell;
    
}

- (BOOL)isSelected:(NSInteger)row {
    
    return [self.selectDataArray[row] isEqualToString:@""];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CCPMultipleChoiceCell *cell = (CCPMultipleChoiceCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.HUDBtn.selected) {
        
        cell.HUDBtn.selected = NO;
    } else {
        
        cell.HUDBtn.selected = YES;
    }
    
    NSString *selectString = @"";
    if (cell.HUDBtn.selected == YES) {
      selectString = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
    } else {
        selectString = @"";
    }
    
    [self.selectDataArray replaceObjectAtIndex:indexPath.row withObject:selectString];
    
    [self.backArray removeAllObjects];

    for (NSString *backString in self.selectDataArray) {
        
        if (![backString isEqualToString:@""]) {
            
            [self.backArray addObject:backString];
        }
    }
    
    self.combinedString = [self.backArray componentsJoinedByString:@","];
//    NSLog(@"%@",self.backArray);
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dissMissView];
}

- (void)dissMissView{
    
    [UIView animateWithDuration:.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.showTableView.frame = CGRectMake(0, CCPHEIGHT, CCPWIDTH, self.recodeTableViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
