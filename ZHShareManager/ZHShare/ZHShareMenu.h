//
//  ZHShareMenu.h
//  ZHShareManager
//
//  Created by 李志华 on 2018/11/14.
//  Copyright © 2018 CoderApple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZHShareObject;
@interface ZHShareMenu : NSObject
//自定义分享菜单需要设置title和imageName，否则不需要
@property (nonatomic, copy) NSString *title; //分享平台名称
@property (nonatomic, copy) NSString *imageName; //分享平台图标名称
@property (nonatomic, strong) ZHShareObject *shareObject;
@end

