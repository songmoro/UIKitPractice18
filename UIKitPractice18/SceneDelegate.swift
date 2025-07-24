//
//  SceneDelegate.swift
//  UIKitPractice18
//
//  Created by 송재훈 on 7/23/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
            
        let tabBarController = UITabBarController()
        let lotteryViewController = UINavigationController(rootViewController: LotteryViewController())
        let boxOfficeViewController = UINavigationController(rootViewController: BoxOfficeViewController())
        
        tabBarController.setViewControllers([lotteryViewController, boxOfficeViewController], animated: true)
        
        if let items = tabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "faxmachine.fill")
            items[0].image = UIImage(systemName: "faxmachine")
            items[0].title = "로또"
            
            items[1].selectedImage = UIImage(systemName: "ticket.fill")
            items[1].image = UIImage(systemName: "ticket")
            items[1].title = "박스오피스"
        }
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}
