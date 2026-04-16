//
//  SwiftUIView.swift
//  
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("Hello")
            
            Image("infoSymbol", bundle: .module)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .border(.red)
            
            VStack {
                Text("Poppins")
                    .font(.system(size: 20))

                Text("Poppins")
                    .font(.custom("Poppins-Regular", size: 20))
                
                Text("POPPINS test with complete")
                    .font(.custom("Poppins-Regular", size: 40))
                          
                          Text("Poppins test with completeg")
                    .font(.poppinsItalic(size: 14))
                                    
                            
                
            }
            
        } //
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
