//
//  AVAsset+FMLVideo.m
//  VideoClip
//
//  Created by samo on 16/7/27.
//  Copyright © 2016年 Collion. All rights reserved.
//

#import "AVAsset+FMLVideo.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation AVAsset (FMLVideo)

- (void)fml_getImagesCount:(NSUInteger)imageCount imageBackBlock:(void (^)(UIImage *image))imageBackBlock {
    Float64 durationSeconds = [self fml_getSeconds];
    float fps = [self fml_getFPS];
    NSMutableArray *times = [NSMutableArray array];
    Float64 totalFrames = durationSeconds * fps;
    Float64 perFrames = totalFrames / imageCount;
    Float64 frame = 0;
    CMTime timeFrame;
    while (frame < totalFrames) {
        timeFrame = CMTimeMake(frame, fps); //第i帧  帧率
        NSValue *timeValue = [NSValue valueWithCMTime:timeFrame];
        [times addObject:timeValue];
        frame += perFrames;
    }
    AVAssetImageGenerator *imgGenerator = [[AVAssetImageGenerator alloc] initWithAsset:self];
    imgGenerator.requestedTimeToleranceBefore = kCMTimeZero;
    imgGenerator.requestedTimeToleranceAfter = kCMTimeZero;
    imgGenerator.appliesPreferredTrackTransform = YES;
    [imgGenerator generateCGImagesAsynchronouslyForTimes:times completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        switch (result) {
            case AVAssetImageGeneratorCancelled:
                break;
            case AVAssetImageGeneratorFailed:
                break;
            case AVAssetImageGeneratorSucceeded: {
                UIImage *displayImage = [UIImage imageWithCGImage:image];
                if (imageBackBlock) {
                    imageBackBlock(displayImage);
                }
            }
             break;
        }
    }];
}

- (CGSize)avAssetNaturalSize {
    AVAssetTrack *assetTrackVideo;
    NSArray *videoTracks = [self tracksWithMediaType:AVMediaTypeVideo];
    if (videoTracks.count) {
        assetTrackVideo = videoTracks[0];
    }
    float sw = assetTrackVideo.naturalSize.width, sh = assetTrackVideo.naturalSize.height;
    BOOL isAssetPortrait = NO;
    CGAffineTransform trackTrans = assetTrackVideo.preferredTransform;
    if ((trackTrans.b == 1.0 && trackTrans.c == -1.0) || (trackTrans.b == -1.0 && trackTrans.c == 1.0)) {
        isAssetPortrait = YES;
    }
    if (isAssetPortrait) {
        float t = sw;
        sw = sh;
        sh = t;
    }
    return CGSizeMake(sw, sh);
}

- (void)getExportWithStartTime:(Float64)startTime andEndTime:(Float64)endTime andClipBlock:(void(^)(NSURL *videoUrl))block {
    
    NSArray *compatiblePresents = [AVAssetExportSession exportPresetsCompatibleWithAsset:self];
    if ([compatiblePresents containsObject:AVAssetExportPreset1280x720]) {
        
        NSString *outputPath = [NSHomeDirectory() stringByAppendingString:@"/tmp/clipvideooutput.mp4"];
        NSFileManager *mgr = [[NSFileManager alloc] init];
   
        CMTime start = CMTimeMake(startTime, 1);
        CMTime end = CMTimeMake(endTime, 1);
        CMTimeRange range = CMTimeRangeFromTimeToTime(start, end);
        
        AVAssetTrack *assetVideoTrack = nil;
        AVAssetTrack *assetAudioTrack = nil;
        
        // Check if the asset contains video and audio tracks
        if ([[self tracksWithMediaType:AVMediaTypeVideo] count] != 0) {
            assetVideoTrack = [self tracksWithMediaType:AVMediaTypeVideo][0];
        }
        if ([[self tracksWithMediaType:AVMediaTypeAudio] count] != 0) {
            assetAudioTrack = [self tracksWithMediaType:AVMediaTypeAudio][0];
        }
        
        NSError *error = nil;
        CMTime insertionPoint = kCMTimeZero;
        
        AVMutableComposition *mutableComposition = [AVMutableComposition composition];
        
        if(assetVideoTrack != nil) {
            AVMutableCompositionTrack *compositionVideoTrack = [mutableComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
            [compositionVideoTrack insertTimeRange:range ofTrack:assetVideoTrack atTime:insertionPoint error:&error];
            compositionVideoTrack.preferredTransform = assetVideoTrack.preferredTransform;
        }
        if(assetAudioTrack != nil) {
            AVMutableCompositionTrack *compositionAudioTrack = [mutableComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
            [compositionAudioTrack insertTimeRange:range ofTrack:assetAudioTrack atTime:insertionPoint error:&error];
        }
        
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:mutableComposition presetName:AVAssetExportPreset1280x720];
        session.outputURL = [NSURL fileURLWithPath:outputPath];
        
        if ([mgr fileExistsAtPath:outputPath]) {
            [mgr removeItemAtPath:outputPath error:NULL];
        }
        session.outputFileType = AVFileTypeMPEG4;
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            if (session.status == AVAssetExportSessionStatusCompleted) {
                NSURL *outputURL = session.outputURL;
                NSData *data1 = [NSData dataWithContentsOfURL:outputURL];
                if (block) {
                    block(outputURL);
                }
            }else{
                 NSLog(@"exporting error:%@", session.error);
//                NSLog(@"Video export failed with error: %@ (%d)", error.localizedDescription, error.code);
            }
        }];
    }
    
    
}

- (Float64)fml_getSeconds
{
    CMTime cmtime = self.duration; //视频时间信息结构体
    return CMTimeGetSeconds(cmtime); //视频总秒数
}

- (float)fml_getFPS
{
    float fps = [[self tracksWithMediaType:AVMediaTypeVideo].lastObject nominalFrameRate];
    
    return fps;
}

@end



/**
 CMTimeMake(time, timeScale)
 
 time指的就是時間(不是秒),
 而時間要換算成秒就要看第二個參數timeScale了.
 timeScale指的是1秒需要由幾個frame構成(可以視為fps),
 因此真正要表達的時間就會是 time / timeScale 才會是秒
 
 */
