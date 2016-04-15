//
//  ViewController.m
//  NewAlertDemo
//
//  Created by iWe on 16/4/15.
//  Copyright © 2016年 iWe. All rights reserved.
//

#import "ViewController.h"
#import "IWNewAlert.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton * buttonOne;
@property (nonatomic, strong) UIButton * buttonTwo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (UIView * subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            if (subView.tag == 2015) {
                self.buttonOne = (UIButton *)subView;
                continue;
            }
            if (subView.tag == 2016) {
                self.buttonTwo = (UIButton *)subView;
                break;
            }
            
        }
    }
    
    [self.buttonOne addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonTwo addTarget:self action:@selector(showAlertWithScale) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)showAlert {
    IWNewAlert * newAlert = [IWNewAlert setTipsContentWithContent:@"这是一个新设计的弹框提示" calcelAction:^{
        NSLog(@"点击了取消按钮");
    } okAction:^{
        NSLog(@"点击了确定按钮");
    }];
    [newAlert show];
}


- (void)showAlertWithScale {
    IWNewAlert * newAlert = [IWNewAlert setTipsContentWithContent:@"这是一个新设计的弹框提示\n这是一个新设计的弹框提示\n这是一个新设计的弹框提示\n这是一个新设计的弹框提示\n这是一个新设计的弹框提示\n" calcelAction:^{
        NSLog(@"点击了取消按钮");
    } okAction:^{
        NSLog(@"点击了确定按钮");
    }];
    [newAlert showWithScaleCurrentView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
