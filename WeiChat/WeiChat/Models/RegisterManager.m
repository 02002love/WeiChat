//
//  RegisterManager.m
//  WeiChat
//
//  Created by JinWei on 15/8/13.
//  Copyright (c) 2015年 SongJinWei. All rights reserved.
//

#import "RegisterManager.h"

static RegisterManager * manager = nil;

@implementation RegisterManager


+(instancetype)sharedManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RegisterManager alloc]init];
    });

    return manager;

}

@end
