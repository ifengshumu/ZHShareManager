//
//  ZHShareObject.h
//  ZHShareManager
//
//  Created by 李志华 on 2018/11/5.
//  Copyright © 2018 CoderApple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHShareEnum.h"

@interface ZHShareObject : NSObject
///分享平台类型，必传
@property (nonatomic, assign) SharePlatformType platformType;
///分享内容对象类型，必传
@property (nonatomic, assign) ShareObjectType objectType;
///分享标题
@property (nonatomic, copy) NSString *title;
///分享内容
@property (nonatomic, copy) NSString *content;
///分享链接(URL、Music、Video分享类型的地址，必传)
@property (nonatomic, copy) NSString *url;
///lowband网页的url（Music、Video分享类型需要，非必传）
@property (nonatomic, copy) NSString *lowBandUrl;
///数据流url（Music、Video分享类型需要，非必传）
@property (nonatomic, copy) NSString *streamDataUrl;
///lowband数据流url（Music、Video分享类型需要，非必传）
@property (nonatomic, copy) NSString *lowBandStreamDataUrl;
///分享图片（Image分享类型的图片， 必传； 类型为UIImage，NSdata or 图片URL）
@property (nonatomic, strong) id image;
///缩略图（类型为UIImage，NSdata or 图片URL）
@property (nonatomic, strong) id thumImage;
///控制器（短信和邮件分享需要，其他分享可不传）
@property (nonatomic, strong) UIViewController *currentViewController;
@end

