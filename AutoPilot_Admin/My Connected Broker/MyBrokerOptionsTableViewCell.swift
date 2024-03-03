//
//  MyBrokerOptionsTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 9/11/23.
//

import UIKit
import Lottie

protocol MyBrokerOptionsTableViewCellDelegate: AnyObject {
    func clickedToDeleteBroker(brokersIndex: Int)
}

class MyBrokerOptionsTableViewCell: UITableViewCell {
    
    var isNVUDemo = UserDefaults()
    weak var delegate: MyBrokerOptionsTableViewCellDelegate?
    var containerView = UIView()
    var containerLabel = UILabel()
    var serverLabel = UILabel()
    var dividerLine = UIView()
    var radioOne = LottieAnimationView()
    var threeDotsImageView = UIImageView()
    var deleteLabel = UILabel()
    var threeDotsButton = UIButton()
    var brokerIndex = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
      
}

//MARK: HELPERS

extension MyBrokerOptionsTableViewCell {
    func setupViews() {
        
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        containerView.fillSuperview()
        containerView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        
        let radioAnimation = LottieAnimation.named("radio")
        radioOne.isUserInteractionEnabled = false
        radioOne.alpha = 1.0
        radioOne.animation = radioAnimation
        radioOne.contentMode = .scaleAspectFill
        radioOne.backgroundColor = .clear
        radioOne.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(radioOne)
        //radioOne.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        radioOne.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .createAspectRatio(value: 10)).isActive = true
        radioOne.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        radioOne.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 45)).isActive = true
        radioOne.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 45)).isActive = true
        radioOne.play(fromFrame: 0, toFrame: 0, loopMode: .playOnce, completion: nil)
        
        let loadingLayers = ["Shape Layer 3.Ellipse 1.Fill 1.Color", "Shape Layer 1.Ellipse 1.Stroke 1.Color", "Shape Layer 2.Ellipse 1.Fill 1.Color"]
        for layer in 1...loadingLayers.count {
            let keyPath = AnimationKeypath(keypath: "\(loadingLayers[layer - 1])")
            let colorProvider = ColorValueProvider(isNVUDemo.bool(forKey: "isNVUDemo") ? UIColor.nvuBlueOne.lottieColorValue : UIColor.themeOrange.lottieColorValue)
            radioOne.setValueProvider(colorProvider, keypath: keyPath)
        }
        
        containerLabel.textAlignment = .left
        containerLabel.textColor = UIColor(red: 17/255, green: 18/255, blue: 19/255, alpha: 1.0)
        containerLabel.font = .poppinsMedium(ofSize: 16)
        containerLabel.numberOfLines = 0
        containerLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(containerLabel)
        containerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .createAspectRatio(value: 50)).isActive = true
        containerLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -.createAspectRatio(value: 10)).isActive = true
        
        serverLabel.textAlignment = .left
        serverLabel.textColor = UIColor(red: 17/255, green: 18/255, blue: 19/255, alpha: 1.0)
        serverLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 14))
        serverLabel.numberOfLines = 0
        serverLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(serverLabel)
        serverLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .createAspectRatio(value: 50)).isActive = true
        serverLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: .createAspectRatio(value: 10)).isActive = true

        dividerLine.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 230/255, alpha: 1.0)
        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dividerLine)
        dividerLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 1)).isActive = true
        
        //threeDotsImageView.backgroundColor = .re
        threeDotsImageView.isHidden = true
        threeDotsImageView.image = UIImage(named: "threeDots")
        threeDotsImageView.contentMode = .scaleAspectFill
        threeDotsImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(threeDotsImageView)
        threeDotsImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        threeDotsImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        threeDotsImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 10)).isActive = true
        threeDotsImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 4)).isActive = true
        
        deleteLabel.isHidden = true
        deleteLabel.text = "Delete"
        deleteLabel.textAlignment = .left
        deleteLabel.textColor = UIColor.newRed
        deleteLabel.font = .poppinsMedium(ofSize: .createAspectRatio(value: 12))
        deleteLabel.numberOfLines = 0
        deleteLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(deleteLabel)
        deleteLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        deleteLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        threeDotsButton.isHidden = true
        threeDotsButton.addTarget(self, action: #selector(didTapToDelete), for: .touchUpInside)
        threeDotsButton.backgroundColor = .clear
        threeDotsButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(threeDotsButton)
        threeDotsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        threeDotsButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        threeDotsButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        threeDotsButton.leadingAnchor.constraint(equalTo: deleteLabel.leadingAnchor, constant: -.createAspectRatio(value: 30)).isActive = true
    }
}

//MARK: ACTIONS

extension MyBrokerOptionsTableViewCell {
    @objc func didTapToDelete() {
        lightImpactGenerator()
        delegate?.clickedToDeleteBroker(brokersIndex: brokerIndex)
    }
    
    func selectedState() {
        radioOne.play(fromFrame: 51, toFrame: 51, loopMode: .playOnce, completion: nil)
    }
    
    func didMakeSelection() {
        radioOne.play()
    }
    
    func newOptionSelected() {
        radioOne.play(fromFrame: 0, toFrame: 0, loopMode: .playOnce, completion: nil)
    }
    
}

