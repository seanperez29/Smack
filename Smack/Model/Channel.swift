//
//  Channel.swift
//  Smack
//
//  Created by Sean Perez on 9/2/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

struct Channel: Decodable {
    
    private(set) var _id: String
    private(set) var name: String
    private(set) var description: String
    private(set) var __v: Int?
    
}
