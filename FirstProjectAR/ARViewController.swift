//
//  ARViewController.swift
//  FirstProjectAR
//
//

import UIKit
import ARKit

class ARViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addBox()
        addTapGesture()
        // Do any additional setup after loading the view.
    }

    // World Tracking configuration tracks the device’s orientation and position. It also detects real-world surfaces seen through the device’s camera.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    func addBox() {

        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1)

        let boxNode = SCNNode()
        boxNode.geometry = box
        //boxNode.addAnimation(<#T##animation: SCNAnimationProtocol##SCNAnimationProtocol#>, forKey: <#T##String?#>
        boxNode.position = SCNVector3(0, 0, -0.2)

        let scene = SCNScene()
        scene.rootNode.addChildNode(boxNode)
        sceneView.scene = scene
    }

    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: sceneView)
        let hitTestResults = self.sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else { return }
        node.removeFromParentNode()
       // sceneView.session.pause()
        print("session has paused therefore cube has cleared")
    }
}
