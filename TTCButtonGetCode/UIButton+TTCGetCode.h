//
//  UIButton+TTCGetCode.h
//  TTCButtonBlockDemo
//
//  Created by TT_Cindy on 2017/10/26.
//  Copyright © 2017年 TT_Cindy. All rights reserved.
//  参考 CaiWanFeng 。原地址：https://github.com/CaiWanFeng/CQCountDownButton
//  进行修改，并非原创，谢谢。
//

#import <UIKit/UIKit.h>

@interface UIButton (TTCGetCode)
/*
 @param time 计时周期
 @param buttonClicked 点击事件回调的block
 @param countDownStart 开始计时回调的block
 @param countDownUnderway 正在计时回调的block
 @param countDownCompletion 计时完成回调的block
 **/
- (void)TTC_startCountDownWitTime:(NSInteger)time
                buttonClicked:(void(^)(void))buttonClicked
            countDownUnderway:(void(^)(NSInteger restCountDownNum))countDownUnderway
          countDownCompletion:(void(^)(void))countDownCompletion;

@end
