//
//  ARViewController.swift
//  NeoWSApp
//
//  Created by a27 on 2018-05-09.
//  Copyright © 2018 a27. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    // MARK: - Outlets

    @IBOutlet weak var sceneView: ARSCNView!
    
    //MARK: - StartUp functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAsteroid()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - Add asteroid into AR scene
    
    func addAsteroid(x: Float = 0, y: Float = 0, z: Float = -0.5) {
        guard let asteriodScene = SCNScene(named: "asteroid.scnassets/asteroid.dae") else { return }
        let asteroidNode = SCNNode()
        let asteroidSceneChildNodes = asteriodScene.rootNode.childNodes
        
        for childNode in asteroidSceneChildNodes {
            asteroidNode.addChildNode(childNode)
        }
        asteroidNode.position = SCNVector3(x, y, z)
        asteroidNode.scale = SCNVector3(0.1, 0.1, 0.1)
        
        sceneView.scene.rootNode.addChildNode(asteroidNode)
        
        //Make it spin!!!
        
        let x = Float(arc4random_uniform(10))
        let y = Float(arc4random_uniform(10))
        let z = Float(arc4random_uniform(10))
        
        print(x)
        print(y)
        print(z)
        
        let action = SCNAction.repeatForever(SCNAction.rotate(by: .pi, around: SCNVector3(x, y, z), duration: 10))
        asteroidNode.runAction(action)
        
    }
    
    // MARK: - Buttons

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
