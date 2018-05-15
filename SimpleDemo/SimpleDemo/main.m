//
//  main.m
//  SimpleDemo
//
//  Created by 岑志军 on 2018/4/23.
//  Copyright © 2018年 cen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc] init];
        
        [p test:@"haha"];
    }
    return 0;
}
