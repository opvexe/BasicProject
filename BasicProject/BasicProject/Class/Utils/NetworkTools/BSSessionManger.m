//
//  WHSessionManger.m
//  WasteHouse
//
//  Created by snowlu on 2018/5/7.
//  Copyright © 2018年 LittleShrimp. All rights reserved.
//

#import "BSSessionManger.h"
static NSString *p12file = @"client";
static NSString *p12pwd = @"haha";
static NSString *serice = @"haha";
@implementation BSSessionManger

-(instancetype)initWithBaseURL:(NSURL *)url{
    
    self = [super initWithBaseURL:url];
    
    if (self) {
        
        //        [self configManger];
    }
    
    return self;
    
}
//双向认证
-(void)configManger{
    
    
   @ weakify(self);
    
    [self setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential *__autoreleasing  _Nullable * _Nullable credential) {
        @strongify(self)
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *__credential = nil;
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            if ([self.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                __credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if (__credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }else{
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            }else{
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        }else{
            
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString *p12 = [[NSBundle mainBundle] pathForResource:p12file ofType:@"p12"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if (![fileManager fileExistsAtPath:p12]) {
                
            }else{
                NSData *pkcs12Data = [NSData dataWithContentsOfFile:p12];
                if ([BSSessionManger extractIdentity:&identity andTrust:&trust fromPKCS12Data:pkcs12Data]) {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void *certs[] = {certificate};
                    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
                    __credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray *)certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *credential = __credential;
        return disposition;
    }];
    AFSecurityPolicy *t_policy;
    NSString *cerFilePath = [[NSBundle mainBundle] pathForResource:serice ofType:@"cer"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cerFilePath]) {
        NSData *CAData = [NSData dataWithContentsOfFile:cerFilePath];
        t_policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        [t_policy setAllowInvalidCertificates:YES];
        [t_policy setValidatesDomainName:NO];
        [t_policy setPinnedCertificates:[NSSet setWithObjects:CAData, nil]];
        NSLog(@"security policy certificate");
    }else{
        AFSecurityPolicy *t_policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [t_policy setAllowInvalidCertificates:true];
        [t_policy setValidatesDomainName:false];
    }
    self.securityPolicy = t_policy;
}

+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    OSStatus securityErr = errSecSuccess;
    //client certificate password
    NSDictionary *optionsDic = [NSDictionary dictionaryWithObject:p12pwd forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityErr = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data, (__bridge CFDictionaryRef)optionsDic, &items);
    if (securityErr == errSecSuccess) {
        CFDictionaryRef mineIdentAndTrust = CFArrayGetValueAtIndex(items, 0);
        const void *tmpIdentity = NULL;
        tmpIdentity = CFDictionaryGetValue(mineIdentAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tmpIdentity;
        const void *tmpTrust = NULL;
        tmpTrust = CFDictionaryGetValue(mineIdentAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tmpTrust;
    }else{
        NSLog(@"failed to extract identity/trust with err code :%d",securityErr);
        return NO;
    }
    return YES;
}
@end
