//
//  CrumbList.swift
//  Leftovers
//
//  Created by 109895 on 7.10.2021.
//

import SwiftUI

struct CrumbList: View {
    let dtr = newDataItem()
    @State private var itemList:[Crumb] = [];
    
   
    var body: some View {
        ZStack{
            List(itemList,id : \.id){ item in CrumbRow(crumb: item)
               
                
            }
        VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        newItem()
                       
                    }, label: {
                        Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 77, height: 70)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    })
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
    
    func newItem(){
        
        let dtr = newDataItem()
        self.itemList.append(dtr)
       
    }
}

struct CrumbList_Previews: PreviewProvider {
    static var previews: some View {
        CrumbList()
    }
}
