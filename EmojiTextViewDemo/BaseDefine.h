//
//  BaseDefine.h
//  utt
//
//  Created by lixy on 14/10/9.
//  Copyright (c) 2014年 lixy. All rights reserved.
//

#ifndef utt_BaseDefine_h
#define utt_BaseDefine_h

//自定义NavBar的高度
#define NavBarHeight 44

//自定义TabBar的高度
#define TabBarHeight 49

//状态条的高
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

//得到屏幕bounds
#define MainScreenSize [UIScreen mainScreen].bounds

//得到屏幕高度
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height

//得到屏幕宽度
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width

//定义系统版本
#define SysVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#endif
