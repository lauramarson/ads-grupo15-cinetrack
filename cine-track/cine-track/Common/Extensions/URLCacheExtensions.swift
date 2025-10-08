//
//  URLCacheExtensions.swift
//  cine-track
//
//  Created by Laura Marson on 10/09/25.
//

import Foundation

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
