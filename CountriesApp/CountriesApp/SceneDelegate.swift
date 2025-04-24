//
//  SceneDelegate.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
     var appCoordinator: AppCoordinator?
     
     func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
         guard let windowScene = (scene as? UIWindowScene) else { return }
         
         let navigationController = UINavigationController()
         
         window = UIWindow(windowScene: windowScene)
         window?.rootViewController = navigationController
         window?.makeKeyAndVisible()
         
         appCoordinator = AppCoordinator(navigationController: navigationController)
         appCoordinator?.start()
     }
}

