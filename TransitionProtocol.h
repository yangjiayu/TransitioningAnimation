//
//  TransitionProtocol.h
//  TransitionDemo
//
//  Created by yang on 2016/12/27.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TransitionProtocol <NSObject>
@property (nonatomic, strong) UIView *snapshotBackgroundView;
@property (nonatomic, strong) UIView *dimmingBackgroundView;

@end
