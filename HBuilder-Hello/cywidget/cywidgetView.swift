//
//  cywidgetView.swift
//  HBuilder
//
//  Created by Master Luke on 2020/10/10.
//  Copyright © 2020 DCloud. All rights reserved.
//

import SwiftUI

struct cywidgetView: View {
    var body: some View {
        VStack() {
            GeometryReader { geo in
                VStack() {
                    HStack() {
                        VStack(alignment: .leading) {
                            Text("上课时间 19:00")
                                .foregroundColor(.gray)
                                .font(.body)
                            Text("媒介评价")
                                .foregroundColor(.white)
                                .font(.title)
                                .padding(/*@START_MENU_TOKEN@*/.all, 0.0/*@END_MENU_TOKEN@*/)
                                .border(Color.red)
                                
                            HStack(alignment: .center) {
                                Image("position")
                                    .resizable()
                                    //.frame(width: 14.0, height: 14.0)
                                    .scaledToFit()
                                    .border(Color.green)
                                
                                Text("天山堂A603")
                                    .foregroundColor(.gray)
                                    .font(.headline)
                            }
                            .padding(/*@START_MENU_TOKEN@*/.all, 0.0/*@END_MENU_TOKEN@*/)
                            .border(Color.red)
                        }
                        .frame(width: 1.0 * geo.size.width)
                        .border(Color.white)
                        
                        //Spacer()
                    }
                    //.border(Color.white)
                    
                    Spacer()
                    
                    HStack() {
                        Spacer()
                        
                        Text("今日无更多课程")
                            .foregroundColor(.gray)
                            .font(.body)
                    }
                    //.border(Color.white)
                }
                //.border(Color.red)
                .padding(.top)
                .padding(.bottom)
            }
            .padding(.horizontal)
            //.border(Color.green)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    //        GeometryReade { geo in
    //            VStack {
    //                Text(contentOne)
    //            }
    //            .background(Color.black)
    //            .frame(width: geo.size.width, height: geo.size.height)
    //        }
    //        VStack {
    //            Text(contentOne)
    //        }
    //        .background(Color.black)
    //        //.ignoresSafeArea(.all)
    //        .border(Color.red)
    //        .frame(width: .infinity, minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
}
struct cywidgetViewPreviews: PreviewProvider {
    static var previews: some View {
        cywidgetView()
    }
}
