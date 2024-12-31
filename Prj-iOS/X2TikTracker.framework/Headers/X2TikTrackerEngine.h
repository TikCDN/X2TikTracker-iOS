//
//  X2TikTrackerEngine.h
//  X2TikTracker
//
//  Created by 余生 on 2024/11/20.
//

#import <Foundation/Foundation.h>
#import <X2TikTracker/X2TikEnumerates.h>
#import <X2TikTracker/X2TikObjects.h>

NS_ASSUME_NONNULL_BEGIN

// X2TikTrackerDelegate 协议定义
@protocol X2TikTrackerDelegate <NSObject>
@optional
/**
 * 分享结果回调
 * @param nCode 分享结果的状态码。
 */
- (void)onShareResult:(X2TKTCode)nCode;

/**
 * 数据统计加载回调
 * @param stats 统计信息。
 */
- (void)onLoadDataStats:(X2TikDataStats *)stats;

/**
 * 对等连接建立回调
 * @param peerId 对等用户的唯一 ID。
 * @param peerData 对等用户的数据。
 */
- (void)onPeerOn:(NSString *)peerId peerData:(NSString *)peerData;

/**
 * 对等连接断开回调
 * @param peerId 对等用户的唯一 ID。
 * @param peerData 对等用户的数据。
 */
- (void)onPeerOff:(NSString *)peerId peerData:(NSString *)peerData;

@end

// X2TikTrackerEngine 类定义
@interface X2TikTrackerEngine : NSObject

@property (nonatomic, weak) id<X2TikTrackerDelegate> delegate;
/**
 * 实例化方法
 * @param delegate 回调事件的代理对象。
 * @param appId 应用的唯一标识符。
 * @return 返回初始化状态码。
 */
- (instancetype)initWithDelegate:(id<X2TikTrackerDelegate>)delegate appId:(NSString *)appId;

/**
 * 释放资源方法
 * @param sync 是否同步释放资源。
 * @return 返回释放状态码。
 */
- (int)release:(BOOL)sync;

/**
 * 开始播放方法
 * @param url 播放的 URL。
 * @param share 是否分享播放内容。
 * @return 返回播放状态码。
 */
- (int)startPlay:(NSString *)url share:(BOOL)share;

/**
 * 停止播放方法
 * @return 返回停止状态码。
 */
- (int)stopPlay;

/**
 * 获取扩展播放 URL 方法
 * @return 返回扩展播放的 URL 字符串。
 */
- (NSString *)getExPlayUrl;

/**
 * 设置配置方法
 * @param config X2TikTConfig 配置对象。
 * @return 返回设置状态码。
 */
- (int)setConfig:(X2TikKitConfig *)config;

/**
 * 开始分享方法
 * @return 返回分享状态码。
 */
- (int)startShare;

/**
 * 停止分享方法
 * @return 返回停止分享状态码。
 */
- (int)stopShare;

/**
 * 设置参数方法
 * @param param 参数字符串。
 * @return 返回设置状态码。
 */
- (int)setParameters:(NSString *_Nonnull)param;

/**
 * 获取版本号
 * @return 版本号。
 */
- (NSString *)getVersion;

@end



NS_ASSUME_NONNULL_END
