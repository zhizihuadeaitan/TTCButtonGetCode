//
//  UIButton+TTCGetCode.m
//  TTCButtonBlockDemo
//
//  Created by TT_Cindy on 2017/10/26.
//  Copyright © 2017年 TT_Cindy. All rights reserved.
//

#import "UIButton+TTCGetCode.h"
#import <objc/runtime.h>

typedef void(^ButtonClickedBlock)(void);
typedef void(^CountDownStartBlock)(void);
typedef void(^CountDownUnderwayBlock)(NSInteger restCountDownNum);
typedef void(^CountDownCompletionBlock)(void);
@interface UIButton ()


/** 按钮点击事件的回调 */
@property (nonatomic, copy) ButtonClickedBlock buttonClickedBlock;
/** 倒计时进行中的回调（每秒一次） */
@property (nonatomic, copy) CountDownUnderwayBlock countDownUnderwayBlock;
/** 倒计时完成时的回调 */
@property (nonatomic, copy) CountDownCompletionBlock countDownCompletionBlock;

@end

@implementation UIButton (TTCGetCode)

static void *TTC_ClickedBlockKey = &TTC_ClickedBlockKey;


- (ButtonClickedBlock)buttonClickedBlock {
    return objc_getAssociatedObject(self, &TTC_ClickedBlockKey);
}

- (void)setButtonClickedBlock:(ButtonClickedBlock)TTC_buttonEventsBlock {
    objc_setAssociatedObject(self, &TTC_ClickedBlockKey, TTC_buttonEventsBlock, OBJC_ASSOCIATION_COPY);
}

static void *TTC_CountDownUnderwayBlockKey = &TTC_CountDownUnderwayBlockKey;

- (CountDownUnderwayBlock)countDownUnderwayBlock {
    return objc_getAssociatedObject(self, &TTC_CountDownUnderwayBlockKey);
}

- (void)setCountDownUnderwayBlock:(CountDownUnderwayBlock)TTC_buttonEventsBlock {
    objc_setAssociatedObject(self, &TTC_CountDownUnderwayBlockKey, TTC_buttonEventsBlock, OBJC_ASSOCIATION_COPY);
}

static void *TTC_CountDownCompletionBlockKey = &TTC_CountDownCompletionBlockKey;

- (CountDownCompletionBlock)countDownCompletionBlock {
    return objc_getAssociatedObject(self, &TTC_CountDownCompletionBlockKey);
}

- (void)setCountDownCompletionBlock:(CountDownCompletionBlock)TTC_buttonEventsBlock {
    objc_setAssociatedObject(self, &TTC_CountDownCompletionBlockKey, TTC_buttonEventsBlock, OBJC_ASSOCIATION_COPY);
}


- (void)TTC_startCountDownWitTime:(NSInteger)time
                buttonClicked:(void(^)(void))buttonClicked
            countDownUnderway:(void(^)(NSInteger restCountDownNum))countDownUnderway
          countDownCompletion:(void(^)(void))countDownCompletion
{
    self.buttonClickedBlock     = buttonClicked;
    self.countDownUnderwayBlock  = countDownUnderway;
    self.countDownCompletionBlock  = countDownCompletion;
    self.tag = (NSInteger)time;
    [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

/** 按钮点击 */
- (void)buttonClicked:(UIButton *)sender {
    sender.enabled = NO;
    [self startCountDown];
}
/** 开始倒计时 */
- (void)startCountDown {
    // 倒计时时间
    __block NSInteger timeOut = (NSInteger)self.tag;
    __weak __typeof__(self) weakSelf = self;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    NSLog(@"计时开始");
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            weakSelf.countDownCompletionBlock();
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.userInteractionEnabled = YES;
                weakSelf.enabled = YES;
            });
            
        }else{
            weakSelf.countDownUnderwayBlock(timeOut);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    dispatch_resume(_timer);
    self.buttonClickedBlock(); // 调用倒计时开始的block
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
