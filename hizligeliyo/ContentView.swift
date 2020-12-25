//
//  ContentView.swift
//  hizligeliyo
//
//  Created by Metehan kara on 22.12.2020.
//

import SwiftUI

struct ContentView: View {
    let hueColors = stride(from: 0, to: 1, by: 0.01).map {
        Color(hue: $0, saturation: 1, brightness: 1)
    }
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var authenticationFail: Bool = false
    @State var authenticationSucces: Bool = false
    
    let primaryColor = Color(red:44.0/255.0, green: 156.0/255.0, blue: 219.0/255.0)
    let testEmail = "Test"
    let testPassword = "1234"
    
    var body: some View {
        NavigationView{
            VStack {
                VStack (spacing:10) {
                    LogoImage()
                    LoginText()
                }.padding(.bottom, 30)
                
                ZStack{
                    VStack (spacing: 20) {
                        EmailTF(email: $email)
                        PasswordTF(password: $password)
                        ForgotPasswordText()
                    }
                    .padding(.top,30)
                    
                }
                if authenticationFail {
                    AuthenticationFailErrorText()
                }
             
                VStack {
                    NavigationLink(
                        destination: ProductsView(),
                        isActive: $authenticationSucces){
                        Button(action: {
                            if self.email == testEmail && self.password == testPassword {
                                self.authenticationSucces = true
                                
                                self.authenticationFail = false
                            } else {
                                self.authenticationFail = true
                                self.authenticationSucces = false
                            }
                        }) {
                            LoginButton()
                        }
                        }
                    
                    NoAccountText()
                    RegisterText()
                   
                }.padding(.top,30)
                LinearGradient(gradient: Gradient(colors: hueColors),
                               startPoint: .leading,
                               endPoint: .trailing).frame(width: 350, height: 5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x:0,y:80).zIndex(0.0).padding(.top,60)
            }.padding(30)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoginText: View {
    var body: some View{
        Text("Hesabına Giriş Yap")
            .font(.title2)
            .fontWeight(.medium)
            .padding(.top,10)
        
    }
}

struct LogoImage: View {
    var body: some View {
        Image("hizligeliyo_logo")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .frame(width: 80, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct ForgotPasswordText: View {
    var body: some View {
        Text("Şifremi Unuttum")
            .font(.system(size: 13.0))
            .fontWeight(.light)
            .foregroundColor(.black)
            .frame(width:300, height: 30, alignment: .trailing)
            .multilineTextAlignment(.leading)
    }
}

struct NoAccountText: View {
    var body: some View {
        Text("Hesabın yok mu?")
            .font(.system(size: 13.0))
            .fontWeight(.light)
            .foregroundColor(.black)
            .frame(width:300, height: 30, alignment: .center)
            .multilineTextAlignment(.leading)
    }
}
struct RegisterText: View {
    var body: some View {
        Text("Kaydol")
            .font(.system(size: 13.0))
            .fontWeight(.light)
            .foregroundColor(Color(red:44.0/255.0, green: 156.0/255.0, blue: 219.0/255.0))
            .frame(width:300, height: 30, alignment: .center)
            .multilineTextAlignment(.leading)
    }
}

struct LoginButton: View {
    var body: some View {
        Text("Giriş Yap")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 250, height: 50)
            .background(Color(red:44.0/255.0, green: 156.0/255.0, blue: 219.0/255.0))
            .cornerRadius(30.0)
    }
}

struct EmailTF: View {
    @Binding var email: String
    var body: some View {
        TextField("Email", text: $email)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(30.0)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct PasswordTF: View {
    @Binding var password: String
    var body: some View {
        SecureField("Password", text: $password)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(30.0)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct AuthenticationFailErrorText: View {
    var body: some View {
        Text("Authentication is failed. Try Again!")
            .foregroundColor(.red)
            .font(.system(size: 16.0))
    }
}
