//
//  ContentView.swift
//  Knob
//
//  Created by Chris Eidhof on 05.11.19.
//  Copyright © 2019 Chris Eidhof. All rights reserved.
//

import SwiftUI

struct ColorKey: EnvironmentKey {
    static var defaultValue: Color? = nil
}

extension EnvironmentValues {
    var knobColor: Color? {
        get { self[ColorKey.self] }
        set { self[ColorKey.self] = newValue }
    }
}

struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.1 // these are relative values
    var pointerWidth: CGFloat = 0.1
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}

extension View {
    
    func knobColor(color: Color?) -> some View {
        environment(\.knobColor, color)
    }
    
}

struct Knob: View {
    @Binding var value: Double // should be between 0 and 1
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.knobColor) var ecolor
    @Binding var colorHue: CGFloat
    
    var body: some View {
         KnobShape()
            .fill(ecolor ?? (colorScheme == .dark ? Color.white : Color.black))
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                withAnimation(.default) {
                    self.value = self.value < 0.5 ? 1 : 0
                }
            }
    }
}

struct ContentView: View {
    @State var value: Double = 0.5
    @State var knobSize: CGFloat = 0.1
    @State var knobColorHue: CGFloat = 0.5
    
    var body: some View {
        VStack {
            Knob(value: $value, colorHue: $knobColorHue)
                .frame(width: 100, height: 100)
            HStack {
                Text("Value")
                Slider(value: $value, in: 0...1)
            }
            HStack {
                Text("Knob Size")
                Slider(value: $knobSize, in: 0...0.4)
            }
            HStack {
                Text("Knob Color")
                Slider(value: $knobColorHue, in: 0...1)
            }
            
            Button(action: {
                withAnimation(.default) {
                    self.value = self.value == 0 ? 1 : 0
                }
            }, label: { Text("Toggle")})
            
        }.knobColor(color: Color(red: Double(knobColorHue), green: 0.3, blue: 0.4))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
