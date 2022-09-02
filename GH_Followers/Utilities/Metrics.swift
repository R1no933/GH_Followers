//
//  Metrics.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 02.09.2022.
//

import UIKit

//Enum for UI elements metrics
enum Metrics {
    
    //SearchViewController
    enum Search {
        static let imageViewSize: CGFloat = 220
        static let textFieldConstraints: CGFloat = 50
        static let buttonConstraints: CGFloat = 50
    }
    
    //UserInfoViewController
    enum UserInfo {
        static let contentViewHeight: CGFloat = 600
        static let padding: CGFloat = 20
        
        static let headerViewHeight: CGFloat = 220
        static let itemViewHeight: CGFloat = 140
        
        static let createdLabelHeight: CGFloat = 60
    }
    
    //GHFEmptyStateView
    enum EmptyState {
        static let messageLabelPadding: CGFloat = 40
        static let messageLabelYAnchor: CGFloat = 200
        static let messageLabelHeight: CGFloat = 200
        
        static let multiplier: CGFloat = 1.3
        static let imageViewTrailing: CGFloat = 255
        static let imageViewBottom: CGFloat = -40
    }
    
    //GHFItemInfoView
    enum ItemInfo {
        static let imageViewSize: CGFloat = 20
        static let titleLeading: CGFloat = 12
        static let countTop: CGFloat = 4
        static let labelHeight: CGFloat = 18
    }
    
    //FollowerCell
    enum FollowerCell {
        static let padding: CGFloat = 10
        static let labelHeight: CGFloat = 20
    }
    
    //FavoriteCell
    enum FavoriteCell {
        static let avatarSize: CGFloat = 60
        static let avatarLeading: CGFloat = 12
        
        static let usernameLeading: CGFloat = 24
        static let usernameTrailing: CGFloat = -12
        static let usernameHeight: CGFloat = 40
    }
    
    //GHFItemInfoViewController
    enum ItemInfoVC {
        static let padding: CGFloat = 20
        static let height: CGFloat = 50
    }
    
    //GHFAlertViewController
    enum AlertVC {
        static let containerViewHeight: CGFloat = 250
        static let containerViewWidth: CGFloat = 310
        
        static let titleLabelPadding: CGFloat = 20
        static let titleLabelHeight: CGFloat = 28
        
        static let messageLabelTopAndBot: CGFloat = 6
        static let messageLabelLeadingAndTrailing: CGFloat = 24
        
        static let buttonPadding: CGFloat = 28
        static let buttonHeight: CGFloat = 40
    }
    
    //GHFUserInfoHeaderViewController
    enum UserInfoHeader {
        static let avatarTop: CGFloat = 20
        static let avatarSize: CGFloat = 90
         
        static let usernameLeading: CGFloat = 12
        static let usernameHeight:CGFloat = 38
        
        static let nameYAcnhor: CGFloat = 5
        static let nameLeading: CGFloat = 12
        static let nameHeight: CGFloat = 20
        
        static let locationImageLeading: CGFloat = 12
        static let locationImageSize: CGFloat = 20
        
        static let locationLabelLeading: CGFloat = 5
        static let locationLabelHeight: CGFloat = 20
        
        static let bioTop: CGFloat = 12
        static let bioHeight: CGFloat = 90
    }
}
