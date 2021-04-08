//
//  cywidgetView.swift
//  HBuilder
//
//  Created by Master Luke on 2020/10/10.
//  Copyright © 2020 DCloud. All rights reserved.
//

import SwiftUI

struct cywidgetView: View {
    var first_event = "原子物理学"
    var first_event_description = "天山堂A101"
    var second_event = "量子力学"
    var second_event_description = "天山堂A404"
    var body: some View {
        HStack(){
            VStack(alignment: .leading) {
                GeometryReader { geometry in
                    HStack(){
    //                    Rectangle()
    //                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.gray/*@END_MENU_TOKEN@*/).frame(width: 2.0, height: geometry.size.height * 0.5)
                        Capsule()
                            .frame(width: 2.0)
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)

                            VStack(){
                                Text(first_event)
                                Text(first_event_description)
                                    .foregroundColor(Color.gray)
                            }
                        
                    }
                }
                .padding([.top, .leading])
                
                GeometryReader { geometry in
                    HStack(){
                        Rectangle()
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/).frame(width: 2.0, height: geometry.size.height * 0.5)
                        
                        VStack(){
                            Text(first_event)
                            Text(first_event_description)
                        }
                        
                    }
                }
                .padding([.top, .leading])
                
            }
            Button.init("Test"){
                print("press test button")
            }
            .padding()
            .background(Color.orange)
            .shadow(radius: 10)
        }
        
        
            
    }
}
struct cywidgetView_Previews: PreviewProvider {
    static var previews: some View {
        cywidgetView()
    }
}
