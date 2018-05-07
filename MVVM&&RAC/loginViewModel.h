//
//  loginViewModel.h
//  MVVM&&RAC
//
//  Created by zhi on 2018/5/7.
//  Copyright © 2018年 zhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
@interface loginViewModel : NSObject
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) NSString *pwdStr;
@property (nonatomic, strong) RACSignal *loginSingal;
@property (nonatomic, strong) RACCommand *loginCommand;
@end
