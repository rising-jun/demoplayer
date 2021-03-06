//
//  MusicInfo.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/08/06.
//

import Foundation

public struct MusicInfo: Codable {
    let singer: String
    let album: String
    let title: String
    let duration: Int
    let image: String
    let file: String
    let lyrics: String
    
}
