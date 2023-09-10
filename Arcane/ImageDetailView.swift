//
//  ImageDetailView.swift
//  Arcane
//
//  Created by Rohit Sharma on 28/08/23.
//

import SwiftUI
import UIKit
struct ImageDetailView: View {
    var imageDetail = UIImage()
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Button {
                dismiss()
            } label: {
                    Image(uiImage: imageDetail)
                        .resizable()
                        .scaledToFit()
                
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.black)
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView()
    }
}
