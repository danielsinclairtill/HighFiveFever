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
    fileprivate var musicPlayer: AVAudioPlayer?
    fileprivate var musicPlaying: Bool = false;
    
    fileprivate let menuSongName = "Zackery Wilson - SELECT Tech Samba [Chrono Trigger]_169740465_soundcloud";
    fileprivate let gameSongName = "Zackery Wilson - RIGHT Off The Bat(tle) [Final Fantasy IV]_165634314_soundcloud";
    fileprivate let mp3 = "mp3";
    
    func startGameMusic() {
        musicPlaying = false
        setUpPlayer(gameSongName)
        playMusic()
    }
    
    func startMenuMusic() {
        musicPlaying = false
        setUpPlayer(menuSongName)
        playMusic()
    }

    func setUpPlayer(_ songName: String) {
        let song = Bundle.main.path(forResource: songName, ofType: mp3);
        
        do {
            let songUrl = URL(fileURLWithPath: song!);
            try musicPlayer = AVAudioPlayer(contentsOf: songUrl);
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.prepareToPlay()
            
        } catch {
            print ("Error setting up music player...");
        }
    }
    
    func removeMusic() {
        if let musicPlayer = musicPlayer {
            musicPlayer.stop()
        }
        musicPlayer = nil
    }
    
    func playMusic() {
        guard let musicPlayer = musicPlayer else{ return }
        if (!musicPlaying){
            musicPlayer.play();
            musicPlaying = true;
        }
    }
    
    func stopMusic() {
        guard let musicPlayer = musicPlayer else{ return }
        if (musicPlaying){
            musicPlayer.stop();
            musicPlaying = false;
        }
    }

}
