//
//  ConnectChannelTableViewCell.swift
//  AutoPilot_Admin
//
//  Created by Stephen Mata on 8/27/23.
//

import UIKit

class ConnectChannelTableViewCell: UITableViewCell {

    var shadowLayer = UIView()
    var contentLayer = UIImageView()
    var channelTitleLabel = UILabel()
    var detailLabel = UILabel()
    var userOneContainer = UIView()
    var userOneImageView = UIImageView()
    var userTwoContainer = UIView()
    var userTwoImageView = UIImageView()
    var userThreeContainer = UIView()
    var userThreeImageView = UIImageView()
    var newMessageLabel = UILabel()
    var arrowImageView = UIImageView()
    var mailImageView = UIImageView()
    
    //New Views
    
    var circleImageView = UIImageView()
    var phImageView = UIImageView()
    var chatNameLabel = UILabel()
    var chatDescriptionLabel = UILabel()
    var dividerLine = UIView()
    var newMessageBubble = UIView()
    
    var channelUrl: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        //setupViews()
        setupNewViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: VIEWS

extension ConnectChannelTableViewCell {
    
    func setupNewViews() {
        
        phImageView.image = UIImage(named: "enigmaUserPH")
        phImageView.backgroundColor = .clear
        phImageView.layer.cornerRadius = .createAspectRatio(value: 57)/2
        phImageView.layer.masksToBounds = true
        phImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(phImageView)
        phImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        phImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        phImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 57)).isActive = true
        phImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 57)).isActive = true
        
        circleImageView.backgroundColor = .clear
        circleImageView.layer.cornerRadius = .createAspectRatio(value: 57)/2
        circleImageView.layer.masksToBounds = true
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(circleImageView)
        circleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .createAspectRatio(value: 20)).isActive = true
        circleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        circleImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 57)).isActive = true
        circleImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 57)).isActive = true
        
        chatNameLabel.text = "Community"
        chatNameLabel.font = .sofiaProSemiBold(ofSize: .createAspectRatio(value: 21))
        chatNameLabel.textColor = .black
        chatNameLabel.numberOfLines = 1
        chatNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chatNameLabel)
        chatNameLabel.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        chatNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 50)).isActive = true
        chatNameLabel.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor, constant: -.createAspectRatio(value: 9)).isActive = true
        
        chatDescriptionLabel.text = "Lorem ipsum dolor sit amet"
        chatDescriptionLabel.font = .sofiaProRegular(ofSize: .createAspectRatio(value: 12))
        chatDescriptionLabel.textColor = .black.withAlphaComponent(0.5)
        chatDescriptionLabel.numberOfLines = 0
        chatDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chatDescriptionLabel)
        chatDescriptionLabel.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: .createAspectRatio(value: 12)).isActive = true
        chatDescriptionLabel.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor, constant: .createAspectRatio(value: 9)).isActive = true
        
        arrowImageView.image = UIImage(named: "channelArrow")
        arrowImageView.setImageColor(color: .black.withAlphaComponent(0.35))
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(arrowImageView)
        arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.createAspectRatio(value: 16)).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        
        newMessageBubble.backgroundColor = .lightGray
        newMessageBubble.layer.cornerRadius = .createAspectRatio(value: 12)/2
        newMessageBubble.layer.masksToBounds = true
        newMessageBubble.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(newMessageBubble)
        newMessageBubble.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -.createAspectRatio(value: 8)).isActive = true
        newMessageBubble.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        newMessageBubble.heightAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        newMessageBubble.widthAnchor.constraint(equalToConstant: .createAspectRatio(value: 12)).isActive = true
        
    }
    
    func setupViews() {
        
        shadowLayer.backgroundColor = .clear
        shadowLayer.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 4, height: 4), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        shadowLayer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shadowLayer)
        shadowLayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        shadowLayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
        shadowLayer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        shadowLayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        contentLayer.backgroundColor = .red
        contentLayer.contentMode = .scaleAspectFill
        contentLayer.layer.cornerRadius = 8
        contentLayer.layer.masksToBounds = true
        contentLayer.translatesAutoresizingMaskIntoConstraints = false
        shadowLayer.addSubview(contentLayer)
        contentLayer.fillSuperview()
        
        channelTitleLabel.font = .sofiaProBold(ofSize: 20)
        channelTitleLabel.textAlignment = .left
        channelTitleLabel.textColor = .white
        channelTitleLabel.numberOfLines = 0
        channelTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLayer.addSubview(channelTitleLabel)
        channelTitleLabel.leadingAnchor.constraint(equalTo: contentLayer.leadingAnchor, constant: 16).isActive = true
        channelTitleLabel.topAnchor.constraint(equalTo: contentLayer.topAnchor, constant: 14).isActive = true
        
        detailLabel.font = .sofiaProRegular(ofSize: 14)
        detailLabel.textAlignment = .left
        detailLabel.textColor = .white.withAlphaComponent(0.7)
        detailLabel.numberOfLines = 0
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLayer.addSubview(detailLabel)
        detailLabel.leadingAnchor.constraint(equalTo: channelTitleLabel.leadingAnchor, constant: 0).isActive = true
        detailLabel.topAnchor.constraint(equalTo: channelTitleLabel.bottomAnchor, constant: 10).isActive = true
        
        mailImageView.image = UIImage(named: "whiteMail")
        mailImageView.contentMode = .scaleAspectFill
        mailImageView.translatesAutoresizingMaskIntoConstraints = false
        contentLayer.addSubview(mailImageView)
        mailImageView.leadingAnchor.constraint(equalTo: detailLabel.leadingAnchor, constant: 0).isActive = true
        mailImageView.bottomAnchor.constraint(equalTo: contentLayer.bottomAnchor, constant: -19).isActive = true
        mailImageView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        mailImageView.widthAnchor.constraint(equalToConstant: 18).isActive = true
        
        newMessageLabel.font = .sofiaProRegular(ofSize: 14)
        newMessageLabel.textAlignment = .left
        newMessageLabel.textColor = .white
        newMessageLabel.numberOfLines = 0
        newMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLayer.addSubview(newMessageLabel)
        newMessageLabel.leadingAnchor.constraint(equalTo: mailImageView.trailingAnchor, constant: 9).isActive = true
        newMessageLabel.centerYAnchor.constraint(equalTo: mailImageView.centerYAnchor, constant: 0).isActive = true
        
        arrowImageView.image = UIImage(named: "channelArrow")
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        contentLayer.addSubview(arrowImageView)
        arrowImageView.trailingAnchor.constraint(equalTo: contentLayer.trailingAnchor, constant: -13).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: channelTitleLabel.centerYAnchor, constant: 0).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
                
    }
    
    func createContainer(userContainer: UIView) {
        userContainer.addShadow(shadowColor: .black, shadowOffset: CGSize(width: 2, height: 2), shadowOpacity: 0.2, shadowRadius: 4, shadowCornerRadius: 0)
        userContainer.backgroundColor = .clear
        userContainer.translatesAutoresizingMaskIntoConstraints = false
        contentLayer.addSubview(userContainer)
        userContainer.heightAnchor.constraint(equalToConstant: 20).isActive = true
        userContainer.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func createImageContainer(userContainer: UIView, userImageView: UIImageView) {
        userImageView.backgroundColor = .lightGray
        userImageView.layer.borderWidth = 1.71
        userImageView.layer.cornerRadius = 20/2
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.contentMode = .scaleAspectFill
        userImageView.layer.masksToBounds = true
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userContainer.addSubview(userImageView)
        userImageView.fillSuperview()
        
    }
    
}
