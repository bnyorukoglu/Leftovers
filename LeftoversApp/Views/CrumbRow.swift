//
//  SwiftUIView.swift
//  Leftovers
//
//  Created by 109895 on 7.10.2021.
//

import SwiftUI


struct CrumbRow: View {
    
    var crumb : CrumbModel?
    var colors:[Color] = PriorityPickerModel.defaultModel().Decoration
    
    let noteSize = getAdjustedWidth();
    var body: some View {
        

        HStack{
            Circle().fill(colors[Int(crumb!.Priority)]).frame(width: noteSize, height: noteSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(crumb!.Title).padding(.leading,5)
           
            
        }
        
        }
    
    // We should calculate thiss
    static func getAdjustedWidth()->CGFloat{
        
        return 24;
    }
        
}
