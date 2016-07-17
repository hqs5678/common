//
//  MJAudioTool.h
//  01-音频播放
//
//  Created by apple on 14-6-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MJAudioTool : NSObject


// 短音频

/**
 *  播放音效
 *
 *  @param filename 音效文件名
 */
+ (void)playSound:(NSString *)filename;

/**
 *  销毁音效
 *
 *  @param filename 音效文件名
 */
+ (void)disposeSound:(NSString *)filename;





// 长音乐

/**
 *  播放音乐
 *
 *  @param filename 音乐文件名
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename;

/**
 *  暂停音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)pauseMusic:(NSString *)filename;

/**
 *  停止音乐
 *
 *  @param filename 音乐文件名
 */
+ (void)stopMusic:(NSString *)filename;

/**
 *  返回当前正在播放的音乐播放器
 */
+ (AVAudioPlayer *)currentPlayingAudioPlayer;

@end
