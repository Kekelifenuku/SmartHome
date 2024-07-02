//
//  ContentView.swift
//  smart home
//
//  Created by Fenuku kekeli on 6/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var smartDevices = [
        (name: "Smart Light", systemIcon: "lightbulb.fill", powerOn: false),
        (name: "Smart AC", systemIcon: "snowflake", powerOn: false),
        (name: "Smart TV", systemIcon: "tv.fill", powerOn: false),
        (name: "Smart Fan", systemIcon: "fan.fill", powerOn: false)
    ]
    
    @State private var currentDate = Date()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Welcome Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Welcome Home, Mr. Keli")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(dateFormatter.string(from: currentDate))
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.trailing, 70)
                // Smart Devices Grid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(smartDevices.indices, id: \.self) { index in
                            SmartDeviceBox(smartDeviceName: smartDevices[index].name,
                                           systemIconName: smartDevices[index].systemIcon,
                                           powerOn: $smartDevices[index].powerOn)
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(16)
                                .shadow(radius: 4)
                        }
                    }
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal, 10)
            }
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
    }
}

struct SmartDeviceBox: View {
    let smartDeviceName: String
    let systemIconName: String
    @Binding var powerOn: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 65)
                .foregroundColor(powerOn ? Color.green : Color.gray)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(powerOn ? Color.green.opacity(0.2) : Color.gray.opacity(0.1)))
            
            Text(smartDeviceName)
                .fontWeight(.semibold)
                .font(.system(size: 18))
                .foregroundColor(Color.black) // Always black text color
                
            Toggle(isOn: $powerOn, label: {
                Text(powerOn ? "On" : "Off")
                    .foregroundColor(powerOn ? Color.green : Color.gray)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 12).stroke(powerOn ? Color.green : Color.gray, lineWidth: 2))
            })
            .labelsHidden()
            .toggleStyle(SwitchToggleStyle(tint: .green))
            .rotationEffect(.degrees(90))
        }
        .padding(15)
        .background(RoundedRectangle(cornerRadius: 24).fill(Color.white))
        .shadow(radius: 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
