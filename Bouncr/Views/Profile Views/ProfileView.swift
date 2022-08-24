//
//  ProfileView.swift
//  Bouncr
//
//  Created by Kenny Hu on 8/6/22.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var mainController: MainController
    @ObservedObject var otherUserController: OtherUserController
    init(otherUserController: OtherUserController) {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0, blue: 1, alpha: 1)
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UINavigationBar.appearance().tintColor = .white
        
        self.otherUserController = otherUserController
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                ProfileTopBar(otherUserController: otherUserController)
                
                ProfileInfo()
                
            }
            Spacer()
            
        } //End NavigationView
        
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
