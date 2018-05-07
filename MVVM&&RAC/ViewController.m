//
//  ViewController.m
//  MVVM&&RAC
//
//  Created by zhi on 2018/5/7.
//  Copyright © 2018年 zhi. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
#import "loginViewModel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) loginViewModel *loginViewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self bindSignal];
}

//绑定信号 && 处理事件
- (void)bindSignal{
    RAC(self.loginViewModel,nameStr) = _nameTF.rac_textSignal;
    RAC(self.loginViewModel,pwdStr) = _pwdTF.rac_textSignal;
    
    RAC(_loginBtn,enabled) = self.loginViewModel.loginSingal;
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self.loginViewModel.loginCommand execute:nil];
    }];
    
}


- (loginViewModel *)loginViewModel{
    if (_loginViewModel == nil) {
        _loginViewModel = [[loginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
