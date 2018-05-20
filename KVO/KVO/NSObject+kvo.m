//
//  NSObject+kvo.m
//  KVO
//
//  Created by 岑志军 on 2018/5/20.
//  Copyright © 2018年 岑志军. All rights reserved.
//

#import "NSObject+kvo.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (kvo)

- (void)zj_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    //动态添加一个类
    NSString *originClassName = NSStringFromClass([self class]);
    
    NSString *newClassName = [@"ZJKVO_" stringByAppendingString:originClassName];
    
    const char *newName = [newClassName UTF8String];
    
    // 继承自当前类，创建一个子类
    Class kvoClass = objc_allocateClassPair([self class], newName, 0);
    
    // 添加setter方法
    class_addMethod(kvoClass, @selector(setName:), (IMP)setName, "v@:@");
    
    //注册新添加的这个类
    objc_registerClassPair(kvoClass);
    
    // 修改isa指针，由ZJPerson指向ZJKVO_Person
    object_setClass(self, kvoClass);
    
    // 保存观察者属性到当前类中
    objc_setAssociatedObject(self, (__bridge const void *)@"observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 重写父类方法

void setName(id self, SEL _cmd, NSString *name) {
    
    // 保存当前KVO的类
    Class kvoClass = [self class];
    
    // 将self的isa指针指向父类ZJPerson，调用父类setter方法
    object_setClass(self, class_getSuperclass([self class]));
    
    // 调用父类setter方法，重新复制
    objc_msgSend(self, @selector(setName:), name);
    
    // 取出ZJKVO_Person观察者
    id objc = objc_getAssociatedObject(self, (__bridge const void *)@"observer");

    // 通知观察者，执行通知方法
    objc_msgSend(objc, @selector(observeValueForKeyPath:ofObject:change:context:), name, self, nil, name);
    
    // 重新修改为ZJKVO_Person类
    object_setClass(self, kvoClass);
}

@end
