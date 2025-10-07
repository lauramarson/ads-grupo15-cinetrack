//
//  TabBarViewModel.swift
//  cine-track
//
//  Created by Laura Marson on 09/09/25.
//

import Foundation
import SwiftUI

@Observable
final class TabBarViewModel {
    
    var selectedTab: Int = 0
    
    var currentTitle: String {
        switch selectedTab {
        case 0:
            return "CINETrack"
        case 1:
            return "Assistir Depois"
        case 2:
            return "Assistidos"
        default:
            return "CINETrack"
        }
    }
    
    var searchTabTitle: String {
        return "Buscar"
    }
    
    var watchedTabTitle: String {
        return "Assistidos"
    }
    
    var watchLaterTabTitle: String {
        return "Assistir Depois"
    }
    
    func updateSelectedTab(_ index: Int) {
        selectedTab = index
    }
    
    func getTabTitle(for index: Int) -> String {
        switch index {
        case 0:
            return searchTabTitle
        case 1:
            return watchLaterTabTitle
        case 2:
            return watchedTabTitle
        default:
            return ""
        }
    }
    
    func getTabSystemImage(for index: Int) -> String {
        switch index {
        case 0:
            return "magnifyingglass"
        case 1:
            return "bookmark"
        case 2:
            return "checkmark.circle"
        default:
            return ""
        }
    }
}
