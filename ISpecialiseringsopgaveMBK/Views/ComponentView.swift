//
//  ComponentView.swift
//  ISpecialiseringsopgaveMBK
//
//  Created by Martin Kock on 16/05/2023.
//

import SwiftUI

struct ComponentView: View {
    @EnvironmentObject var stateController: StateController
    
    var mag: Double
    var time: String
    var place: String
    var id: String
    var body: some View {
           
                ZStack {
                    Rectangle()
                        .cornerRadius(8)
                        .shadow(radius: 3)
                        .foregroundColor(Color.yellow)
                        .frame(width: 340, height: 100)
                    
                    HStack(alignment: .top) {
                        VStack {
                        
                            
                            
                            if mag >= 0 {
                                Image(systemName: "globe.europe.africa")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                            } else {
                                Image(systemName: "globe.europe.africa")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .offset(x: 5)
                            }
                              
                        }
                        
                        VStack(alignment: .leading) {
                            if mag >= 0 {
                                Text(String(format: "%.2f", mag))
                                    .font(.title)
                                    .offset(y:10)
                            } else {
                                Text(String(format: "%.2f", mag))
                                    .font(.title)
                                    .offset(x: 5,y:10)
                            }
                            
                        }
                        
                        VStack(alignment: .leading) {
                            Text(time.description)
                            
                            Text(place)
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.headline)
                                .dynamicTypeSize(.small)
                        }
                        .frame(width: 190,alignment: .leading)
                       // .offset(x: 10)
                        
                     
                    }
                    HStack {
                        if (stateController.favorites.first(where: {$0.id == id}) != nil) {
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                
                                .offset(x: 155, y: -35)
                                
                        }
                    }
                   


                }
            }
        }


struct ComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentView(mag: -0.2, time: "tir. 16 maj 2023 14:30", place: "4km NW of Palomar Observatory, CA", id: "1").environmentObject(StateController())
    }

}
