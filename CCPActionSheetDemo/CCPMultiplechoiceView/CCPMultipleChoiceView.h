//
//  CCPMultipleChoiceView.h
//  CCPMultipleChoiceDemo
//
//  Created by C CP on 16/7/16.
//  Copyright © 2016年 C CP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickSureBtnBlock)(NSString *combinedString,NSArray *backArray);
typedef void(^clickCancelBtnBlock)();

@interface CCPMultipleChoiceView : UIView

@property (copy,nonatomic) void (^clickSureBtnBlock)(NSString *combinedString,NSArray *backArray);
@property (copy,nonatomic) void (^clickCancelBtnBlock)();

//已经选中的数据源数组
@property (strong,nonatomic)NSArray *selectedArray;

- (instancetype)initWithDataArr:(NSArray *)dataArray andClickSureBtnBlock:(clickSureBtnBlock)clickSureBtnBlock andClickCancelBtnBlock:(clickCancelBtnBlock)clickCancelBtnBlock ;

@end
