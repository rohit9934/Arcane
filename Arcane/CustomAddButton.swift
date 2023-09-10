//
//  CustomAddButton.swift
//  Arcane
//
//  Created by Rohit Sharma on 29/08/23.
//

import SwiftUI
import PhotosUI
struct CustomAddButton: View {
    @StateObject var photoPickerService = PhotoPickerService()
    var body: some View {
        Button {
            
        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .offset(x: 30)
                                .frame(width: 100,height: 100)

        }
    }
}

struct CustomAddButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomAddButton()
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
