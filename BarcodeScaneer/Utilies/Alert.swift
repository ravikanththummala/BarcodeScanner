//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Ravikanth Thummala on 9/17/23.
//

import SwiftUI

struct AlertContext {
    static let invalidDevicePut = AlertItem(title: "In ValidInput", message: "Something is wrong with the camera. We are unable to capture the input.", dismisButton: .default(Text("Ok")))
                                            
   static let scannedInvalid = AlertItem(title: "Scanned Invalid", message: "The value scanned is not valid. This app scans EAN-8 and EAN-13", dismisButton: .default(Text("Ok")))

}
