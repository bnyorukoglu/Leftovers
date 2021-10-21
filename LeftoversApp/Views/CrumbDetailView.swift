//
//  CrumbDetailView.swift
//  LeftoversApp
//
//  Created by 109895 on 13.10.2021.
//

import SwiftUI
import CoreData
import Combine

enum  CrumbDetailStatus{
    case Edit,Add,View
}

struct CrumbDetailView: View {
    
    private var objectId:NSManagedObjectID?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var  crumbViewModel:CrumbViewModel;
    @ObservedObject  private var crumbModel:CrumbX = CrumbX();
    @ObservedObject var notificationManager = LocalNotificationManager()
    
    @State  var  crump:Crumb?
    @State var priority:Int? = 0
    var dateFormatter = DateFormatter();
    
    init(param:NSManagedObjectID?) {
        self.objectId = param;
        dateFormatter.dateStyle = .medium;
        dateFormatter.timeStyle = .short;
        UITextView.appearance().backgroundColor = .clear
        
        
    }
    
    func reflectChanges(){
        
        if(crump == nil){
            crump = Crumb(context: crumbViewModel.getContext());
        }
        
    }
    
    
    
    var body: some View {
        
        ZStack{
            VStack{
                
                Text(dateFormatter.string(from: $crumbModel.createDate.wrappedValue)).foregroundColor(Color.orange.opacity(0.7)).font(.caption)
                
                TextField("Title",text: $crumbModel.title).placeholder(when:  crumbModel.title.isEmpty) {
                    Text("Title").foregroundColor(.gray)
                }.onChange(of: crumbModel.title, perform: { value in
                    reflectChanges()
                    crumbModel.toCrumb(crumb: crump!)
                    
                }).foregroundColor(Color.white.opacity(1)).font(Font.title.weight(.bold)).padding(10)
                Divider().foregroundColor(Color.black)
                HStack{
                    DatePicker("Due", selection: $crumbModel.due).accentColor(Color.orange.opacity(1)).font(Font.headline.weight(Font.Weight.bold)).foregroundColor(.orange)
                    
                    PriorityPicker(selectedIndex: $priority).onChange(of: priority, perform: { value in
                        reflectChanges()
                        crumbModel.priority = priority!
                        crumbModel.toCrumb(crumb: crump!)
                    })
                }.overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white,lineWidth: 3))
                
                
                Divider().foregroundColor(Color.black)
                
                TextEditor(text:  $crumbModel.content).onChange(of: crumbModel.content, perform: { value in
                    reflectChanges()
                    crumbModel.toCrumb(crumb: crump!)
                    
                }).textFieldStyle(RoundedBorderTextFieldStyle.init()).foregroundColor(Color.white.opacity(0.95)).font(Font.body.weight(Font.Weight.regular)).lineSpacing(12)
            }.onAppear(perform: {
                do {
                    if objectId == nil{
                        
                        priority = crumbModel.priority;
                    }
                    else{
                        crump = try crumbViewModel.getCrumbById(id: objectId!).crumb
                        
                        crumbModel.fromCrumb(crumb:crump!);
                        priority = crumbModel.priority;
                    }
                } catch  {
                    
                }
                
                
                
                
            }).background(Image("bckgrndimg")).padding(EdgeInsets.init(top: -10, leading: 20, bottom: 10, trailing: 20))
            Spacer();
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    
                    
                    Button(action: {
                        
                        if(crumbViewModel.isDirty){
                            notificationManager.sendNotification(title: "To-Do", subtitle: crumbModel.title, body: crumbModel.content, launchIn: crumbModel.due)
                            reflectChanges()
                            crumbModel.priority = priority!
                            crumbModel.toCrumb(crumb: crump!)

                            crumbViewModel.saveChanges();
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "gobackward").padding()
                    }
                    .font(.system(.largeTitle))
                    .frame(width: 77, height: 70)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 7)
                    
                    .background(Color.pink)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                    
                    
                }
            }
        }
    }
    
}




struct CrumbDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        Text("Submission var")
        // CrumbDetailView( crumbModel:  CrumbModel())
    }
    
}
