//
//  HomeToolBarContent.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/12/2025.
//

import SwiftUI

struct HomeToolBarContent: ToolbarContent {
     var body: some ToolbarContent {
         ToolbarItem(placement: .navigationBarTrailing) {
             Button {
                 
             } label: {
                 Image(systemName: "plus")
             }

         }
         
     }
 }

// MARK: - Preview

#Preview {
    NavigationStack {
        Text("ToolBar Contnet Preview")
            .toolbar { HomeToolBarContent() }
    }
}

