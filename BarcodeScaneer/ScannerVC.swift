//
//  File.swift
//  BarcodeScaneer
//
//  Created by Ravikanth Thummala on 9/17/23.
//

import Foundation
import AVFoundation
import UIKit

enum CameraError: String {
    case inValidDeviceInput = "Something is wrong with the camera. We are unable to capture the input."
    case inValidScannedValue = "The value scanned is not valid. This app scans EAN-8 and EAN-13"
}
protocol ScannerVCDelegate {
    func didFind(barCode:String)
    func didSurface(error: CameraError)
}

final class ScannerVC: UIViewController{
    
    let captureSession = AVCaptureSession()
    var previewLayer:AVCaptureVideoPreviewLayer?
    var scannerDelegate:ScannerVCDelegate
    
    init(scannerDelegate: ScannerVCDelegate) {
        self.scannerDelegate = scannerDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let previewLayer = previewLayer else {
            scannerDelegate.didSurface(error: .inValidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession(){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate.didSurface(error: .inValidDeviceInput)
            return
        }
        let videoInput:AVCaptureDeviceInput
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch{
            scannerDelegate.didSurface(error: .inValidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        }else{
            scannerDelegate.didSurface(error: .inValidDeviceInput)
            return
        }
        let metaDataOutPut = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metaDataOutPut){
            captureSession.addOutput(metaDataOutPut)
            metaDataOutPut.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutPut.metadataObjectTypes = [.ean8,.ean13]
        }else {
            scannerDelegate.didSurface(error: .inValidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
}

extension ScannerVC : AVCaptureMetadataOutputObjectsDelegate{
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        guard let object = metadataObjects.first else {
            scannerDelegate.didSurface(error: .inValidScannedValue)
            return
        }
        
        guard let machineReadableObject = object as?  AVMetadataMachineReadableCodeObject else {
            scannerDelegate.didSurface(error: .inValidScannedValue)
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate.didSurface(error: .inValidScannedValue)
            return
        }
        
        scannerDelegate.didFind(barCode: barcode)
        
    }
    
}
