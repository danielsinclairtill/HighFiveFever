//
//  AudioManager.swift
//  High Five Fever
//
//  Created by Luis Abraham on 2016-07-01.
//  Copyright © 2016 Lunet Apps. All rights reserved.
//

import UIKit
import AVFoundation

class AudioManager: NSObject {
    
    static let sharedInstance = AudioManager();
    
    private var musicPlayer: AVAudioPlayer = AVAudioPlayer();
    
    private var musicPlaying: Bool = false;
    
    private let menuSongName = "prelude_c";
    private let mp3 = "mp3";
    
    private override init() {
        
    }
    
    func setUpPlayer() {
        
        let menuSong = NSBundle.mainBundle().pathForResource(menuSongName, ofType: mp3);
        
        do {
            let menuSongUrl = NSURL(fileURLWithPath: menuSong!);
            try musicPlayer = AVAudioPlayer(contentsOfURL: menuSongUrl);
            
        } catch {
            print ("Error setting up music player");
        }
    }
    
    func playMusic() {
        
        if (!musicPlaying){
            musicPlayer.play();
            musicPlaying = true;
        }
    }
    
    func stopMusic() {
        
        if (musicPlaying){
            musicPlayer.stop();
            musicPlaying = false;
        }
    }

}
