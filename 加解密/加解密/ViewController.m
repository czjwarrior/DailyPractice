//
//  ViewController.m
//  加解密
//
//  Created by 岑志军 on 2018/5/12.
//  Copyright © 2018年 岑志军. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"
#import "EncryptionTools.h"
#import "RSACryptor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // p12 是私钥
    // .der 是公钥
    // 非对称加密，使用公钥加密，私钥解密
    
    // 加载公钥
    [[RSACryptor sharedRSACryptor] loadPublicKey:[[NSBundle mainBundle] pathForResource:@"rsacert.der" ofType:nil]];
    
    // 对数据加密
    NSData *data = [[RSACryptor sharedRSACryptor] encryptData:[@"hahaha" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 对加密得到的密文进行base64编码打印
    NSLog(@"%@", [data base64EncodedStringWithOptions:kNilOptions]);
    
    // 输出结果：PflhCgTVNegcQXrb39RJOoxCRRIHuZ3LN0/hoxTDFBbC+8yKjp0m+/hxVUWBVsTo28WnNFCAFfrQ2of5SkqttD51a5eLb21R7bQSQRxg/gVZ5hePcE3vh7Slfcxm2qJM+J8hRWDP/MF4BiDLXI9ZqTpLCSS5mjJtmUBf2wNvI1Y=
    
    // 私钥解密
    
    // 加载私钥
    [[RSACryptor sharedRSACryptor] loadPrivateKey:[[NSBundle mainBundle] pathForResource:@"p.p12" ofType:nil] password:@"123456"];

    // 解密
    NSData *decryDeta = [[RSACryptor sharedRSACryptor] decryptData:data];
    
    NSLog(@"%@", [[NSString alloc] initWithData:decryDeta encoding:NSUTF8StringEncoding]);
    
    // 输出：hahaha
}

// 对称加密
- (void)aesAnd3Des{
    // AES - ECB模式
    
    /**
     *  加密字符串并返回base64编码字符串
     *
     *  @param string    要加密的字符串
     *  @param keyString 加密密钥
     *  @param iv        初始化向量(8个字节)
     *
     *  @return 返回加密后的base64编码字符串
     */
    //    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] encryptString:@"haha" keyString:@"abc" iv:nil]);
    
    // 输出 MIoAu+xUEpQZSUmkZUW6JQ==
    
    //    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] decryptString:@"MIoAu+xUEpQZSUmkZUW6JQ==" keyString:@"abc" iv:nil]);
    
    // 输出 haha
    
    // AES - CBC模式
    uint8_t iv[8] = {1,2,3,4,5,6,7,8};
    NSData *data = [[NSData alloc] initWithBytes:iv length:sizeof(iv)];
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] encryptString:@"haha" keyString:@"abc" iv:data]);
    
    // 输出 E/wWqUTiw/E+1DThAzV39A==
    
    NSLog(@"%@", [[EncryptionTools sharedEncryptionTools] decryptString:@"E/wWqUTiw/E+1DThAzV39A==" keyString:@"abc" iv:data]);
    
    // 输出 haha
}

- (void)md5{
    NSString *str = @"haha";
    
    NSLog(@"\n%@\n%@", [@"hahahahaha" md5String], [@"h" md5String]);
}

- (void)base64{
    
    NSString *str = @"haha";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *dataStr = [data base64EncodedStringWithOptions:kNilOptions];
    
    NSLog(@"%@", dataStr);
    
    
    NSData *encData = [[NSData alloc]initWithBase64EncodedString:dataStr options:kNilOptions];
    
    NSString *endStr = [[NSString alloc]initWithData:encData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", endStr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
