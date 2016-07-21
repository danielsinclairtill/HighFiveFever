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
    
    var enteredFromPlayView: Bool = false;
    
    var lastPlayedWasMenuSong: Bool?;
    
    let menuSongName = "Zackery Wilson - SELECT Tech Samba [Chrono Trigger]_169740465_soundcloud";
    let gameSongName = "Zackery Wilson - RIGHT Off The Bat(tle) [Final Fantasy IV]_165634314_soundcloud";
    private let mp3 = "mp3";
    
    private override init() {
        
    }
    
    func setUpPlayer(songName: String) {
        let song = NSBundle.mainBundle().pathForResource(songName, ofType: mp3);
        
        do {
            let songUrl = NSURL(fileURLWithPath: song!);
            try musicPlayer = AVAudioPlayer(contentsOfURL: songUrl);
            
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
