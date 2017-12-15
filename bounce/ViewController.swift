//
//  ViewController.swift
//  bounce
//
//  Created by eleves on 17-12-08.
//  Copyright © 2017 eleves. All rights reserved.
//
//------------------
import UIKit
//------------------

class ViewController: UIViewController {

//------------------
    @IBOutlet weak var mur_gauche: UIView!
    @IBOutlet weak var mur_droit: UIView!
    @IBOutlet weak var mur_haut: UIView!
    @IBOutlet weak var mur_bas: UIView!
    @IBOutlet weak var balle: UIView!
    
    //--------------------
    
    @IBOutlet weak var cible_cent: UIView!
    @IBOutlet weak var cible_cinquante: UIView!
    @IBOutlet weak var cible_trente: UIView!
    @IBOutlet weak var cible_dix: UIView!
    
    //--------------------
    
    @IBOutlet weak var total_points: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var march_balle: UIView!
    @IBOutlet weak var jouer: UIButton!
    
    //---------------------
    
    var objet_bounce: Targetbounce!
    var cos: Double!
    var sin: Double!
    var aTimer: Timer!
    var acm_points = 0

    
    //--------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       objet_bounce = Targetbounce(ball: balle,
                                    left_window: mur_gauche,
                                    right_window: mur_droit,
                                    top_window: mur_haut,
                                    bottom_window: mur_bas,
                                    target_1: cible_cent,
                                    target_2: cible_cinquante,
                                    target_3: cible_trente,
                                    target_4: cible_dix,
                                    points: points,
                                    total_points: total_points,
                                    move_ball: march_balle,
                                    start_game: jouer)
        balle.layer.cornerRadius = 12.5
        
        balle.center.x = march_balle.center.x
 
        lancerAnimation()
        
    }

    //---------
    
   
    
    
    
    //Method pour lancer la animation
    
    func lancerAnimation() {
  
        acm_points = 0
        total_points.text = "0"
        points.text = "0"
        
        let degres: Double = Double(arc4random_uniform(360))
        cos = __cospi(degres/180)
        sin = __sinpi(degres/180)
        aTimer = Timer.scheduledTimer(timeInterval: 0.003,
                                      target: self,
                                      selector: #selector(animation),
                                      userInfo: nil,
                                      repeats: true)
    
    }
    
    @objc func animation() {
        
        balle.center.x += CGFloat(cos)
        balle.center.y += CGFloat(sin)
        
        if balle.frame.intersects(mur_bas.frame) || balle.frame.intersects(mur_haut.frame) {
            total_points.text = "0"
            points.text = "FIN DE JEU!!!"
            aTimer.invalidate()
            aTimer = nil
        }
        
        if balle.frame.intersects(cible_cent.frame) {
            acm_points = acm_points + 100;
            total_points.text = "\(acm_points)"
            points.text = "100"
        }
        if balle.frame.intersects(cible_cinquante.frame) {
            acm_points = acm_points + 50;
            total_points.text = "\(acm_points)"
            points.text = "50"
        }
        if balle.frame.intersects(cible_trente.frame) {
            acm_points = acm_points + 30;
            total_points.text = "\(acm_points)"
            points.text = "30"
        }
        if balle.frame.intersects(cible_dix.frame) {
            acm_points = acm_points + 10;
            total_points.text = "\(acm_points)"
            points.text = "10"
        }
        
        sin = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
        cos = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch: UITouch = touches.first!
        if touch.view == march_balle{
            march_balle.center.x = touch.location(in: self.view).x
        }
    }

}

