//
//  SliderView.swift
//  SliderAppSwiftUI
//
//  Created by Kuat Bodikov on 27.02.2022.
//

import SwiftUI

struct SliderView: UIViewRepresentable {
    
    @Binding var currentValue: Double
    
    let alpha: Int
    let color: UIColor
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        
        
        slider.minimumValue = 0
        slider.maximumValue = 100
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.changedValue(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.thumbTintColor = color.withAlphaComponent(CGFloat(alpha) / 100)
        uiView.value = Float(currentValue)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(currentValue: $currentValue)
    }
}

extension SliderView {
    class Coordinator: NSObject {
        @Binding var currentValue: Double
        
        init(currentValue: Binding<Double>) {
            self._currentValue = currentValue
        }
        
        @objc func changedValue(_ sender: UISlider) {
            currentValue = Double(sender.value)
        }
    }
}


struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(currentValue: .constant(100), alpha: 100, color: .red)
    }
}
