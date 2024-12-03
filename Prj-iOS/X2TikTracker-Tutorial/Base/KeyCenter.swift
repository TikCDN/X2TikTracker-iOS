//
//  KeyCenter.swift
//  X2TikTracker-Tutorial
//
//  Created by derek on 2024/12/3.
//

import Foundation

@objc
class KeyCenter: NSObject {
    /**
     TikCDN APP ID.
     TikCDN assigns App IDs to app developers to identify projects and organizations.
     If you have multiple completely separate apps in your organization, for example built by different teams,
     you should use different App IDs.
     If applications need to communicate with each other, they should use the same App ID.
     In order to get the APP ID, you can open the tikcdn console (https://console.tikcdn.cn) to create a project,
     then the APP ID can be found in the project detail page.
     TikCDN 给应用程序开发人员分配 App ID，以识别项目和组织。如果组织中有多个完全分开的应用程序，例如由不同的团队构建，
     则应使用不同的 App ID。如果应用程序需要相互通信，则应使用同一个App ID。
     进入TikCDN控制台(https://console.tikcdn.cn/)，创建一个项目，进入项目配置页，即可看到APP ID。
     */
    @objc
    static let AppId: String = <#YOUR APPID#>
}
