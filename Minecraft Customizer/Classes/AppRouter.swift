//
//  AppRouter.swift
//  Minecraft Customizer
//
//  Created by Brad Walker on 3/30/15.
//  Copyright (c) 2015 Torchline Technology. All rights reserved.
//

import UIKit

class AppRouter {
	class func sharedRouter() -> AppRouter {
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		return appDelegate.router
	}
	
	private let window = UIWindow(frame: UIScreen.mainScreen().bounds)
	private let tabBarController = UITabBarController()
	
	init() {
		self.window.backgroundColor = UIColor.whiteColor()
		self.window.rootViewController = self.tabBarController
		self.window.makeKeyAndVisible()
		
		self.window.addSubview(self.newPickaxeImageView())
	}
	
	private func newPickaxeImageView() -> UIImageView {
		let imageView = UIImageView(frame: CGRectMake(0, 64, 128, 128))
		imageView.layer.magnificationFilter = kCAFilterNearest
		
		let url = NSBundle.mainBundle().URLForResource("jolicraft", withExtension: "zip")
		
		if url != nil {
			let pack = ResourcePack(url: url!)
			let pickaxe = pack.imageForKey("assets/minecraft/textures/items/stone_pickaxe.png")
			imageView.image = pickaxe
		}
		
		return imageView;
	}
}
