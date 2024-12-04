## 概述

X2TikTracker 是一款支持基于 P2P 技术的视频加速工具。它集成了 WebRTC 和 HLS 等技术，旨在降低视频点播或直播的带宽消耗，提升播放体验。X2TikTracker 的核心理念是利用终端设备之间的上传能力，实现带宽共享，从而降低对传统 CDN 的依赖。

## 跑通示例

1、[下载demo](https://github.com/TikCDN/X2TikTracker-iOS)

2、配置开发着信息

```text
KeyCenter.swift

在上述文件中找到AppId

static let AppId: String = <#YOUR APPID#>
```

3、修改Bundle Identifier,确保跟创建应用的时候填写的值一致，否则将使用不了加速服务

4、跑通后，还需在另外一台机器上跑通示例查看P2P加速效果

5、也可以

## X2TikTrackerKit 类

### 类定义
`X2TikTrackerKit` 类提供了一系列方法，用于初始化、播放、分享、释放资源以及管理 token。

### 方法列表

#### 1. 实例化方法
```objc
- (instancetype)initWithDelegate:(id<X2TikTrackerDelegate>)delegate appId:(NSString *)appId;
```
- **参数**: 
  - `delegate`: 回调事件的代理对象。
  - `appId`: 应用的唯一标识符。
- **返回**: 返回初始化状态码。

#### 2. 释放资源方法
```objc
- (int)release:(BOOL)sync;
```
- **参数**: 
  - `sync`: 是否同步释放资源。
- **返回**: 返回释放状态码。

#### 3. 开始播放方法
```objc
- (int)startPlay:(NSString *)strUrl share:(BOOL)bShare;
```
- **参数**: 
  - `strUrl`: 播放的 URL，目前仅支持HLS(m3u8)和MPEG-DASH(mpd)。
  - `bShare`: 是否分享播放内容。
- **返回**: 返回播放状态码。

#### 4. 停止播放方法
```objc
- (int)stopPlay;
```
- **返回**: 返回停止状态码。

#### 5. 获取扩展播放 URL 方法
```objc
- (NSString *)getExPlayUrl;
```
- **返回**: 返回扩展播放的 URL 字符串。

#### 6. 设置配置方法
```objc
- (int)setConfig:(X2TikKitConfig *)x2Config;
```
- **参数**: 
  - `x2Config`: X2TikTConfig 配置对象。
- **返回**: 返回设置状态码。

#### 7. 开始分享方法
```objc
- (int)startShare;
```
- **返回**: 返回分享状态码。

#### 8. 停止分享方法
```objc
- (int)stopShare;
```
- **返回**: 返回停止分享状态码。

#### 9. 续期 token 方法
```objc
- (int)renewToken:(NSString *)strToken;
```
- **参数**: 
  - `strToken`: 续期的token 字符串。
- **返回**: 返回续期状态码。

#### 10. 设置参数方法
```objc
- (int)setParameters:(NSString *)strParam;
```
- **参数**: 
  - `strParam`: 参数字符串。
- **返回**: 返回设置状态码。

---


## X2TikTrackerDelegate 协议

### 协议定义
`X2TikTrackerDelegate` 协议定义了一系列可选的方法，用于接收与分享、数据统计、对等连接和 token 续期相关的回调。

### 方法列表

#### 1. 分享结果回调
```objc
- (void)onShareResult:(X2TKTCode)nCode;
```
- **参数**: 
  - `nCode`: 分享结果的状态码。

#### 2. 数据统计加载回调
```objc
- (void)onLoadDataStats:(X2TikDataStats *)jsStats;
```
- **参数**: 
  - `jsStats`: 统计信息。

#### 3. 对等连接建立回调
```objc
- (void)onPeerOn:(NSString *)strPeerUId peerData:(NSString *)strPeerUData;
```
- **参数**: 
  - `strPeerUId`: 对等用户的唯一 ID。
  - `strPeerUData`: 对等用户的数据。

#### 4. 对等连接断开回调
```objc
- (void)onPeerOff:(NSString *)strPeerUId peerData:(NSString *)strPeerUData;
```
- **参数**: 
  - `strPeerUId`: 对等用户的唯一 ID。
  - `strPeerUData`: 对等用户的数据。

#### 5. token 续期结果回调
```objc
- (void)onRenewTokenResult:(NSString *)token errorCode:(X2RenewTokenErrCode)errorCode;
```
- **参数**: 
  - `token`: 续期后的token。
  - `errorCode`: 续期操作的错误码。

#### 6. token 即将过期回调
```objc
- (void)onTokenWillExpired;
```

#### 7. token 已过期回调
```objc
- (void)onTokenExpired;
```

---
