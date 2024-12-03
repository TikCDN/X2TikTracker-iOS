//
//  X2MainViewController.swift
//  X2-HlsShare-Tutorial
//
//  Created by 余生 on 2024/8/9.
//

import UIKit
import X2TikTracker
import AVFoundation

enum X2PlayType {
    case avplay, ijkplay
    
    func getIndex() -> Int {
        var index: NSInteger
        
        switch self {
        case .avplay: index = 0
        case .ijkplay: index = 1
        }
        return index
    }
}

class X2MainViewController: UIViewController {
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet weak var playButton: UIButton!
    
    /// 播放类型
    var type: X2PlayType = .avplay

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "X2TikTracker"
        navigationController?.titleColor = UIColor.black
        
        addressTextField.leftViewMode = .always
        addressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        addressTextField.addTarget(self, action: #selector(textFieldValueChange), for: .editingChanged)
    }
    
    @IBAction func didClickPlayTypeButton(_ sender: UIButton) {
        if type.getIndex() != sender.tag - 1 {
            type = (type == .avplay) ? .ijkplay : .avplay
            
            stackView.subviews.forEach { subView in
                let button = subView as! UIButton
                button.isSelected = (button == sender)
                button.layer.borderColor = (button == sender) ? UIColor(hexString: "#0241FF").cgColor : UIColor(hexString: "#878799").cgColor
            }
        }
    }
    
    @objc func textFieldValueChange() {
        let isEmpty = addressTextField.text?.count == 0
        playButton.backgroundColor = UIColor(hexString: (isEmpty ? "#869ff7" : "#0241FF"))
    }
    
    
    @IBAction func didClickPlayButton(_ sender: Any) {
        view.endEditing(true)
        
        if addressTextField.text?.count != 0 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if type == .avplay {
                guard let avPlayVc = storyBoard.instantiateViewController(withIdentifier: "X2Hls_AV") as? X2AVPlayerViewController else { return }

                avPlayVc.playUrl = addressTextField.text
                navigationController?.pushViewController(avPlayVc, animated: true)
            } else {
                guard let ijkPlayVc = storyBoard.instantiateViewController(withIdentifier: "X2Hls_IJK") as? X2IJKPlayerViewController else { return }

                ijkPlayVc.playUrl = addressTextField.text
                navigationController?.pushViewController(ijkPlayVc, animated: true)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

