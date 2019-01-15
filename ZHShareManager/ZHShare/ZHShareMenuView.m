//
//  ZHShareMenuView.m
//  ZHShareManager
//
//  Created by 李志华 on 2018/12/24.
//

#import "ZHShareMenuView.h"
#import "ZHShareMenu.h"
#import "ZHShareObject.h"

@interface ZHShareMenuView ()<UIGestureRecognizerDelegate>
@property (nonatomic, copy) NSArray<ZHShareMenu *> *menus;
@property (nonatomic, strong) UIView *containView;
@end

@implementation ZHShareMenuView

- (instancetype)initWithMenus:(NSArray<ZHShareMenu *> *)menus {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
         self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        self.menus = menus;
        [self addDismissTap];
    }
    return self;
}

- (void)show {
    if (!self.menus.count) {
        NSAssert(self.menus.count, @"必须传入分享菜单");
    }
    
    UIView *containView = [[UIView alloc] init];
    containView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [self addSubview:containView];
    self.containView = containView;
    
    NSInteger cnt = 4;
    CGFloat space = 15.0;
    CGFloat iconNameSpace = 5.0;
    CGFloat leftRight = self.showType == ShareCustomShowTypeActionSheet?0:15.0;
    CGFloat w = (self.frame.size.width-leftRight-space*(cnt+1))/cnt;
    __block CGFloat containViewH = 0.0;
    [self.menus enumerateObjectsUsingBlock:^(ZHShareMenu * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //配置分享平台图标和名称
        UIImage *image = [UIImage imageNamed:obj.imageName];
        CGSize imageSize = image.size;
        CGSize textSize = [obj.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        CGFloat h = imageSize.height+textSize.height;
        CGFloat x = (idx % cnt)*(w+space)+space;
        CGFloat y = (idx / cnt)*(h+space+iconNameSpace)+space;
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:image];
        icon.frame = CGRectMake((w-imageSize.width)/2.0, 0, imageSize.width, imageSize.height);
        UILabel *name = [[UILabel alloc] init];
        name.text = obj.title;
        name.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        name.font = [UIFont systemFontOfSize:15];
        name.frame = CGRectMake((w-textSize.width)/2.0, imageSize.height+iconNameSpace, textSize.width, textSize.height);
        UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h+iconNameSpace)];
        shareView.tag = obj.shareObject.platformType+10000;
        [shareView addSubview:icon];
        [shareView addSubview:name];
        [self.containView addSubview:shareView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectPlatform:)];
        [shareView addGestureRecognizer:tap];
        //承载视图的高度
        if (idx == self.menus.count-1) {
            containViewH = CGRectGetMaxY(shareView.frame)+space;
        }
    }];
    
    if (self.showType == ShareCustomShowTypeActionSheet) {
        //取消
        if (self.showCancle) {
            UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
            [cancel addTarget:self action:@selector(cancelShare:) forControlEvents:UIControlEventTouchUpInside];
            [containView addSubview:cancel];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
            line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
            [cancel addSubview:line];
            
            containViewH += 45;
            cancel.frame = CGRectMake(0, containViewH-45, self.frame.size.width, 45);
        }
        //设置承载视图frame
        containView.frame = CGRectMake(0, self.frame.size.height-containViewH, self.frame.size.width, containViewH);
    } else {
        //如果锚点视图在下半屏，则展示在锚点视图的上面
        BOOL isHalf = NO;
        //箭头起始点
        CGFloat startX = 0.0;
        CGFloat startY = 0.0;
        if (self.anchorView) {
            CGRect rect = [self.anchorView.superview convertRect:self.anchorView.frame toView:self];
            isHalf = rect.origin.y > UIScreen.mainScreen.bounds.size.height/2.0;
            startX = CGRectGetMaxX(rect)-rect.size.width/2.0;
            startY = isHalf?rect.origin.y:CGRectGetMaxY(rect);
        } else {
            isHalf = self.anchor.y > UIScreen.mainScreen.bounds.size.height/2.0;
            startX = self.anchor.x;
            startY = self.anchor.y;
        }
        //设置承载视图frame
        CGFloat anchorH = 15.0;
        if (isHalf) {
            containView.frame = CGRectMake(leftRight/2.0, (startY-containViewH-anchorH), self.frame.size.width-leftRight, containViewH);
        } else {
            containView.frame = CGRectMake(leftRight/2.0, (startY+anchorH), self.frame.size.width-leftRight, containViewH);
        }
        containView.layer.cornerRadius = leftRight/2.0;
        //画箭头
        UIImageView *iv = [[UIImageView alloc] init];
        [self addSubview:iv];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(startX, startY)];
        if (isHalf) {
            [path addLineToPoint:CGPointMake(startX+10, startY-anchorH)];
            [path addLineToPoint:CGPointMake(startX-10, startY-anchorH)];
        } else {
            [path addLineToPoint:CGPointMake(startX-10, startY+anchorH)];
            [path addLineToPoint:CGPointMake(startX+10, startY+anchorH)];
        }
        [path closePath];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8].CGColor;
        [iv.layer addSublayer:layer];
    }
    //显示
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    if (self.showType == ShareCustomShowTypeActionSheet) {
        __block CGRect rect = self.frame;
        rect.origin.y = UIScreen.mainScreen.bounds.size.height;
        self.frame = rect;
        [UIView animateWithDuration:0.3 animations:^{
            rect.origin.y = 0;
            self.frame = rect;
        }];
    } else {
        self.alpha = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1.0;
        }];
    }
}

- (void)didSelectPlatform:(UITapGestureRecognizer *)sender {
    if (self.selectSharePlatform) {
        NSInteger platformType = sender.view.tag-10000;
        __block ZHShareObject *object = nil;
        [self.menus enumerateObjectsUsingBlock:^(ZHShareMenu * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.shareObject.platformType == (SharePlatformType)platformType) {
                object = obj.shareObject;
                *stop = YES;
            }
        }];
        self.selectSharePlatform(platformType, object);
        [self dismiss];
    }
}

- (void)cancelShare:(UIButton *)sender {
    [self dismiss];
}

- (void)addDismissTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismiss:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)tapToDismiss:(UITapGestureRecognizer *)sender {
    [self dismiss];
}

- (void)dismiss {
    if (self.showType == ShareCustomShowTypeActionSheet) {
        __block CGRect rect = self.frame;
        [UIView animateWithDuration:0.3 animations:^{
            rect.origin.y = UIScreen.mainScreen.bounds.size.height;;
            self.frame = rect;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.containView]) {
        return NO;
    }
    return YES;
}

@end
