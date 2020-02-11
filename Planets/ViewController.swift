//
//  ViewController.swift
//  Planets
//
//  Created by Damian Jahn on 11/02/2020.
//  Copyright © 2020 Damian Jahn. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.automaticallyUpdatesLighting = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let earth = SCNNode()
        earth.geometry = SCNSphere(radius: 0.2)
        earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Earth day")
        earth.geometry?.firstMaterial?.specular.contents = UIImage(named: "Earth Specular")
        earth.geometry?.firstMaterial?.emission.contents = UIImage(named: "Earth Emission")
        earth.geometry?.firstMaterial?.normal.contents = UIImage(named: "Earth Normal")
        earth.position = SCNVector3(0,0, -1)
        self.sceneView.scene.rootNode.addChildNode(earth)
        
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        earth.runAction(forever)
    }


}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

