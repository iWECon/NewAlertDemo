//
//  IWTipsView.h
//  NetWorking
//
//  Created by iWe on 2016/3/18.
//  Copyright © 2016年 iWe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^cancelBlock)();
typedef void (^okBlock)();

@interface IWNewAlert : UIView

//@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

/*
 显示
 */
- (void)show;


/*
 默认初始化
 content        要提示的内容
 cancelAction   取消按钮做什么事
 okAction       确认按钮做什么事
 */
+ (instancetype)setTipsContentWithContent:(NSString *)content
                             calcelAction:(cancelBlock)cancelBlock
                                 okAction:(okBlock)okBlock;


/*
 初始化 带缩放效果
 view 一般输入为self.view;
 */
- (void)showWithScaleCurrentView:(UIView *)view;


@end
