//
//  ContentView.swift
//  Arcane
//
//  Created by Rohit Sharma on 28/08/23.
//

import SwiftUI
import UIKit
import CoreData
import _PhotosUI_SwiftUI


/// I need to make
struct ContentView: View {
    let gridItems = [GridItem(.flexible(), spacing: -10), GridItem(.flexible(), spacing: -10)]
    @StateObject var photoPickerService = PhotoPickerService()
    @State var imageData: [UIImage] = []
 //   let image = Image(uiImage: ImageStorageService.retrieveImageFromUserDefauts(forKey: "image")!)
      var body: some View {
          NavigationView {
              ZStack {
                  ScrollView {
                      LazyVGrid(columns: gridItems, spacing: 20) {
                          ForEach(imageData, id: \.self){ item in
                              NavigationLink {
                                  ImageDetailView(imageDetail: item)
                              } label: {
                                  Image(uiImage: item)
                                      .resizable()
                                      .cornerRadius(20)
                                      .frame(width: 175,height: 175)
                              }
                          }
                      }
                  }
                  .toolbar {
                      ToolbarItem(placement: .navigationBarTrailing) {
                          PhotosPicker(selection: $photoPickerService.imageSelection) {
                              Menu {
                                  
                              } label: {
                                  CustomAddButton()
                              }
                          }
                         
                      }
                  }
              }.onAppear {
                  let imagesManager = ImagesManager()
                  self.imageData = imagesManager.fetchImages()
              }
              .frame(maxWidth: .infinity,maxHeight: .infinity)
           .background(.black)
              .navigationTitle("Images")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                                          Color.black,
                                          for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
          }
          
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
