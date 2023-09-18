//
//  BarCodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Ravikanth Thummala on 9/17/23.
//

import SwiftUI

final class BarCodeScannerViewModel: ObservableObject{
    
    @Published  var scannedCode = ""
    @Published  var alertItem:AlertItem?
    
    var statusText: String {
        scannedCode.isEmpty ? "Not yet Scanned" : scannedCode
    }
    
    var statusTextColor: Color {
        scannedCode.isEmpty ? .red : .green
    }
    

    
    
    

}
