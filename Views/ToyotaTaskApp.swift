//
//  ToyotaTaskApp.swift
//  ToyotaTaskApp
//
//  Created by Taha Metwally.
//

import SwiftUI

/**
 The `ToyotaTaskApp` struct represents the main entry point of the SwiftUI application.
 
 It defines the structure and behavior of the application, including the initial view displayed to the user.
 */
@main
struct ToyotaTaskApp: App {
    
    /// The state object representing the dependencies of the application.
    @StateObject private var appDependencies = AppDependencies()
    
    /// A state variable to control the visibility of the launch screen.
    @State private var showLaunchScreen = true
    
    /// The main content of the application, defining the structure and behavior of the UI.
    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchScreenView()
                    .onAppear {
                        // Simulate a delay for the launch screen before transitioning to the main content.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }.accessibility(identifier: "launch_screen")
            } else {
                // Display the main content of the application after the launch screen.
                MealsListView()
                    .environmentObject(appDependencies.mealDetailViewModel)
                    .environmentObject(appDependencies.mealsViewModel)
                    .environmentObject(appDependencies.reachability)
                    .environment(\.sizeCategory, .large).accessibility(identifier: "meals_list_view")
            }
        }
    }
}
