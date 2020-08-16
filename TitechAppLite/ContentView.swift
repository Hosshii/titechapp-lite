//
//  ContentView.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/08/16.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(0..<10){_ in
            HStack {
                Rectangle().fill(Color("main")).frame(width: 5, height: 100, alignment: .leading)
            
                VStack{
                    Spacer()
                    HStack{
                        Text("today")
                    }
                    Spacer()
                    HStack {
                        Text("Today")
                    }
                    Spacer()
                }
                VStack(alignment: .leading){
                    Spacer()
                    HStack{
                        Text("programming").lineLimit(2)
                    }
                    Spacer()
                    HStack{
                        Text("Week 1 Description")
                    }
                    Spacer()
                }
                Spacer()
                Text("w222")
                
            }.frame(height: 100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
