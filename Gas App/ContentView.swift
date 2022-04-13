//
//  ContentView.swift
//  Gas App
//
//  Created by Monrid Rojanavisut on 13/4/2565 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var show = false
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                    Text("")
                }
                .hidden()
                
                Login(show: self.$show)
            }
        }
    }
}

struct Login : View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var visible = false
    @Binding var show : Bool
    
    var body: some View{
        
        ZStack(alignment: .topTrailing) {
            GeometryReader{_ in
                VStack{
                    
                    Text("Log In to your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 35)
                    
                    TextField("Email", text: self.$email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") :
                          self.color,lineWidth: 2))
                        .padding(.top, 25)
                    
                    HStack(spacing: 15){
                        
                        VStack{
                            if self.visible{
                                TextField("Password", text: self.$password)
                            } else{
                                SecureField("Password", text:self.$password)
                            }
                        }
                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") :
                      self.color,lineWidth: 2))
                    .padding(.top, 25)
                    
                    HStack{
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("Forget password")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Color"))
                        }
                    }
                    .padding(.top, 20)
                    
                    Button(action: {
                        
                    }) {
                        Text("Log in")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                }
                .padding(.horizontal, 25)
            }
            Button(action: {
                
                self.show.toggle()
                
            }) {
                Text("Register")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color"))
            }
            .padding()
        }
    }
    
}

struct SignUp : View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    
    var body: some View{
        
        ZStack(alignment: .topLeading) {
            GeometryReader{_ in
                VStack{
                    
                    Text("Log In to your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 35)
                    
                    TextField("Email", text: self.$email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") :
                          self.color,lineWidth: 2))
                        .padding(.top, 25)
                    
                    HStack(spacing: 15){
                        
                        VStack{
                            if self.visible{
                                TextField("Password", text: self.$password)
                            } else{
                                SecureField("Password", text:self.$password)
                            }
                        }
                        Button(action: {
                            self.visible.toggle()
                        }) {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") :
                      self.color,lineWidth: 2))
                    .padding(.top, 25)
                    
                    HStack(spacing: 15){
                        
                        VStack{
                            if self.revisible{
                                TextField("Re-enter", text: self.$repass)
                            } else{
                                SecureField("Re-enter", text:self.$repass)
                            }
                        }
                        Button(action: {
                            self.revisible.toggle()
                        }) {
                            Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(self.color)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Color") :
                      self.color,lineWidth: 2))
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        Text("Register")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color("Color"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                }
                .padding(.horizontal, 25)
            }
            Button(action: {
                
                self.show.toggle()
                
            }) {
                 Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(Color("Color"))
            }
            .padding()
        }
    }
    
}
