//
//  BarcodeReaderViewController.swift
//  Outhouse
//
//  Created by Derek May on 8/21/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    var passedInEventId:String!

    @IBOutlet weak var backLightSwitch: UISwitch!
    
    @IBOutlet weak var overlayButtonView: UIView!
    var layerWithLightButton: CALayer {
        return overlayButtonView.layer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PASSED IN to barcodeReader", passedInEventId)
        backLightSwitch.addTarget(self, action: #selector(stateChanged(switchState:)), for: UIControlEvents.valueChanged)

        // Create a session object.
        session = AVCaptureSession()
        
        // Set the captureDevice.
        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        // Create input object.
        let videoInput: AVCaptureDeviceInput?
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        // Add input to the session.
        if (session.canAddInput(videoInput)) {
            session.addInput(videoInput)
        } else {
            scanningNotPossible()
        }
        
        // Create output object.
        let metadataOutput = AVCaptureMetadataOutput()
        
        // Add output to the session.
        if (session.canAddOutput(metadataOutput)) {
            session.addOutput(metadataOutput)
            
            // Send captured data to the delegate object via a serial queue.
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            // Set barcode type for which to scan: EAN-13.
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeCode128Code]
            
        } else {
            scanningNotPossible()
        }
        
        // Add previewLayer and have it show the video data.
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        view.layer.addSublayer(previewLayer)
        layerWithLightButton.cornerRadius = 8.0
        view.layer.addSublayer(layerWithLightButton)
    
        // Begin the capture session.
        
        session.startRunning()
        if LED_BACK_LIGHT_SETTING == true {
            if !backLightSwitch.isOn {
                backLightSwitch.setOn(true, animated:false)
            }
            toggleLed(value: LED_BACK_LIGHT_SETTING)
        }
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.isOn {
            toggleLed(value: true)
        } else {
            toggleLed(value: false)
        }
    }
    
    func toggleLed(value: Bool) {
        let avDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        // check if the device has torch
        if  (avDevice?.hasTorch)! {
            // lock your device for configuration
            do {
                try avDevice?.lockForConfiguration()
            } catch {
                return
            }
            // check if your torchMode is on or off. If on turns it off otherwise turns it on
            // avDevice?.torchMode = (avDevice?.isTorchActive)! ? AVCaptureTorchMode.off : AVCaptureTorchMode.on
            if value {
                // print("The Switch is On")
                LED_BACK_LIGHT_SETTING = true
                if !(avDevice?.isTorchActive)! {
                    avDevice?.torchMode = AVCaptureTorchMode.on
                    // sets the torch intensity to 100%
                    do {
                        try avDevice?.setTorchModeOnWithLevel(0.01)
                    } catch {
                        return
                    }
                }
            } else {
                // print("The Switch is Off")
                LED_BACK_LIGHT_SETTING = false
                avDevice?.torchMode = AVCaptureTorchMode.off
            }
            // unlock your device
            avDevice?.unlockForConfiguration()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Platform.isSimulator {
            print("Running on Simulator")
            print(1, TEST_TICKET_CODE)
            barcodeDetected(TEST_TICKET_CODE)
            //session.stopRunning()
        } else {
            if (session?.isRunning == false) {
                session.startRunning()
            }

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (session?.isRunning == true) {
            session.stopRunning()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func scanningNotPossible() {
        // Let the user know that scanning isn't possible with the current device.
        let alert = UIAlertController(title: "Can't Scan.", message: "Let's try a device equipped with a camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        session = nil
    }

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        print("in captureOutput")
        session.stopRunning()
        print("after stopRunning")
        // Get the first object from the metadataObjects array.
        if let barcodeData = metadataObjects.first {
            // Turn it into machine readable code
            let barcodeReadable = barcodeData as? AVMetadataMachineReadableCodeObject;
            if let readableCode = barcodeReadable {
                // Send the barcode as a string to barcodeDetected()
                barcodeDetected(readableCode.stringValue);
            }
            
            // Vibrate the device to give the user some feedback.
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        }
    }

    func runAfterDelay(_ delay: TimeInterval, block: @escaping ()->()) {
        let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: block)
    }

    func barcodeDetected(_ code: String) {
        let trimmedCode = code.trimmingCharacters(in: CharacterSet.whitespaces)
        print("in barcodeDetected")
        print(2, code)

        let trimmedCodeString = "\(trimmedCode)"
        DataService.processTicketCode(passedInEventId, codeNumber: trimmedCodeString)

        runAfterDelay(0.5) {
            DataService.getScannedTicketCountForEvent(self.passedInEventId)
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
    

}

