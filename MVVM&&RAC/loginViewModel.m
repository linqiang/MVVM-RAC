//
//  loginViewModel.m
//  MVVM&&RAC
//
//  Created by zhi on 2018/5/7.
//  Copyright © 2018年 zhi. All rights reserved.
//

#import "loginViewModel.h"

@implementation loginViewModel


- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    // 当文本框中有字符再点击
    _loginSingal = [RACSignal combineLatest:@[RACObserve(self, nameStr),RACObserve(self, pwdStr)] reduce:^id(NSString *name,NSString *pwd){
        return @(name.length&&pwd.length);
    }];
    
    // 2.处理登录点击命令
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block:执行命令就会调用
        // block作用:事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                // 发送数据
                [subscriber sendNext:@"请求登录的数据"];
                [subscriber sendCompleted];
            });
            
            return nil;
            
        }];
    }];
    
    // 3.处理登录请求返回的结果
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 4.处理登录执行过程
    [[_loginCommand.executing skip:1] subscribeNext:^(id x) {
        
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            
            
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
        
    }];
    

}
@end
