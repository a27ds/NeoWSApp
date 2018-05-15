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
    
    var selectedAsteroid : Int = -1
    // MARK: - Outlets

    @IBOutlet weak var sceneView: ARSCNView!
    
    //MARK: - StartUp functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAsteroid()
        addText()
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
    
    func addAsteroid(x: Float = 0, y: Float = 0, z: Float = -2.0) {
        guard let asteriodScene = SCNScene(named: "asteroid.scnassets/asteroid.dae") else { return }
        let asteroidNode = SCNNode()
        let asteroidSceneChildNodes = asteriodScene.rootNode.childNodes
        let asteroidSize : Float = AsteroidBank.listOfAsteroids[selectedAsteroid].sizeTeller()
        
        for childNode in asteroidSceneChildNodes {
            asteroidNode.addChildNode(childNode)
        }
        asteroidNode.position = SCNVector3(x, y, z)
        asteroidNode.scale = SCNVector3(asteroidSize, asteroidSize, asteroidSize)
        
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
    
    func addText(){
        let asteroidSize : Float = AsteroidBank.listOfAsteroids[selectedAsteroid].sizeTeller()
        let asteroidName : String = AsteroidBank.listOfAsteroids[selectedAsteroid].name
        
        let text = SCNText(string: asteroidName, extrusionDepth: 1)
        
        //Create material
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        text.materials = [material]
        
        //Create Node object
        let textNode = SCNNode()
        textNode.scale = SCNVector3(x:0.01, y:0.01, z: 0.01)
        textNode.geometry = text
        textNode.position = SCNVector3(x: 0, y: asteroidSize, z : -1.0)
        
        sceneView.scene.rootNode.addChildNode(textNode)
        
        
        
    }
    
    // MARK: - Buttons

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
