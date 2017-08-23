//
//  GeneralConfigureMarco.h
//  Smartbudget
//
//  Created by Daisy on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#ifndef GeneralConfigureMarco_h
#define GeneralConfigureMarco_h

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])


//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]


//Log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//设置随机色
#define RandomColor \
[UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:\arc4random_uniform(256)/255.0 alpha:1.0]

////弱引用/强引用
//#define WeakSelf(type) __weak typeof(type) weak##type = type;
//#define StrongSelf(type)  __strong typeof(type) type = weak##type;
//
////设置 view 圆角和边框
//#define LRViewBorderRadius(View, Radius, Width, Color)\
//\
//[View.layer setCornerRadius:(Radius)];\
//[View.layer setMasksToBounds:YES];\
//[View.layer setBorderWidth:(Width)];\
//[View.layer setBorderColor:[Color CGColor]]

#endif /* GeneralConfigureMarco_h */
