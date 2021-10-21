//
//  PriorityPicker.swift
//  LeftoversApp
//
//  Created by 109895 on 14.10.2021.
//

import SwiftUI

class NameValuePair{
    private var n:String
    private var v:Int
    
    var Name:String{
        get{return self.n}
        set{self.n = newValue}
    }
    var Value:Int{
        get{return self.v}
        set{self.v = newValue}
    }
    init(name:String,value:Int) {
        self.n = name
        self.v  = value;
    }
}
class PriorityPickerModel{
    private var choices:[NameValuePair] = []
    private var decoration:[Color] = [];
    
    var Choices:[NameValuePair]{
        return self.choices;
    }
    var Decoration:[Color]{
        return self.decoration;
    }
    
    static func defaultModel()->PriorityPickerModel{
        
        let priorityPickerModel = PriorityPickerModel();
        priorityPickerModel.choices = [NameValuePair(name:"Relax",value: 0),NameValuePair(name: "Normal",value: 1),NameValuePair(name: "Urgent",value: 2)]
        priorityPickerModel.decoration = [Color.green,Color.yellow,Color.red]
        return priorityPickerModel;
    }
    
    
}

struct PriorityPicker: View {
    
    @State private var priorityPickerModel:PriorityPickerModel = PriorityPickerModel.defaultModel();
    @State private var iconImages = [Image.init("highpri"),Image.init("medpri"),Image.init("lowpri")]
    @State private var isediting:Bool = false;
    @Binding  var selectedIndex:Int?;
    
    
    
    var body: some View {
        HStack{
            Spacer()
             
            
            if isediting{
                
                  ForEach(priorityPickerModel.Choices,id : \.Value){ nmp in
                        Circle().fill(priorityPickerModel.Decoration[nmp.Value]).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).shadow(color:.gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/).animation(.easeIn, value: true).transformEffect(.init(translationX: CGFloat(-15*calculateAnimDistances(indice: nmp.Value)), y: 0)).onTapGesture(perform: {
                            selectedIndex = nmp.Value
                            onStateChanging()
                    
                        })
                            
                      
                  }
                  
                 
            }
            else{
                Text("Priority").foregroundColor(Color.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Rectangle().frame(width: 2, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(Color.white)
                
                Circle().fill(priorityPickerModel.Decoration[selectedIndex ?? 0]).frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).shadow(color:.gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/).onTapGesture(perform: {
                    withAnimation(.linear(duration:0.3)){
                        self.onStateChanging()
                       
                    }
                    
                })
            }
            Spacer()
            
        }
        
    }
    func onStateChanging(){
        
        isediting.toggle();
        
    }
    func calculateAnimDistances(indice:Int)->Int{
        
        return priorityPickerModel.Choices.count/2 - indice
    }
}

