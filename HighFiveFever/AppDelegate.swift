//
//  AppDelegate.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-06-23.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?;
    
    var fromLaunch = true;
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // set up music player
        AudioManager.sharedInstance.setUpPlayer(AudioManager.sharedInstance.menuSongName);
        AudioManager.sharedInstance.playMusic();
        
        // set up cache
        UserDefaults.standard.set(true, forKey: "isMenuMusicSet");
        UserDefaults.standard.set(true, forKey: "isGameMusicSet");
        
        return true;
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
 
        AudioManager.sharedInstance.stopMusic();
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        if(UserDefaults.standard.object(forKey: "isMenuMusicSet") as! Bool){
            if (AudioManager.sharedInstance.lastPlayedWasMenuSong ?? false) {
                AudioManager.sharedInstance.setUpPlayer(AudioManager.sharedInstance.menuSongName);
                AudioManager.sharedInstance.playMusic();
                AudioManager.sharedInstance.lastPlayedWasMenuSong = true;
            } else if (!fromLaunch){
                AudioManager.sharedInstance.setUpPlayer(AudioManager.sharedInstance.gameSongName);
                AudioManager.sharedInstance.playMusic();
                AudioManager.sharedInstance.lastPlayedWasMenuSong = false;
            }
        }
        fromLaunch = false;
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

