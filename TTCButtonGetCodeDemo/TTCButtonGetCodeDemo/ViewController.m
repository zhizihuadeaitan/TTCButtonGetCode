//
//  ViewController.m
//  TTCButtonGetCodeDemo
//
//  Created by TT_Cindy on 2017/10/26.
//  Copyright © 2017年 TT_Cindy. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+TTCGetCode.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    countDownBtn.frame = CGRectMake(150, 64, 60, 60 );
    countDownBtn.layer.cornerRadius = 60 / 2;
    countDownBtn.backgroundColor = [UIColor redColor];
    [countDownBtn setTitle:@"倒计时" forState:UIControlStateNormal];
    [self.view addSubview:countDownBtn];
    
    [countDownBtn TTC_startCountDownWitTime:10 buttonClicked:^{
        NSLog(@"点击" );
        
    } countDownUnderway:^(NSInteger restCountDownNum) {
        //------- 倒计时进行中 -------//
        NSLog(@"倒计时:%ld",restCountDownNum);
        dispatch_async(dispatch_get_main_queue(), ^{
            [countDownBtn setTitle:[NSString stringWithFormat:@"%ld秒", restCountDownNum] forState:UIControlStateNormal];
        });
    } countDownCompletion:^{
        //------- 倒计时结束 -------//
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [countDownBtn setTitle:@"倒计时" forState:UIControlStateNormal];
            NSLog(@"倒计时结束");
        });
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
