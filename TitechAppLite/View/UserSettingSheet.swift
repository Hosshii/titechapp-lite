//
//  UserSettingSheet.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/29.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import SwiftUI

struct UserSettingSheet: View {
    @State var ocwiCalenderUrl: String = UserSetting.getOcwiCalenderURL()?.absoluteString ?? ""
    @State var showAlert: Bool = false
    @Binding var isSheetPresented: Bool
    var body: some View {
        NavigationView {
            Form {
                TextField("URL",text: $ocwiCalenderUrl)
                Button(action: {
                    print("Button Tapped")
                    guard let url = URL.init(string: ocwiCalenderUrl) else{
                        return
                    }
                    UserSetting.setOcwiCalenderURL(url)
                    self.showAlert = true
                }){
                    Text("保存")
                }
                //                .foregroundColor(Color("main"))
                .disabled(!ValidURL.verifyUrl(urlString: ocwiCalenderUrl))
                .alert(isPresented: $showAlert, content: {
                    Alert(
                        title: Text("保存完了"),
                        dismissButton: .default(
                            Text("ok"),
                            action: {
                                print("way")
                                self.isSheetPresented = false
                            }
                        )
                    )
                })
            }
        }
    }
}

struct UserSettingSheet_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingSheet(isSheetPresented: .constant(true))
    }
}
