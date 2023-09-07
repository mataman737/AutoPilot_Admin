//
//  SplashViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/3/23.
//

import UIKit
import AVFoundation
import AVKit


class SplashViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    //Video & Audio
    var player = AVPlayer()
    var playerLoop = AVPlayer()
    var loopingVideoContainer = UIView()
    
    //Views
    var launchView = NVULaunchView()
    var blurredView = BlurredView()
    var detailsLabel = UILabel()
    var joinWaitingListButton = UIButton()
    var loginButton = UIButton()
    var codeButton = UIButton()
    var codeLabel = UILabel()
    var dividerLine = UIView()
    var loginLabel = UILabel()
    var logoImageView = UIImageView()
    
    var isFromTeamLink = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        /*
        for fontFamilyName in UIFont.familyNames{
            for fontName in UIFont.fontNames(forFamilyName: fontFamilyName){
                //print("Family: \(fontFamilyName)     Font: \(fontName)")
            }
        }
        */
                
        self.view.isUserInteractionEnabled = true
        playLoopingVideo()
        setupViews()
        launchView.hideLaunch()
                                                
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeround), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func appMovedToForeround() {
        self.playerLoop.play()
    }

}

//MARK: SET UP VIDEO & AUDIO ------------------------------------------------------------------------------------------------------------------------------------

extension SplashViewController {
    private func playLoopingVideo() {
        // VIDEO
        guard let path = Bundle.main.path(forResource: "splash", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
      
        playerLoop = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: playerLoop)
        playerLoop.isMuted = true
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
      
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        loopingVideoContainer.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerLoop.currentItem, queue: .main) { [weak self] _ in
            self?.playerLoop.seek(to: CMTime.zero)
            self?.playerLoop.play()
        }
    }
}

//MARK: ACTIONS ------------------------------------------------------------------------------------------------------------------------------------

extension SplashViewController {
    @objc func joinWaitingListTapped() {
//        lightImpactGenerator()
//        let joinWaitingListVC = JoinWaitingListViewController()
//        joinWaitingListVC.modalPresentationStyle = .overFullScreen
//        self.present(joinWaitingListVC, animated: true, completion: nil)
    }
    
    @objc func accessCodeTapped() {
//        lightImpactGenerator()
//        let createAccountVC = CreateAccountViewController()
//        createAccountVC.modalPresentationStyle = .overFullScreen
//        self.present(createAccountVC, animated: true, completion: nil)
    }
    
    @objc func goToLogin() {
        lightImpactGenerator()
        let setupAccountVC = SetupAccountViewController()
        setupAccountVC.modalPresentationStyle = .overFullScreen
        self.present(setupAccountVC, animated: true, completion: nil)
    }
}
