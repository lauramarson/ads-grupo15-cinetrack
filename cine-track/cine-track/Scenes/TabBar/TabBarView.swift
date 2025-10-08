//
//  TabBarView.swift
//  cine-track
//
//  Created by Laura Marson on 08/09/25.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var viewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            SearchView()
                .tabItem {
                    Image(systemName: viewModel.getTabSystemImage(for: 0))
                    Text(viewModel.getTabTitle(for: 0))
                }
                .tag(0)
            
            SavedMovies(.toWatch)
                .tabItem {
                    Image(systemName: viewModel.getTabSystemImage(for: 1))
                    Text(viewModel.getTabTitle(for: 1))
                }
                .tag(1)
            
            SavedMovies(.watched)
                .tabItem {
                    Image(systemName: viewModel.getTabSystemImage(for: 2))
                    Text(viewModel.getTabTitle(for: 2))
                }
                .tag(2)
        }
        .onAppear {
            setTabBarAppearance()
            setUISearchBarAppeareance()
            setNavigationBarAppeareance()
            configureGlobalTabBarBehavior()
        }
    }
    
    private func setUISearchBarAppeareance() {
        // More specific appearance targeting for SwiftUI searchable
        UISearchTextField.appearance().textColor = Color.softWhite.uiColor
        UISearchTextField.appearance().tintColor = Color.softWhite.uiColor
        UISearchTextField.appearance().attributedPlaceholder = NSAttributedString(
            string: "Buscar filmes...",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        
        // Additional UITextField targeting
        UITextField.appearance().textColor = Color.softWhite.uiColor
        UITextField.appearance().tintColor = Color.softWhite.uiColor
        
        // Target specifically within search containers
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = Color.softWhite.uiColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = Color.softWhite.uiColor
        
        // Search bar styling
        UISearchBar.appearance().searchTextPositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        UISearchBar.appearance().tintColor = Color.softWhite.uiColor
        UISearchBar.appearance().setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(Color.softWhite.uiColor, renderingMode: .alwaysOriginal), for: .search, state: .normal)
        
        // Cancel button
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = Color.softWhite.uiColor
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([
            .foregroundColor: Color.softWhite.uiColor
        ], for: .normal)
    }
    
    private func setNavigationBarAppeareance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Color.background.uiColor
        appearance.titleTextAttributes = [.foregroundColor: Color.softWhite.uiColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: Color.softWhite.uiColor]
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Color.background.uiColor
        
        // Set selected tab item color to softWhite
        appearance.stackedLayoutAppearance.selected.iconColor = Color.softWhite.uiColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: Color.softWhite.uiColor]
        
        // Set unselected tab item color (optional)
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func configureGlobalTabBarBehavior() {
        // Hide tab bar on push globally
        UITabBar.appearance().isTranslucent = true
    }
}

#if DEBUG
#Preview {
    TabBarView()
}
#endif
