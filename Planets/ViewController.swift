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
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Sun diffuse")
        sun.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)

        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named: "Earth day"), specular: UIImage(named: "Earth Specular"), emission: UIImage(named: "Earth Emission"), normal: UIImage(named: "Earth Normal"), position: SCNVector3(1.2, 0, 0))
        
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: UIImage(named: "Venus Surface"), specular: nil, emission: UIImage(named: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))

        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        let earthParentRotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 14)
        sun.runAction(forever)
        let venusParentRotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 10)
        
        let foreverEarth = SCNAction.repeatForever(earthParentRotation)
        let foreverVenus = SCNAction.repeatForever(venusParentRotation)
        
        earthParent.runAction(foreverEarth)
        venusParent.runAction(foreverVenus)
        
        
        sun.runAction(forever)
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        
    }

    func planet(geometry: SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        
        return planet
    }

}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

