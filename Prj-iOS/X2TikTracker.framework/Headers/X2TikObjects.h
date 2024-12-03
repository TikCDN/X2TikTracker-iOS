//
//  X2TikObjects.h
//  X2TikTracker
//
//  Created by 余生 on 2024/11/20.
//

#import <Foundation/Foundation.h>
#import <X2TikTracker/X2TikEnumerates.h>

NS_ASSUME_NONNULL_BEGIN

@interface X2TikKitConfig : NSObject

@property (nonatomic, assign) BOOL logEnabled;                     // 是否打印日志, 默认：false
@property (nonatomic, assign) int logLevel;                        // 打印日志的级别, 默认：WARN
@property (nonatomic, assign) X2TrackerZone trackerZone;             // tracker服务器地址所在国家的枚举
@property (nonatomic, assign) int downloadTimeout;                 // HTTP下载ts文件超时时间，单位毫秒，默认10000ms
@property (nonatomic, assign) int localPortHls;                   // HLS本地代理服务器的端口号(默认随机端口)
@property (nonatomic, assign) int localPortDash;                  // DASH本地代理服务器的端口号(默认随机端口)
@property (nonatomic, assign) int diskCacheLimit;                  // 磁盘缓存的最大数据量
@property (nonatomic, assign) int memoryCacheLimit;                // 内存缓存的最大数据量
@property (nonatomic, assign) int memoryCacheCountLimit;           // 内存缓存的最大文件个数
@property (nonatomic, assign) BOOL autoShare;                       // 开启或关闭p2p engine
@property (nonatomic, copy) NSString *withTag;                     // 用户自定义的标签
@property (nonatomic, copy) NSString *webRTCConfig;                // WebRTC默认配置
@property (nonatomic, assign) int maxPeerConnections;              // 最大连接节点数量
@property (nonatomic, assign) BOOL useHttpRange;                   // 使用Http Range请求
@property (nonatomic, assign) BOOL useStrictHlsSegmentId;          // 使用基于url的SegmentId
@property (nonatomic, copy) NSString *httpHeadersForHls;           // HLS请求时的HTTP请求头
@property (nonatomic, copy) NSString *httpHeadersForDash;          // DASH请求时的HTTP请求头
@property (nonatomic, assign) BOOL isSetTopBox;                    // 机顶盒设置
@property (nonatomic, assign) BOOL sharePlaylist;                  // 是否允许m3u8文件的P2P传输
@property (nonatomic, assign) BOOL prefetchOnly;                   // HLS模式下只采用预加载的方式
@property (nonatomic, assign) BOOL logPersistent;                  // 日志持久化设置
@property (nonatomic, assign) BOOL geoIpPreflight;                 // 向在线IP数据库请求ASN等信息
@property (nonatomic, copy) NSString *insertTimeOffsetTag;         // 插入时间偏移标签
@property (nonatomic, copy) NSString *mediaFileSeparator;          // 媒体文件后缀分隔符

@end

// 定义数据统计类
@interface X2TikDataStats : NSObject

/// 所有数量
@property (nonatomic, assign) int allPeers;

/// 已连接的数量
@property (nonatomic, assign) int connectedPeers;

/// 从HTTP下载的数据量（单位KB）
@property (nonatomic, assign) uint32_t allHttpDownload;

/// 从分享下载的数据量（单位KB）
@property (nonatomic, assign) uint32_t allShareDownload;

/// 分享上传的数据量（单位KB）
@property (nonatomic, assign) uint32_t allShareUpload;

/// 从分享者下载的数据量（单位KB）
@property (nonatomic, assign) uint32_t speedHttpDownload;

/// 上传的数据量（单位KB）
@property (nonatomic, assign) uint32_t speedShareUpload;

/// 下载速度（单位KB/s）
@property (nonatomic, assign) uint32_t speedShareDownload;

/// 开始时间（UTC时间戳）
@property (nonatomic, assign) int64_t nUtcBeginTime;

@end

NS_ASSUME_NONNULL_END
