//
//  PickImageVideoViewController.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/28/23.
//

import Foundation
import YPImagePicker
import AVFoundation
import AVKit
import Photos

protocol PickImageVideoViewControllerDelegate: AnyObject {
    func didPickImage(image: UIImage, isVideo: Bool, url: URL?)
}

class PickImageVideoViewController: UIViewController {

    var delegate: PickImageVideoViewControllerDelegate!
    var selectedItems = [YPMediaItem]()

    var containerView = UIView()
    
    let selectedImageV = UIImageView()
    let pickButton = UIButton()
    let resultsButton = UIButton()
    
    var navContainer = UIView()
    var captionTitleLabel = UILabel()
    var shareButton = UIButton()
    var dismissButton = UIButton()
    var dismissImageView = UIImageView()
    var captionTextView = UITextView()
    var countLabel = UILabel()
    
    var isPhoto = true
    var isCoverorDetailPhoto = false
    var updateToRectangle = false
    var isTopCarousel = false
    var isMarketingCenter = false
    
    var selectedPhoto: UIImage?
    var selectedVideo: URL?
    
    var classId: Int!
    
    var config = YPImagePickerConfiguration()
    
    var onToOneRatio = false
    
    var fiveMinutes = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
            
        setupViews()
        perform(#selector(showPicker), with: self, afterDelay: 0.01)
        
    }

    @objc func showResults() {
        if selectedItems.count > 0 {
            let gallery = YPSelectionsGalleryVC(items: selectedItems) { g, _ in
                g.dismiss(animated: true, completion: nil)
            }
            let navC = UINavigationController(rootViewController: gallery)
            self.present(navC, animated: true, completion: nil)
        } else {
            print("No items selected yet.")
        }
    }
    
    @objc func setupViews() {
        
        containerView.alpha = 0
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        containerView.fillSuperview()
        
        navContainer.backgroundColor = .white
        navContainer.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(navContainer)
        navContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        navContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navContainer.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        captionTitleLabel.text = "Caption"
        captionTitleLabel.textAlignment = .center
        captionTitleLabel.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1.0)
        captionTitleLabel.font = .poppinsMedium(ofSize: 21)
        captionTitleLabel.numberOfLines = 0
        captionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        navContainer.addSubview(captionTitleLabel)
        captionTitleLabel.bottomAnchor.constraint(equalTo: navContainer.bottomAnchor, constant: -4).isActive = true
        captionTitleLabel.centerXAnchor.constraint(equalTo: navContainer.centerXAnchor).isActive = true
        
