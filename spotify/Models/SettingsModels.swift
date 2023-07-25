//
//  SettingsModels.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 7/3/23.
//

import Foundation

struct Section{
    let title:String
    let options:[Option]
}

struct Option{
    let title:String
    let handler: ()-> Void
}
