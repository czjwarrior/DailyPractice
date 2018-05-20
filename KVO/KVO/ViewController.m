//
//  ViewController.m
//  KVO
//
//  Created by 岑志军 on 2018/5/19.
//  Copyright © 2018年 岑志军. All rights reserved.
//

#import "ViewController.h"
#import "ZJPerson.h"
#import <objc/runtime.h>
#import "NSObject+kvo.h"

@interface ViewController ()

@property (nonatomic, strong) ZJPerson *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.person = [[ZJPerson alloc] init];
    
    [self.person setName:@"zhangsan"];
    
//    NSLog(@"%@", object_getClass(self.person));
//    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.person zj_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    NSLog(@"%@", object_getClass(self.person));
    
//    [self.person methodForSelector:@selector(setName:)];
    
//    [self createCustomClass];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.person setName:@"lisi"];
//    [self.person willChangeValueForKey:@"name"];
//    [self.person didChangeValueForKey:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@", context);
    
}

- (void)dealloc{
    [self.person removeObserver:self forKeyPath:@"name"];
}

#pragma mark - Public

- (void)createCustomClass{
    // 创建类
    Class customClass = objc_allocateClassPair([NSObject class], "ZJCustomClass", 0);
    
    // 添加实例变量
    class_addIvar(customClass, "age", sizeof(int), 0, "i");
    class_addIvar(customClass, "name", sizeof(NSString *), 0, "@");
    
    // 添加方法
    class_addMethod(customClass, @selector(hahahha), (IMP)hahahha, "V@:");
    
    id myObjc = [[customClass alloc] init];
    
    // 注册到运行时环境
    objc_registerClassPair(customClass);
    NSLog(@"%@", myObjc);
    
    NSLog(@"%@", [self copyMethodsByClass:customClass]);
    NSLog(@"%@", [self copyIvarsByClass:customClass]);
    
    [myObjc performSelector:@selector(hahahha)];
}

void hahahha(id self, SEL _cmd)
{
    NSLog(@"hahahha====");
}

- (void)hahahha{
    
}

#pragma mark - Util

- (NSString *)copyMethodsByClass:(Class)cls{
    unsigned int count;
    Method *methods = class_copyMethodList(cls, &count);
    
    NSString *methodStrs = @"";
    
    for (NSInteger index = 0; index < count; index++) {
        Method method = methods[index];
        
        NSString *methodStr = NSStringFromSelector(method_getName(method));
        
        methodStrs = [NSString stringWithFormat:@"%@ ", methodStr];
    }
    
    free(methods);
    
    return methodStrs;
}

- (NSString *)copyIvarsByClass:(Class)cls{
    unsigned int count;
    Ivar *ivars = class_copyIvarList(cls, &count);
    
    NSMutableString *ivarStrs = [NSMutableString string];
    
    for (NSInteger index = 0; index < count; index++) {
        Ivar ivar = ivars[index];
        
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];  //获取成员变量的名字
        
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)]; //获取成员变量的数据类型
        
        [ivarStrs appendString:@"\n"];
        [ivarStrs appendString:ivarName];
        [ivarStrs appendString:@"-"];
        [ivarStrs appendString:ivarType];
        
    }
    
    free(ivars);
    
    return ivarStrs;
}

@end
