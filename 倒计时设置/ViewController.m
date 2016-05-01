//
//  ViewController.m
//  倒计时设置
//
//  Created by G.Z on 16/5/1.
//  Copyright © 2016年 GZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation ViewController


/** 开始 */
- (IBAction)start
{
    // 倒计时10秒，每秒更新一下Label的显示
    // 计时器
    /**
     参数说明
     1. 时间间隔，double
     2. 监听时钟触发的对象
     3. 调用方法
     4. userInfo，可以是任意对象，通常传递nil
     5. repeats：是否重复
     */
    self.counterLabel.text = @"10";
    
    // scheduledTimerWithTimeInterval 方法本质上就是创建一个时钟，
    // 添加到运行循环的模式是DefaultRunLoopMode
    // ----------------------------------------------
    // 1>
    //    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:@"hello timer" repeats:YES];
    
    // ----------------------------------------------
    // 2> 与1等价
    //    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    //    // 将timer添加到运行循环
    //    // 模式：默认的运行循环模式
    //    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    // ----------------------------------------------
    // 3>
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    // 将timer添加到运行循环
    // 模式：NSRunLoopCommonModes的运行循环模式（监听滚动模式）
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    //[self updateTimer:self.timer];
}

/** 时钟更新方法 */
- (void)updateTimer:(NSTimer *)timer
{
    // NSLog(@"%s", __func__);
    // 1. 取出标签中的数字
    int counter = self.counterLabel.text.intValue;
    
    // 2. 判断是否为零，如果为0，停止时钟
    if (--counter < 0) {
        // 停止时钟
        [self pause];
        
        // 提示用户，提示框
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"开始" message:@"开始啦......" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", @"哈哈", nil];
        //
        //        [alert show];
        [[[UIAlertView alloc] initWithTitle:@"开始" message:@"开始啦......" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", @"哈哈", nil] show];
    } else {
        // CTRL + I
        // 3. 修改数字并更新UI
        self.counterLabel.text = [NSString stringWithFormat:@"%d", counter];
    }
}

/** 暂停 */
- (IBAction)pause
{
    // 停止时钟，invalidate是唯一停止时钟的方法
    // 一旦调用了invalidate方法，timer就无效了，如果再次启动时钟，需要重新实例化
    [self.timer invalidate];
}

#pragma mark - alertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ldaaa-------", (long)buttonIndex);
}


@end
