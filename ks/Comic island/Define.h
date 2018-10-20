//
//  Define.h
//  Comic island
//
//  Created by qianfeng on 15-10-21.
//  Copyright (c) 2015年 李金龙. All rights reserved.
//

#ifndef Comic_island_Define_h
#define Comic_island_Define_h


#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDevice_Is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDevice_Is_iPhoneXsM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
//清缓存宏定义
#define _CH @"Cache"

//title的key
#define TITLE @"TITLE"

//navgationBar的title的key
#define NAV_TITLE @"NAV_TITLE"

//tabar的title的key
#define TAB_TITLE @"TAB_TITLE"

//tabarItem 图片
#define TABAR_ITEM_IMAGE @"TABAR_ITEM_IMAGE"

//选中的图片
#define TABAR_SET_ITEM_IMAGE @"TABAR_SET_ITEM_IMAGE"

//字体颜色
#define TITLE_COLOR [UIColor colorWithRed:0.95f green:0.53f blue:0.40f alpha:1.00f]

//屏幕的宽
#define TABLEVIEW_COLOR [UIColor colorWithRed:30/255.0 green:160/255.0 blue:230/255.0 alpha:1]
//屏幕的宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//宽的比例
#define RATE SCREEN_WIDTH/320.0
//左边按钮
#define LEFT_BARITEM 1
//右边按钮
#define RIGHT_BARITEM 2

#define KWS(weakSelf) __weak __typeof(&*self) weakSelf=self

//自定义颜色
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


#pragma mark - 网络请求

//推荐(post)
#define URL_RECOMM (@"http://app.u17.com/v3/app/android/phone/recommend/itemlist?version=1107&t=1446524643&v=218")



//榜单(get)(有妖气)
#define URL_LIST (@"http://app.u17.com/v3/app/android/phone/rank/list?sortVersion=2&t=1446525464&v=2180001&android_id=8bfc621a8dfa0f22&key=null&come_from=openqq&model=Custom+Version")
//跟新
#define URL_UPDATA (@"http://app.u17.com/v3/app/android/phone/list/index?size=20&page=%ld&argName=sort&argValue=0&con=3&t=1446525387&v=2180001&android_id=8bfc621a8dfa0f22&key=null&come_from=openqq&model=Custom+Version")

//分类
#define URL_SPECIES (@"http://app.u17.com/v3/app/ios/phone/sort/list?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%205s&time=1446787178&sortVersion=2&from=10.1.3.4&")
//壁纸
#define URL_SEARCH (@"http://service.store.dandanjiang.tv/v1/wallpaper/resource?category_id=4e4d610cdf714d2966000003&height=1136&limit=63&skip=%ld&sys_language=zh-Hans-CN&width=640")


//http://app.u17.com//v3/app/android/phone/Special/item?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%205s&time=1446790273&
//收索
#define  URL_SEARCHE (@"http://app.u17.com/v3/app/ios/phone/search/hotkeywords?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%205s&time=1446786890&num=16&from=10.1.3.4&")
//收索2
#define URL2_SEAR (@"http://app.u17.com/v3/app/ios/phone/search/rslist?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%205s&time=1446786979&q=%@&page=1&")


//(点击长恨歌以后出现)http://app.u17.com/v3/app/ios/phone/search/rslist?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%205s&time=1446786979&q=%E9%95%BF%E6%AD%8C%E8%A1%8C&page=1&
//#define URL_SEARCHhttp://app.u17.com/v3/app/android/phone/search/hotkeywords?t=1446525607&v=2180001&android_id=8bfc621a8dfa0f22&key=null&come_from=openqq&model=Custom+Version

//点搜索出现的
//http://app.u17.com/v3/app/ios/phone/search/relative?inputText=1?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%205s&time=1446882843&type=0&inputText=ji%E2%80%86h&
//专题
#define URL_PROJECT

//书架
#define URL_BOOKCASE


//分类中的一条
#define URL_FENLEI (@"http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%@s&time=1481525462&page=%ld&argName=%@&argValue=%@&size=20&from=10.1.3.4&")
//点分类中的恋爱
//http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%205s&time=1446890173&page=1&argName=theme&argValue=4&size=20&from=10.1.3.4&
//搞笑
//http://app.u17.com/v3/app/ios/phone/list/index?version=10.1.3.4&deviceId=2adad92f92400737c7e0d3a943b8cdae365677de&model=iPhone%205s&time=1446890253&page=1&argName=theme&argValue=1&size=20&from=10.1.3.4&
#endif
