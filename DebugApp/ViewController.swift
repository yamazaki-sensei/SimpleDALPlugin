//
//  ViewController.swift
//  DALPluginDebugApp
//
//  Created by Hiraku Ohno on 2020/05/09.
//  Copyright © 2020 embodyme. All rights reserved.
//

import AVFoundation
import Cocoa
import VideoToolbox

class ViewController: NSViewController {

    private var captureSession: AVCaptureSession!
    private var captureInput: AVCaptureDeviceInput!
    private var captureDevice: AVCaptureDevice!
    private var captureConnection: AVCaptureConnection!
    private var previewLayer: AVCaptureVideoPreviewLayer!

    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        startCameraCapture()
    }

    override func viewDidLayout() {
        super.viewDidLayout()
    }
    

    private func startCameraCapture() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.low

        let devices: [AVCaptureDevice]

        if #available(OSX 10.15, *) {
            let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.externalUnknown], mediaType: .video, position: .unspecified)
            devices = discoverySession.devices
        } else {
            devices = AVCaptureDevice.devices(for: .video)
        }
        captureDevice = devices.first!

        // video input
        captureInput = try? AVCaptureDeviceInput(device: captureDevice)
        guard captureSession.canAddInput(captureInput) else { return }
        captureSession.addInputWithNoConnections(captureInput)

        // video output
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)

        captureSession.startRunning()
        view.wantsLayer = true
        view.layer = previewLayer
    }
}
