//
//  LoginView.swift
//  TaKNU-1
//
//  Created by 맥북프로 M1 on 2022/04/29.
//

import SwiftUI
import Firebase 

struct LoginView: View {
    @State private var 이메일 = ""
    @State private var 비밀번호 = ""
    @State private var showing = false
    
    @ObservedObject var viewRouter : ViewRouter
    
    var body: some View {
        // parent container
        VStack {
            
            MainTabView(title1: "안녕하세요!", title2: "TAKNU에 오신것을 환영합니다")
        
            
            VStack(spacing: 40) {
                CustomInputField(imageName: "envelope",
                                 placeholderText: "이메일",
                                 text: $이메일)
                CustomInputField(imageName: "lock",
                                 placeholderText: "비밀번호",
                                 isSecureField: true,
                                 text: $비밀번호)
            }
            .padding(.horizontal, 32)
            .padding(.top, 33)
            HStack {  // bat buoc phai co moi hien
             //  Button {
                   
            }
            Spacer(minLength: 40)
            Button {
                login(email: 이메일, password: 비밀번호)
            } label: {
                Text("TAKNU 로그인")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 300, height: 55)
                .background(Color(red: 255/255, green: 40/255, blue: 1/255))
                .clipShape(Capsule())
                .padding()
            }
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
            .alert("아이디/비밀번호를 확인해주세요", isPresented: $showing) {
                    Button("OK", role: .cancel) { }
                }
            
            Spacer () //chac chan phai co
            
            
            HStack {
                Text("혹시 TAKNU가 처음이신가요?")
                    .font(.footnote)
            
                Button{
                    viewRouter.currentPage = "RegistrationView"
                } label: {
                    Text("회원가입")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    }
                }
            
            .padding(.bottom, 32)
            .foregroundColor(Color(red: 255/255, green: 40/255, blue: 1/255))
        }
    
        .ignoresSafeArea() // căn góc tròn
        .navigationBarHidden(true)
    }
    
    func login(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print("error")
                    showing = true
                } else {
                    print("sucess")
                    self.viewRouter.currentPage = "menuView"
                }
                
            }
        }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewRouter: ViewRouter())
    }
}

