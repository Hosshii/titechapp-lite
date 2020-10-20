//
//  MenuButton.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/27.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import SwiftUI

struct MenuButton: View {
    @Binding var isPresented: Bool
    var body: some View {
        Button(action: {
            print("Button Tapped")
            self.isPresented.toggle()
        }){
            Text("設定")
        }.foregroundColor(Color("main"))
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(isPresented: .constant(true))
    }
}
