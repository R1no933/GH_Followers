//
//  Constants.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 31.08.2022.
//

import UIKit
//MARK: - Enum for SFSumbols
enum SFSymbols {
    static let location = UIImage(systemName: "mappin.circle.fill")
    static let repose = UIImage(systemName:"folder.circle.fill")
    static let gists = UIImage(systemName:"doc.circle.fill")
    static let followers = UIImage(systemName:"heart.circle.fill")
    static let following = UIImage(systemName:"person.circle.fill")
    static let search = UIImage(systemName:"magnifyingglass.circle.fill")
    static let favoriteTabBar = UIImage(systemName:"star.circle.fill")
}

//MARK: - Enum for images
enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
    static let avatarPlaceholder = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")
}

//MARK: - Enum for getting screen size
enum ScreenSize {
    static let height = UIScreen.main.bounds.height
    static let widht = UIScreen.main.bounds.width
    static let maxLenght = max(ScreenSize.widht, ScreenSize.height)
    static let minLenght = min(ScreenSize.widht, ScreenSize.height)
}

//MARK: - Enum for change device type
enum DeviceType {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale

    static let isiPhoneSE = idiom == .phone && ScreenSize.maxLenght == 568.0
    static let isiPhone8Standart = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale > scale
    static let isiPhone8PluseStandart = idiom == .phone && ScreenSize.maxLenght == 736.0
    static let isiPhone8PluseZoomed = idiom == .phone && ScreenSize.maxLenght == 736.0 && nativeScale < scale
    static let isiPhoneX = idiom == .phone && ScreenSize.maxLenght == 812.0
    static let isiPhoneXsAndXr = idiom == .phone && ScreenSize.maxLenght == 896.0
    static let isiPad = idiom == .pad && ScreenSize.maxLenght >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsAndXr
    }
}
