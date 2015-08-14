//
//  RegisterManager.h
//  WeiChat
//
//  Created by JinWei on 15/8/13.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterManager : NSObject

@property (nonatomic,copy)NSString * userName;

@property (nonatomic,copy)NSString * nickName;

@property (nonatomic,strong)UIImage * headImage;

@property (nonatomic,copy)NSString * birthday;

@property (nonatomic,copy)NSString * sex;

@property (nonatomic,copy)NSString * phoneNum;

@property (nonatomic,copy)NSString * password;
//签名
@property (nonatomic,copy)NSString * signature;

@property (nonatomic,copy)NSString * address;
//单例
+(instancetype)sharedManager;

@end
