//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Vladimir Dvornikov on 01/08/2023.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    
    var body: some View {
        Image(name)
        .cornerRadius(10)
        .shadow(radius: 50)
    }
}


struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(name: "France") 
    }
}
