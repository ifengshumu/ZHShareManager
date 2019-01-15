//
//  ZHShareEnum.h
//  ZHShareManager
//
//  Created by 李志华 on 2018/11/14.
//  Copyright © 2018 CoderApple. All rights reserved.
//

//分享平台，和友盟分享平台枚举对应。
//这是常用的几种，如果需要可以增加，但务必和友盟分享平台枚举保持对应。
typedef NS_ENUM(NSUInteger, SharePlatformType) {
    SharePlatformTypeUnKnown            = -2,   //未知
    SharePlatformTypeSina               = 0,    //新浪
    SharePlatformTypeWxSession          = 1,    //微信聊天
    SharePlatformTypeWxTimeLine         = 2,    //微信朋友圈
    SharePlatformTypeWxSessionFavorite  = 3,    //微信收藏
    SharePlatformTypeQQ                 = 4,    //QQ聊天页面
    SharePlatformTypeQzone              = 5,    //qq空间
    SharePlatformTypeSMS                = 13,   //短信
    SharePlatformTypeEmail              = 14,   //邮件
};

//分享对象类型
typedef NS_ENUM(NSUInteger, ShareObjectType) {
    ShareObjectTypeUnKnown  = 0,
    ShareObjectTypeText     = 1,
    ShareObjectTypeImage    = 2,
    ShareObjectTypeURL      = 3,
    ShareObjectTypeMusic    = 4,
    ShareObjectTypeVideo    = 5,
};

//分享定制显示方式
typedef NS_ENUM(NSUInteger, ShareCustomShowType) {
    ShareCustomShowTypeActionSheet,
    ShareCustomShowTypeAnchor,
};
