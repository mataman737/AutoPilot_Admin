//
//  CustomChatChannelVC.swift
//  Enigma_Admin
//
//  Created by Stephen Mata on 7/15/22.
//

import Foundation
import StreamChatUI
import StreamChat

protocol CustomChatChannelVCDelegate: AnyObject {
    func didCloseChannel()
}

class CustomChatChannelVC: ChatChannelVC {
    
    weak var chatChannelDelegate: CustomChatChannelVCDelegate?
    
    override func viewWillDisappear(_ animated: Bool) {
        chatChannelDelegate?.didCloseChannel()
    }
    
//    override var headerView: ChatChannelHeaderView {
//        return CustomChatChannelHeaderView()
//    }
    
//    override var messageComposerVC: ComposerVC {
//        return CustomMessageComposerVC
//    }
}

class CustomMessageComposerVC: ComposerVC {
    override func createNewMessage(text: String) {
        guard let cid = channelController?.cid else { return }
        
        // If the user included some mentions via suggestions,
        // but then removed them from text, we should remove them from
        // the content we'll send
        for user in content.mentionedUsers {
            if !text.contains(mentionText(for: user)) {
                content.mentionedUsers.remove(user)
            }
        }

        if let threadParentMessageId = content.threadMessage?.id {
            let messageController = channelController?.client.messageController(
                cid: cid,
                messageId: threadParentMessageId
            )

//            messageController?.pin(.expirationTime(120))
            
//            messageController?.synchronize() { error in
//                if error == nil {
//                    messageController?.channel?.pinnedMessages
//                }
//            }
            
            messageController?.createNewReply(
                text: text,
                pinning: nil,
                attachments: content.attachments,
                mentionedUserIds: content.mentionedUsers.map(\.id),
                showReplyInChannel: composerView.checkboxControl.isSelected,
                quotedMessageId: content.quotingMessage?.id
            )
            return
        }
    }
}

class CustomChatChannelHeaderView: ChatChannelHeaderView {
    var typingUsers = Set<ChatUser>()

    // Handle typing events
    override func channelController(
        _ channelController: ChatChannelController,
        didChangeTypingUsers typingUsers: Set<ChatUser>
    ) {
        // Save the current typing users but the current user.
        // Then update the content.
        self.typingUsers = typingUsers.filter { $0.id != currentUserId }
        updateContentIfNeeded()
    }

    // The subtitleText is responsible to render the status of the members.
    override var subtitleText: String? {
        if !typingUsers.isEmpty {
            return "typing..."
        }

        return "" //super.subtitleText
    }
    
    override var titleText: String? {
        return super.titleText // super.titleText == nil ? EinsteinSignalsViewController.titleText : super.titleText
    }
}
