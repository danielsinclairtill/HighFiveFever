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
    
    fileprivate var musicPlayer: AVAudioPlayer = AVAudioPlayer();
    
    fileprivate var musicPlaying: Bool = false;
    
    var enteredFromPlayView: Bool = false;
    
    var lastPlayedWasMenuSong: Bool?;
    
    let menuSongName = "Zackery Wilson - SELECT Tech Samba [Chrono Trigger]_169740465_soundcloud";
    let gameSongName = "Zackery Wilson - RIGHT Off The Bat(tle) [Final Fantasy IV]_165634314_soundcloud";
    fileprivate let mp3 = "mp3";
    
    fileprivate override init() {
        
    }
    
    func setUpPlayer(_ songName: String) {
        let song = Bundle.main.path(forResource: songName, ofType: mp3);
        
        do {
            let songUrl = URL(fileURLWithPath: song!);
            try musicPlayer = AVAudioPlayer(contentsOf: songUrl);
            
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
