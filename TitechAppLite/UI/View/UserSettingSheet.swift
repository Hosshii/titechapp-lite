//
//  UserSettingSheet.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/29.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import SwiftUI

struct UserSettingSheet: View {
    @State var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userSettingViewModel: UserSettingViewModel
    var body: some View {
        NavigationView {
            Form {
                TextField("URL",text: $userSettingViewModel.ocwiCalenderURL)
                    .autocapitalization(.none)
                    .keyboardType(.URL)
                Button(action: {
                    userSettingViewModel.save()
                    self.showAlert = true
                }){
                    Text("保存")
                }
                .disabled(!ValidURL.verifyUrl(urlString: userSettingViewModel.ocwiCalenderURL))
                
            }
            .navigationBarTitle(Text("カレンダーURL設定"), displayMode: .inline)
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("保存完了"),
                    dismissButton: .default(
                        Text("ok"),
                        action: {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                )
            })
        }
        .onAppear {
            self.userSettingViewModel.appear()
        }
    }
}

struct UserSettingSheet_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingSheet()
    }
}
