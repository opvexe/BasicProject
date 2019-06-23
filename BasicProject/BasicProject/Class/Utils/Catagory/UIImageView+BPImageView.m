//
//  UIImageView+BPImageView.m
//  BasicProject
//
//  Created by zhanglu on 2019/1/11.
//  Copyright © 2019 LittleShrimp. All rights reserved.
//

#import "UIImageView+BPImageView.h"

@implementation UIImageView (BPImageView)

- (void)bp_setImageWithURL:(nullable NSString *)imageString placeholder:(nullable UIImage *)placeholder {
    
    NSURL *imageURL = nil;
    if ([imageString hasPrefix:@"http"]) {
        imageURL = [NSURL URLWithString:imageString];
    }else{
        imageURL = [NSURL URLWithString:imageString];
    }
    [self setImageWithURL:imageURL placeholder:placeholder options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
}

- (void)bp_setWebImageWithURL:(nullable NSString *)imageString placeholder:(nullable UIImage *)placeholder {
    NSURL *imageURL = [NSURL URLWithString:imageString];
    [self setImageWithURL:imageURL placeholder:placeholder options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
}

- (void)bp_setImageWithURL:(nullable NSString *)imageString options:(BPWebImageOptions)options {
    NSURL *imageURL = [NSURL URLWithString:imageString];
    [self setImageWithURL:imageURL options:options];
}

- (void)bp_setImageWithURL:(nullable NSString *)imageString
               placeholder:(nullable UIImage *)placeholder
                   options:(BPWebImageOptions)options
                completion:(nullable BPWebImageCompletionBlock)completion {
    
    NSURL *imageURL = [NSURL URLWithString:imageString];
    [self setImageWithURL:imageURL placeholder:placeholder options:options completion:completion];
}

- (void)bp_setImageWithURL:(nullable NSString *)imageString
               placeholder:(nullable UIImage *)placeholder
                   options:(BPWebImageOptions)options
                 isBlurred:(BOOL)blurred
                completion:(nullable BPWebImageCompletionBlock)completion {
    
    NSURL *imageURL = [NSURL URLWithString:imageString];
    [self setImageWithURL:imageURL placeholder:placeholder options:options completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (blurred) {
            __block  UIImage *tempImage;
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                tempImage = [image imageByBlurRadius:40 tintColor:[UIColor colorWithWhite:0.11 alpha:0.5] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(tempImage,url,from,stage,error);
                });
            });
            
        }else{
            completion(image,url,from,stage,error);
        }
    }];
}


- (void)bp_setImageWithURL:(nullable NSString *)imageString
               placeholder:(nullable UIImage *)placeholder
                   options:(BPWebImageOptions)options
                  progress:(nullable BPWebImageProgressBlock)progress
                 transform:(nullable BPWebImageTransformBlock)transform
                completion:(nullable BPWebImageCompletionBlock)completion {
    NSURL *imageURL = [NSURL URLWithString:imageString];
    
    [self setImageWithURL:imageURL placeholder:placeholder options:options progress:progress transform:transform completion:completion];
}

- (void)bp_setImageWithURL:(nullable NSString *)imageString
               placeholder:(nullable UIImage *)placeholder
                   options:(BPWebImageOptions)options
                   manager:(nullable YYWebImageManager *)manager
                  progress:(nullable BPWebImageProgressBlock)progress
                 transform:(nullable BPWebImageTransformBlock)transform
                completion:(nullable BPWebImageCompletionBlock)completion {
    NSURL *imageURL = [NSURL URLWithString:imageString];
    
    [self setImageWithURL:imageURL placeholder:placeholder options:options manager:manager progress:progress transform:transform completion:completion];
    
}

- (void)cancelCurrentImageRequest {
    [self cancelCurrentImageRequest];
}
@end
