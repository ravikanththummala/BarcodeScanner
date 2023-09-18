//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Ravikanth Thummala on 9/17/23.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
  
    @Binding var scannedCode:String
    @Binding var alertItem:AlertItem?

    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView:self)
    }
    
    
    final class Coordinator: NSObject,ScannerVCDelegate{
        
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFind(barCode: String) {
            self.scannerView.scannedCode = barCode
            print(barCode)
        }
        
        func didSurface(error: CameraError) {
            switch error {
            case .inValidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDevicePut
            case .inValidScannedValue:
                scannerView.alertItem = AlertContext.scannedInvalid
            }
        }
    }
}


#Preview {
    ScannerView(scannedCode: .constant("12345"), alertItem: .constant(.none))
}
