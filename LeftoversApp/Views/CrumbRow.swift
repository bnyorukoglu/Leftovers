//
//  SwiftUIView.swift
//  Leftovers
//
//  Created by 109895 on 7.10.2021.
//

import SwiftUI

struct CrumbRow: View {
    
    var crumb : Crumb
    var colors:[Color] = [Color.red.opacity(0.3),Color.red.opacity(0.6),Color.red]
    
    let noteSize = getAdjustedWidth();
    var body: some View {
        
        
        HStack{
            Circle().fill(colors[crumb.priority]).frame(width: noteSize, height: noteSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(crumb.title).padding(.leading,5)
        }
        
    }
    
    // We should calculate thiss
    static func getAdjustedWidth()->CGFloat{
        
        return 24;
    }
        
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CrumbRow(crumb: randomCrumbs[0])
    }
}
