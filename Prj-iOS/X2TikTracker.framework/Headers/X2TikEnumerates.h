//
//  X2TikEnumerates.h
//  X2TikTracker
//
//  Created by 余生 on 2024/11/20.
//

#ifndef X2TikEnumerates_h
#define X2TikEnumerates_h

typedef NS_ENUM(NSInteger, X2TKTCode) {
    /**
     * 0: 方法调用成功，或播放成功。
     */
    X2TKTCodeOK = 0,

    /**
     * 1: 播放失败，原因未知。
     */
    X2TKTCodeUnknown = 1,

    /**
     * 2: 播放被服务器拒绝。
     * 发生在未初始化或服务器拒绝时。
     */
    X2TKTCodeRejected = 2,

    /**
     * 3: 播放参数无效。
     */
    X2TKTCodeInvalidArgument = 3,

    /**
     * 4: 应用 ID 无效。
     */
    X2TKTCodeInvalidAppId = 4,

    /**
     * 5: 令牌无效。
     */
    X2TKTCodeInvalidToken = 5,

    /**
     * 6: 令牌已过期，因此播放被拒绝。
     */
    X2TKTCodeTokenExpired = 6,

    /**
     * 7: 播放未授权。
     */
    X2TKTCodeNotAuthorized = 7,

    /**
     * 8: 用户已开始播放，或用户未调用 \ref stopPlay 方法以获得 "PLAY_STATE_CLOSED" 状态。
     */
    X2TKTCodeAlreadyPlayed = 8,

    /**
     * 9: 用户已开始分享，或用户未调用 \ref stopShare 方法以获得 "SHARE_STATE_CLOSED" 状态。
     */
    X2TKTCodeAlreadyShared = 9,

    /**
     * 10: 播放超时。当前超时时间设置为六秒。
     */
    X2TKTCodeTimeout = 10,

    /**
     * 101: \ref 实例未初始化。
     */
    X2TKTCodeNotInitialized = 101,
};

/**
 @brief 与续期 TikTracker 令牌相关的错误代码。
 */
typedef NS_ENUM(NSInteger, X2RenewTokenErrCode) {
    /**
     * 0: 方法调用成功，或续期操作成功。
     */
    X2RenewTokenErrOK = 0,

    /**
     * 1: 常见失败。用户未能续期令牌。
     */
    X2RenewTokenErrFailure = 1,

    /**
     * 2: 方法调用失败。参数无效。
     */
    X2RenewTokenErrInvalidArgument = 2,

    /**
     * 3: **保留供将来使用**
     */
    X2RenewTokenErrRejected = 3,

    /**
     * 4: 方法调用频率超过每秒两个查询的限制。
     */
    X2RenewTokenErrTooOften = 4,

    /**
     * 5: 令牌已过期。
     */
    X2RenewTokenErrTokenExpired = 5,

    /**
     * 6: 令牌无效。
     */
    X2RenewTokenErrInvalidToken = 6,

    /**
     * 101: \ref 实例未初始化。
     */
    X2RenewTokenErrNotInitialized = 101,
};

typedef NS_ENUM(NSInteger, X2TrackerZone) {
    X2TrackerZoneChina,
    X2TrackerZoneHongKong,
    X2TrackerZoneEurope,
    X2TrackerZoneUSA
};


#endif /* X2TikEnumerates_h */