        //shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        shareButton.setTitle("Share", for: .normal)
        shareButton.titleLabel?.font = .poppinsRegular(ofSize: 16)
        shareButton.setTitleColor(UIColor(red: 94/255, green: 93/255, blue: 108/255, alpha: 1.0), for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        navContainer.addSubview(shareButton)
        shareButton.trailingAnchor.constraint(equalTo: navContainer.trailingAnchor, constant: -12).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: captionTitleLabel.centerYAnchor, constant: 0).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 43).isActive = true
        
        dismissImageView.image = UIImage(named: "blackDownArrow")
        dismissImageView.contentMode = .scaleAspectFill
        dismissImageView.translatesAutoresizingMaskIntoConstraints = false
        navContainer.addSubview(dismissImageView)
        dismissImageView.leadingAnchor.constraint(equalTo: navContainer.leadingAnchor, constant: 16).isActive = true
        dismissImageView.centerYAnchor.constraint(equalTo: captionTitleLabel.centerYAnchor, constant: 0).isActive = true
        dismissImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        dismissImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        //dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        dismissButton.backgroundColor = .clear
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        navContainer.addSubview(dismissButton)
        dismissButton.leadingAnchor.constraint(equalTo: navContainer.leadingAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: navContainer.topAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: navContainer.bottomAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        //
        
        selectedImageV.backgroundColor = .gray
        selectedImageV.contentMode = .scaleAspectFit
        selectedImageV.translatesAutoresizingMaskIntoConstraints = false
        //selectedImageV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.45)
        containerView.addSubview(selectedImageV)
        selectedImageV.topAnchor.constraint(equalTo: navContainer.bottomAnchor, constant: 19).isActive = true
        selectedImageV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        selectedImageV.heightAnchor.constraint(equalToConstant: 90).isActive = true
        selectedImageV.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        //captionTextField.placeholder = "What do you want to say?"
        captionTextView.tintColor = .darkGray
        //captionTextView.delegate = self
        captionTextView.textColor = UIColor(red: 91/255, green: 91/255, blue: 91/255, alpha: 1.0)
        captionTextView.textAlignment = .left
        captionTextView.font = .poppinsMedium(ofSize: 14)
        captionTextView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(captionTextView)
        captionTextView.leadingAnchor.constraint(equalTo: selectedImageV.trailingAnchor, constant: 12).isActive = true
        captionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12).isActive = true
        captionTextView.topAnchor.constraint(equalTo: selectedImageV.topAnchor, constant: 0).isActive = true
        captionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        let accessoryView = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        accessoryView.backgroundColor = .clear
        captionTextView.inputAccessoryView = accessoryView
        
        countLabel.backgroundColor = .white
        countLabel.text = "500"
        countLabel.textColor = .darkGray
        countLabel.font = .poppinsMedium(ofSize: 17)
        countLabel.textAlignment = .center
        countLabel.numberOfLines = 0
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        accessoryView.addSubview(countLabel)
        countLabel.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor, constant: 0).isActive = true
        countLabel.centerXAnchor.constraint(equalTo: accessoryView.centerXAnchor, constant: 0).isActive = true
        
        resultsButton.backgroundColor = .clear
        resultsButton.addTarget(self, action: #selector(showResults), for: .touchUpInside)
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(resultsButton)
        resultsButton.leadingAnchor.constraint(equalTo: selectedImageV.leadingAnchor).isActive = true
        resultsButton.trailingAnchor.constraint(equalTo: selectedImageV.trailingAnchor).isActive = true
        resultsButton.bottomAnchor.constraint(equalTo: selectedImageV.bottomAnchor).isActive = true
        resultsButton.topAnchor.constraint(equalTo: selectedImageV.topAnchor).isActive = true
        
    }

    // MARK: - Configuration
    @objc func showPicker() {

        /* Uncomment and play around with the configuration 👨‍🔬 🚀 */

        /* Set this to true if you want to force the  library output to be a squared image. Defaults to false */
//         config.library.onlySquare = true

        /* Set this to true if you want to force the camera output to be a squared image. Defaults to true */
        // config.onlySquareImagesFromCamera = false

        /* Ex: cappedTo:1024 will make sure images from the library or the camera will be
           resized to fit in a 1024x1024 box. Defaults to original image size. */
        // config.targetImageSize = .cappedTo(size: 1024)

        /* Choose what media types are available in the library. Defaults to `.photo` */
        if isCoverorDetailPhoto {
            config.library.mediaType = .photo
        } else {
            config.library.mediaType = .video
        }

        /* Enables selecting the front camera by default, useful for avatars. Defaults to false */
        // config.usesFrontCamera = true

        /* Adds a Filter step in the photo taking process. Defaults to true */
        config.showsPhotoFilters = false


        /* Manage filters by yourself */
//        config.filters = [YPFilter(name: "Mono", coreImageFilterName: "CIPhotoEffectMono"),
//                          YPFilter(name: "Normal", coreImageFilterName: "")]
//        config.filters.remove(at: 1)
//        config.filters.insert(YPFilter(name: "Blur", coreImageFilterName: "CIBoxBlur"), at: 1)

        /* Enables you to opt out from saving new (or old but filtered) images to the
           user's photo library. Defaults to true. */
        config.shouldSaveNewPicturesToAlbum = false

        /* Choose the videoCompression. Defaults to AVAssetExportPresetHighestQuality */
        config.video.compression = AVAssetExportPresetMediumQuality
        
        /* Defines the name of the album when saving pictures in the user's photo library.
           In general that would be your App name. Defaults to "DefaultYPImagePickerAlbumName" */
        // config.albumName = "ThisIsMyAlbum"

        /* Defines which screen is shown at launch. Video mode will only work if `showsVideo = true`.
           Default value is `.photo` */
        config.startOnScreen = .library

        /* Defines which screens are shown at launch, and their order.
           Default value is `[.library, .photo]` */
        config.screens = [.library]//[.library, .photo, .video]
        
        /* Can forbid the items with very big height with this property */
//        config.library.minWidthForItem = UIScreen.main.bounds.width * 0.8

        /* Defines the time limit for recording videos.
           Default is 30 seconds. */
        // config.video.recordingTimeLimit = 5.0

        /* Defines the time limit for videos from the library.
           Defaults to 60 seconds. */
        
        if fiveMinutes {
            config.video.libraryTimeLimit = 300.0
        } else {
            config.video.libraryTimeLimit = 60.0
        }

        /* Adds a Crop step in the photo taking process, after filters. Defaults to .none */
        
        if updateToRectangle {
            config.showsCrop = .rectangle(ratio: (1/1))
        } else {
            config.showsCrop = .rectangle(ratio: (3/4))
        }
        
        config.showsCrop = .none
        
        if isTopCarousel {
            config.showsCrop = .rectangle(ratio: (6/5.5))
        }
        
        if onToOneRatio {
            config.showsCrop = .rectangle(ratio: (1/1))
        }
        
        if isMarketingCenter {
            config.showsCrop = .rectangle(ratio: (3/4))
        }
        

        /* Defines the overlay view for the camera. Defaults to UIView(). */
        // let overlayView = UIView()
        // overlayView.backgroundColor = .red
        // overlayView.alpha = 0.3
        // config.overlayView = overlayView

        /* Customize wordings */
        config.wordings.libraryTitle = "Gallery"

        /* Defines if the status bar should be hidden when showing the picker. Default is true */
        config.hidesStatusBar = false

        /* Defines if the bottom bar should be hidden when showing the picker. Default is false */
        config.hidesBottomBar = true
        
        config.maxCameraZoomFactor = 2.0

        config.library.maxNumberOfItems = 1
        config.gallery.hidesRemoveButton = false
                
        
        /* Disable scroll to change between mode */
        // config.isScrollToChangeModesEnabled = false
//        config.library.minNumberOfItems = 2
        
        /* Skip selection gallery after multiple selections */
        // config.library.skipSelectionsGallery = true

        /* Here we use a per picker configuration. Configuration is always shared.
           That means than when you create one picker with configuration, than you can create other picker with just
           let picker = YPImagePicker() and the configuration will be the same as the first picker. */
        
        
        /* Only show library pictures from the last 3 days */
        //let threDaysTimeInterval: TimeInterval = 3 * 60 * 60 * 24
        //let fromDate = Date().addingTimeInterval(-threDaysTimeInterval)
        //let toDate = Date()
        //let options = PHFetchOptions()
        //options.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", fromDate as CVarArg, toDate as CVarArg)
        //
        ////Just a way to set order
        //let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        //options.sortDescriptors = [sortDescriptor]
        //
        //config.library.options = options

        config.library.preselectedItems = selectedItems
        
        let picker = YPImagePicker(configuration: config)

        /* Change configuration directly */
        // YPImagePickerConfiguration.shared.wordings.libraryTitle = "Gallery2"
        

        /* Multiple media implementation */
        picker.didFinishPicking { [unowned picker, weak self] items, cancelled in
            
            if cancelled {
                print("Picker was canceled")
//                self?.dismiss(animated: true) {
                    //self?.containerView.alpha = 1.0
//                }
                self?.presentingViewController?.dismiss(animated: true, completion: {
                    //
                })
                return
            }
            _ = items.map { print("🧀 \($0)") }
            
            self?.captionTextView.becomeFirstResponder()
            self?.selectedItems = items
            if let firstItem = items.first {
                switch firstItem {
                case .photo(let photo):
                    print("doing this 😡😡😡 111")
                    self?.selectedImageV.image = photo.image
                    self?.delegate.didPickImage(image: photo.image, isVideo: false, url: nil)
                    self?.isPhoto = true
                    
                    self?.selectedPhoto = photo.image
                    self?.presentingViewController?.dismiss(animated: true, completion: {
                        //
                    })
                    //picker.dismiss(animated: true, completion: nil)
                case .video(let video):
                    
                    print("doing this 😡😡😡 222")
                    self?.selectedImageV.image = video.thumbnail
                    
                    self?.isPhoto = false
                    
                    let assetURL = video.url
                    let playerVC = AVPlayerViewController()
                    let player = AVPlayer(playerItem: AVPlayerItem(url:assetURL))
                    playerVC.player = player
                    
                    self?.selectedVideo = video.url
                    
                    self?.selectedPhoto = video.thumbnail
                    self?.delegate.didPickImage(image: video.thumbnail, isVideo: true, url: video.url)
                    self?.presentingViewController?.dismiss(animated: true, completion: {
                        //
                    })
                    /*
                    picker.dismiss(animated: true, completion: { [weak self] in
                        self?.present(playerVC, animated: true, completion: nil)
                        print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
                    })
                    */
                }
            }
        }
        
        /* Single Photo implementation. */
        // picker.didFinishPicking { [unowned picker] items, _ in
        //     self.selectedItems = items
        //     self.selectedImageV.image = items.singlePhoto?.image
        //     picker.dismiss(animated: true, completion: nil)
        // }

        /* Single Video implementation. */
        //picker.didFinishPicking { [unowned picker] items, cancelled in
        //    if cancelled { picker.dismiss(animated: true, completion: nil); return }
        //
        //    self.selectedItems = items
        //    self.selectedImageV.image = items.singleVideo?.thumbnail
        //
        //    let assetURL = items.singleVideo!.url
        //    let playerVC = AVPlayerViewController()
        //    let player = AVPlayer(playerItem: AVPlayerItem(url:assetURL))
        //    playerVC.player = player
        //
        //    picker.dismiss(animated: true, completion: { [weak self] in
        //        self?.present(playerVC, animated: true, completion: nil)
        //        print("😀 \(String(describing: self?.resolutionForLocalVideo(url: assetURL)!))")
        //    })
        //}
        
        present(picker, animated: true) {
            self.containerView.alpha = 1.0
        }
    }
}

