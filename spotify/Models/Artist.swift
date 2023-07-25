//
//  Artist.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 6/27/23.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String:String]
}
