//
//  PlaylistDetailsReponse.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 7/18/23.
//

import Foundation

struct PlaylistDetailsResponse: Codable {
    let description: String
    let external_urls:[String:String]
    let id:String
    let name:String
    let images:[APIImage]
    let tracks: PlaylistTrackResponse
}

struct PlaylistTrackResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable{
    let track: AudioTrack
}
