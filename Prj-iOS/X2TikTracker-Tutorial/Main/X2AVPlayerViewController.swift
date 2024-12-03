//
//  X2AVPlayerViewController.swift
//  X2-HlsShare-Tutorial
//
//  Created by 余生 on 2024/8/13.
//

import UIKit
import X2TikTracker
import AVFoundation


class X2AVPlayerViewController: UIViewController {
    private var engineKit: X2TiktrackerKit!
    private var player: AVPlayer?
    private var videoUrl: URL?
    private lazy var canPlay = true
    private var isPlay = false
    
    @IBOutlet weak var statsLabel: UILabel!
    /// url 地址
    var playUrl: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "AVPlayer"
        navigationController?.titleColor = UIColor.black
        navigationItem.leftBarButtonItem = createBarButtonItem(title: nil)
        initializeX2TikTracker()
    }
    
    func initializeX2TikTracker() {
        engineKit = X2TiktrackerKit.init(delegate: self, appId: KeyCenter.AppId)
        engineKit.startPlay(playUrl, share: true)
        let url = engineKit.getExPlayUrl()
        print("getExPlayUrl url = \(url)")
        let videoURL = URL(string: url)!
        addPlayer(url: videoURL)
        
        let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
            try audioSession.setActive(true)
        } catch  {
            
        }
        startPlay()
    }
    
    func addPlayer(url: URL) {
        videoUrl = url
        player = AVPlayer(url: videoUrl! as URL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.insertSublayer(playerLayer, at: 0)
        player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(0.5, preferredTimescale: 30), queue: nil, using: { [weak self] time in
            guard let self = self else { return }
            if let duration = self.player?.currentItem?.duration {
                //let allDuration = CMTimeGetSeconds(duration)
                //let currentTime = Int(time.seconds)
            }
        })
        addPlayerItemObserver()
        player?.currentItem?.addObserver(self, forKeyPath: "error", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "error" {
            canPlay = false
            //print("\(object) \(change)")
        }
    }
    
    func addPlayerItemObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(onVideoPlayEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func removePlayerItemObserver() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func onVideoPlayEnd() {
        player?.seek(to: CMTimeMakeWithSeconds(0, preferredTimescale: 30))
        stopPlay()
    }
    
    func startPlay() {
        if canPlay {
            isPlay = true
            player?.play()
        }
    }
    
    func stopPlay() {
        if isPlay {
            isPlay.toggle()
            player?.pause()
        }
        engineKit.stopPlay()
    }
    
    override func popBack() {
        stopPlay()
        removePlayerItemObserver()
        engineKit.release(true)
        super.popBack()
    }
}

extension X2AVPlayerViewController: X2TikTrackerDelegate {
    func onLoad(_ jsStats: X2TikDataStats) {
        statsLabel.text = jsStats.description
    }
}

extension X2TikDataStats {
    open override var description: String {
        return " allPeers：\(allPeers)\n connectedPeers：\(connectedPeers)\n allHttpDownload：\(allHttpDownload)\n allShareDownload：\(allShareDownload)\n allShareUpload：\(allShareUpload)\n speedHttpDownload：\(speedHttpDownload)\n speedShareDownload：\(speedShareDownload)\n speedShareUpload：\(speedShareUpload)"
    }
}
