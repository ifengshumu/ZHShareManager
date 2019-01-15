//
//  ZHShareManager.h
//  ZHShareManager
//
//  Created by 李志华 on 2018/11/5.
//  Copyright © 2018 CoderApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHShareEnum.h"

@class ZHShareMenu;
@class ZHShareObject;
@interface ZHShareManager : NSObject


+ (instancetype)sharedManager;

/**
 *  设置社会化分享appkey，eg:友盟分享的appkey
 */
+ (void)setSocialShareAppkey:(NSString *)appkey;

/**
 平台是否安装
 */
+ (BOOL)isInstallPlatform:(SharePlatformType)platform;
/**
 *  平台是否支持分享
 */
+ (BOOL)isSupportPlatform:(SharePlatformType)platform;

/**
 设置分享平台的appkey
 */
+ (BOOL)setPlaform:(SharePlatformType)platform
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL;

/**
  分享回调，iOS 9.0废弃
 @note - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation;
 */
+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
/**
 分享回调，iOS 9.0开始使用
 @note - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
 */
+ (BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary*)options;

/**
 配置分享菜单，必须在调用分享前设置，App生命周期内设置一次即可
 */
+ (void)configShareMenus:(NSArray<ZHShareMenu *> *)menus;

/**
 调用默认分享页面

 @param didSelectPlatform 选择分享平台回调
 @param completion 分享完成回调
 */
- (void)showDefaultShareMenuOnSelectPlatform:(void(^)(SharePlatformType platformType, NSDictionary *userInfo))didSelectPlatform completion:(void(^)(id result, NSError *error))completion;

/**
 调用定制分享页面
 
 @param didSelectPlatform 选择分享平台回调
 @param completion 分享完成回调
 */
- (void)showCustomActionSheetShareMenuOnSelectPlatform:(void(^)(SharePlatformType platformType, NSDictionary *userInfo))didSelectPlatform completion:(void(^)(id result, NSError *error))completion;

/**
 调用定制分享页面（锚点视图）

 @param anchorView 锚点视图
 @param didSelectPlatform 选择分享平台回调
 @param completion 分享完成回调
 */
- (void)showCustomAnchorShareMenuWithAnchorView:(UIView *)anchorView onSelectPlatform:(void(^)(SharePlatformType platformType, NSDictionary *userInfo))didSelectPlatform completion:(void(^)(id result, NSError *error))completion;
/**
 调用定制分享页面（锚点）
 
 @param anchor 锚点
 @param didSelectPlatform 选择分享平台回调
 @param completion 分享完成回调
 */
- (void)showCustomAnchorShareMenuWithAnchor:(CGPoint)anchor onSelectPlatform:(void(^)(SharePlatformType platformType, NSDictionary *userInfo))didSelectPlatform completion:(void(^)(id result, NSError *error))completion;

/**
 分享

 @param object 分享内容对象
 @param completion 分享完成回调
 */
- (void)shareObject:(ZHShareObject *)object completion:(void(^)(id result, NSError *error))completion;
@end
