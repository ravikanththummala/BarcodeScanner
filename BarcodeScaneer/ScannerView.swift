//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Ravikanth Thummala on 9/17/23.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
  
    
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    
    final class Coordinator: NSObject,ScannerVCDelegate{
        
        func didFind(barCode: String) {
            print(barCode)
        }
        
        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
    }
}


#Preview {
    ScannerView()
}
