//
//  ZHShareMenuView.h
//  ZHShareManager
//
//  Created by 李志华 on 2018/12/24.
//

#import <UIKit/UIKit.h>
#import "ZHShareEnum.h"

@class ZHShareMenu;
@class ZHShareObject;
@interface ZHShareMenuView : UIView
///显示方式，默认ShareCustomShowTypeActionSheet
@property (nonatomic, assign) ShareCustomShowType showType;
///是否显示取消选项，默认YES（showType==ShareCustomShowTypeActionSheet时设置有效）
@property (nonatomic, assign) BOOL showCancle;
///锚点视图（showType==ShareCustomShowTypeAnchor时，anchorView和anchor必须设置其一）
@property (nonatomic, strong) UIView *anchorView;
///锚点（showType==ShareCustomShowTypeAnchor时，anchor和anchorView必须设置其一）
@property (nonatomic, assign) CGPoint anchor;
///分享平台选择回调
@property (nonatomic, copy) void(^selectSharePlatform)(SharePlatformType platformType, ZHShareObject *shareObject);

- (instancetype)initWithMenus:(NSArray<ZHShareMenu *> *)menus;
///显示
- (void)show;
@end

