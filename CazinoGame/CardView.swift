//
//  CardView.swift
//  CazinoGame
//
//  Created by Ruslan Ishmukhametov on 08.11.2021.
//

import SwiftUI

struct CardView: View {
    
    @Binding var symvol: String
    @Binding var background: Color
    
    var body: some View {
        
        Image(symvol)
            .resizable()
            .frame(width: 120, height: 120)
            .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .background(background.opacity(0.5))
            .cornerRadius(20)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symvol: Binding.constant("finn"), background: Binding.constant(Color.green))
    }
}
