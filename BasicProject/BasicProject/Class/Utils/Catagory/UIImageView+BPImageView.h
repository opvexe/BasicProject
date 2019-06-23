//
//  UIImageView+BPImageView.h
//  BasicProject
//
//  Created by zhanglu on 2019/1/11.
//  Copyright © 2019 LittleShrimp. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef YYWebImageOptions BPWebImageOptions;
typedef YYWebImageCompletionBlock BPWebImageCompletionBlock;
typedef YYWebImageProgressBlock BPWebImageProgressBlock;
typedef YYWebImageTransformBlock BPWebImageTransformBlock;

@interface UIImageView (BPImageView)
- (void)bp_setImageWithURL:(nullable NSString *)imageString placeholder:(nullable UIImage *)placeholder;

- (void)bp_setWebImageWithURL:(nullable NSString *)imageString placeholder:(nullable UIImage *)placeholder;

- (void)bp_setImageWithURL:(nullable NSString *)imageString options:(BPWebImageOptions)options;

- (void)bp_setImageWithURL:(nullable NSString *)imageString
               placeholder:(nullable UIImage *)placeholder
                   options:(BPWebImageOptions)options
                completion:(nullable BPWebImageCompletionBlock)completion;

- (void)bp_setImageWithURL:(nullable NSString *)imageString
               placeholder:(nullable UIImage *)placeholder
                   options:(BPWebImageOptions)options
                  progress:(nullable BPWebImageProgressBlock)progress
                 transform:(nullable BPWebImageTransformBlock)transform
                completion:(nullable BPWebImageCompletionBlock)completion;

- (void)bp_setImageWithURL:(nullable NSString *)imageString
               placeholder:(nullable UIImage *)placeholder
                   options:(BPWebImageOptions)options
                   manager:(nullable YYWebImageManager *)manager
                  progress:(nullable BPWebImageProgressBlock)progress
                 transform:(nullable BPWebImageTransformBlock)transform
                completion:(nullable BPWebImageCompletionBlock)completion;

- (void)bp_setImageWithURL:(nullable NSString *)imageString
               placeholder:(nullable UIImage *)placeholder
                   options:(BPWebImageOptions)options
                 isBlurred:(BOOL)blurred
                completion:(nullable BPWebImageCompletionBlock)completion;
@end

