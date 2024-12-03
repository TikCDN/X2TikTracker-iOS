//
//  X2IJKPlayerViewController.swift
//  X2-HlsShare-Tutorial
//
//  Created by 余生 on 2024/8/13.
//

import IJKMediaFramework
import UIKit
import X2TikTracker

class X2IJKPlayerViewController: UIViewController {
    private var engineKit: X2TiktrackerKit!
    private var ijkPlayer: IJKFFMoviePlayerController!
    private var videoUrl: URL?

    @IBOutlet var statsLabel: UILabel!
    /// url 地址
    var playUrl: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "IJKPlayer"
        navigationController?.titleColor = UIColor.black
        navigationItem.leftBarButtonItem = createBarButtonItem(title: nil)
        initializeX2TikTracker()
        initializeIJKPlayer()
    }

    func initializeX2TikTracker() {
        engineKit = X2TiktrackerKit(delegate: self, appId: "")
        engineKit.startPlay(playUrl, share: true)
        let url = engineKit.getExPlayUrl()
        print("getExPlayUrl url = \(url)")
        videoUrl = URL(string: url)!
    }

    func initializeIJKPlayer() {
        if let options = IJKFFOptions.byDefault() {
            options.setPlayerOptionIntValue(1, forKey: "videotoolbox")
            ijkPlayer = IJKFFMoviePlayerController(contentURL: videoUrl, with: options)
            ijkPlayer.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            ijkPlayer.view.frame = view.bounds
            ijkPlayer.scalingMode = .aspectFit
            ijkPlayer.shouldAutoplay = true
            view.autoresizesSubviews = true

            if let playerView = ijkPlayer.view {
                view.addSubview(playerView)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        installMovieNotificationObservers()
        ijkPlayer.prepareToPlay()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ijkPlayer.shutdown()
        removeMovieNotificationObservers()
    }

    override func popBack() {
        engineKit.stopPlay()
        engineKit.release(true)
        super.popBack()
    }
}

// MARK: - X2HlsShareEngineDelegate

extension X2IJKPlayerViewController: X2TikTrackerDelegate {
    func onLoad(_ jsStats: X2TikDataStats) {
        view.bringSubviewToFront(statsLabel)
        statsLabel.text = jsStats.description
    }
}

// MARK: - IJKPlayer

extension X2IJKPlayerViewController {
    func installMovieNotificationObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadStateDidChange),
                                               name: NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange,
                                               object: ijkPlayer)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moviePlayBackDidFinish),
                                               name: NSNotification.Name.IJKMPMoviePlayerPlaybackDidFinish,
                                               object: ijkPlayer)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(mediaIsPreparedToPlayDidChange),
                                               name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange,
                                               object: ijkPlayer)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moviePlayBackStateDidChange),
                                               name: NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange,
                                               object: ijkPlayer)
    }

    // MARK: - Remove Movie Notification Handlers

    func removeMovieNotificationObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange,
                                                  object: ijkPlayer)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.IJKMPMoviePlayerPlaybackDidFinish,
                                                  object: ijkPlayer)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange,
                                                  object: ijkPlayer)
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange,
                                                  object: ijkPlayer)
    }

    // MARK: - Notification Handlers

    @objc func loadStateDidChange(notification: Notification) {
        // 处理加载状态变化
        guard let player = ijkPlayer else { return }

        let loadState = player.loadState

        if loadState.contains(.playthroughOK) {
            print("loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: \(loadState.rawValue)")
        } else if loadState.contains(.stalled) {
            print("loadStateDidChange: IJKMPMovieLoadStateStalled: \(loadState.rawValue)")
        } else {
            print("loadStateDidChange: ???: \(loadState.rawValue)")
        }
    }

    @objc func moviePlayBackDidFinish(notification: Notification) {
        // 处理播放完成
        guard let reason = notification.userInfo?[IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as? Int else { return }

        switch reason {
        case IJKMPMovieFinishReason.playbackEnded.rawValue:
            print("playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: \(reason)")
        case IJKMPMovieFinishReason.userExited.rawValue:
            print("playbackStateDidChange: IJKMPMovieFinishReasonUserExited: \(reason)")
        case IJKMPMovieFinishReason.playbackError.rawValue:
            print("playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: \(reason)")
        default:
            print("playbackPlayBackDidFinish: ???: \(reason)")
        }
    }

    @objc func mediaIsPreparedToPlayDidChange(notification: Notification) {
        // 处理媒体准备就绪变化
        print("mediaIsPreparedToPlayDidChange")
    }

    @objc func moviePlayBackStateDidChange(notification: Notification) {
        // 处理播放状态变化
        guard let player = ijkPlayer else { return }

        switch player.playbackState {
        case .stopped:
            print("IJKMPMoviePlayBackStateDidChange: stopped")
        case .playing:
            print("IJKMPMoviePlayBackStateDidChange: playing")
        case .paused:
            print("IJKMPMoviePlayBackStateDidChange: paused")
        case .interrupted:
            print("IJKMPMoviePlayBackStateDidChange: interrupted")
        case .seekingForward, .seekingBackward:
            print("IJKMPMoviePlayBackStateDidChange: seeking")
        default:
            print("IJKMPMoviePlayBackStateDidChange: unknown")
        }
    }
}
