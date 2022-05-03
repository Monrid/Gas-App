//
//  ContentView.swift
//  Gas App
//
//  Created by Monrid Rojanavisut on 13/4/2565 BE.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @AppStorage("status") var status:Bool = UserDefaults.standard.bool(forKey: "status")
    @State var show = false
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                if self.status{
                    
                    Homescreen()
                
                }
                else{
                    ZStack{
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                            EmptyView()
                        }
                        Login(show: self.$show)
                    }
                    
                }
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                NotificationCenter.default.addObserver(forName:NSNotification.Name("status"), object: nil, queue: .main) { (_) in }
                
                self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
            }
        }
    }
}

struct Homescreen : View {
    var body: some View{
        
        VStack{
            Text("Logged successfully")
            
            Button(action: {
                
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                
            }) {
                Text("Log out")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color(.green))
            .cornerRadius(10)
            .padding(.top, 25)
        }
    }
}

struct Login : View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var visible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                GeometryReader{_ in
                    VStack{
                        
                        Text("Log In to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color(.green) :
                              self.color,lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                if self.visible{
                                    TextField("Password", text: self.$password)
                                        .autocapitalization(.none)
                                } else{
                                    SecureField("Password", text:self.$password)
                                        .autocapitalization(.none)
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
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color(.green) :
                          self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack{
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.reset()
                                
                            }) {
                                Text("Forget password")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.green))
                            }
                        }
                        .padding(.top, 20)
                        
                        Button(action: {
                            
                            self.verify()
                            
                        }) {
                            Text("Log in")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color(.green))
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
                        .foregroundColor(Color(.green))
                }
                .padding()
            }
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
    
    func verify(){
        
        if self.email != "" && self.password != ""{
            
            Auth.auth().signIn(withEmail: self.email, password: self.password) {
                (res,err) in
                
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"),object: nil)
            }
            
        } else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
            
        }
    }
    
    func reset(){
        
        if self.email != "" {
            
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                
                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                self.error = "RESET"
                self.alert.toggle()
            }
        }else{
            self.error = "Email Id is empty"
            self.alert.toggle()
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
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        
        ZStack{
            
            ZStack(alignment: .topLeading) {
                GeometryReader{_ in
                    VStack{
                        
                        Text("Log In to your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color(.green) :
                              self.color,lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                if self.visible{
                                    TextField("Password", text: self.$password)
                                    .autocapitalization(.none)
                                } else{
                                    SecureField("Password", text:self.$password)
                                    .autocapitalization(.none)
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
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color(.green) :
                          self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            
                            VStack{
                                if self.revisible{
                                    TextField("Re-enter", text: self.$repass)
                                        .autocapitalization(.none)
                                } else{
                                    SecureField("Re-enter", text:self.$repass)
                                        .autocapitalization(.none)
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
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color(.green) :
                          self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        Button(action: {
                            
                            self.register()
                            
                        }) {
                            Text("Register")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color(.green))
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
                        .foregroundColor(Color(.green))
                }
                .padding()
            }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func register() {
        
        if self.email != "" {
            
            if self.password == self.repass{
                
                Auth.auth().createUser(withEmail: self.email, password: self.password) {(res, err) in
                    
                    if err != nil{
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    print("SUCCESS")
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else{
                self.error = "Password not match"
                self.alert.toggle()
            }
        }else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
}

struct ErrorView : View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
    var body: some View {
        
        GeometryReader{_ in
            ZStack(alignment:.center) {
                VStack(alignment: .center){
                    
                    HStack{
                        Text(self.error == "Reset" ? "Message" : "Error")
                            .font(.title)
                            .foregroundColor(self.color)
                        Spacer()
                    }
    //                .padding(.horizontal,UIScreen.main.bounds.width/2)
                    Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    
                    Button(action: {
                        
                        self.alert.toggle()
                        
                    }) {
                        Text(self.error == "RESET" ? "OK" : "Cancle")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    }
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.top, 25)
                }
                .frame(width: UIScreen.main.bounds.width - 70)
                .background(Color.white)
                .cornerRadius(15)
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
            }
//            .padding(.vertical,UIScreen.main.bounds.height/2)
        }
        .background(Color.black.opacity(0.35))
        .edgesIgnoringSafeArea(.all)
    }
}