// Support methods
extension PickImageVideoViewController {
    /* Gives a resolution for the video by URL */
    func resolutionForLocalVideo(url: URL) -> CGSize? {
        guard let track = AVURLAsset(url: url).tracks(withMediaType: AVMediaType.video).first else { return nil }
        let size = track.naturalSize.applying(track.preferredTransform)
        return CGSize(width: abs(size.width), height: abs(size.height))
    }
}

//MARK: ACTIONS

extension PickImageVideoViewController {
    @objc func dismissTapped() {
        self.dismiss(animated: true) {
            //
        }
    }
}


/*
//MARK: TEXTFIELD DELEGATE & DATASOURCE

extension PickImageVideoViewController: UITextViewDelegate {
    
    @objc func dismissTapped() {
        self.dismiss(animated: true) {
            //
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let length = textView.text.count +  (text.count - range.length)
        countLabel.text = "\(500 - length)"
        return textView.text.count +  (text.count - range.length) <= 500
    }
    
    @objc func shareTapped() {
        if isPhoto, let selectedPhoto = selectedPhoto {
            ImageUploader.uploadPostImage(classId: self.classId, image: selectedPhoto) { [weak self] (error, success, url) in
                if let error = error {
                    print(error)
                    return
                }
                
                guard success else {
                    print("upload failed")
                    return
                }
                
                let post = PostCreate(classId: Instructor.current.classId, instructorId: Instructor.current.id, url: url, thumbnailUrl: nil, date: Date(), type: "Photo", caption: self?.captionTextView.text, title: nil)
                TPAPI.sharedInstance.addPost(post: post) { (success, post, error) in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    
                    guard success, let post = post else {
                        print("error")
                        return
                    }
                    
                    print("created post")
                    print(post)
                    
                    DispatchQueue.main.async {
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        } else if !isPhoto, let selectedVideo = selectedVideo {
            ImageUploader.uploadVideoForPost(classId: self.classId, video: selectedVideo) { [weak self] (error, success, videoUrl, thumbnailUrl) in
                if let error = error {
                    print(error)
                    return
                }
                
                guard success else {
                    print("upload failed")
                    return
                }
                
                let post = PostCreate(classId: Instructor.current.classId, instructorId: Instructor.current.id, url: videoUrl, thumbnailUrl: thumbnailUrl, date: Date(), type: "Video", caption: self?.captionTextView.text, title: nil)
                TPAPI.sharedInstance.addPost(post: post) { (success, post, error) in
                    guard error == nil else {
                        print(error!)
                        return
                    }
                    
                    guard success, let post = post else {
                        print("error")
                        return
                    }
                    
                    print("created post")
                    print(post)
                    
                    DispatchQueue.main.async {
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
}
 
 */

