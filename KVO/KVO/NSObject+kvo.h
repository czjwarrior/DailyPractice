//
//  NSObject+kvo.h
//  KVO
//
//  Created by 岑志军 on 2018/5/20.
//  Copyright © 2018年 岑志军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (kvo)

- (void)zj_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end
