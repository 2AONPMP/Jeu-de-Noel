//
//  ViewController.swift
//  bounce
//
//  Created by eleves on 17-12-08.
//  Copyright © 2017 eleves. All rights reserved.
//
//--- Biblioteques du Xcode utilisées dans le code
//------------------
import UIKit
import Foundation
import AVFoundation
//------------------

//---Class CreatorController pour contrôler la vues dans le code
//------------------
class ViewController: UIViewController {
//------------------

    //--- Chaque mur est une vue, les murs empêchent la continuité de la balle et l'envoient à la secte opposée. Les murs forment avec une view
    //------------------
    @IBOutlet weak var mur_gauche: UIView!
    @IBOutlet weak var mur_droit: UIView!
    @IBOutlet weak var mur_haut: UIView!
    @IBOutlet weak var mur_bas: UIView!
    @IBOutlet weak var balle: UIView!
 
    //--- Chaque cible est une vue, les cible empêchent la continuité de la balle et fait la ponctuation
    //--------------------
    @IBOutlet weak var cible_cent: UIView!
    @IBOutlet weak var cible_cinquante: UIView!
    @IBOutlet weak var cible_trente: UIView!
    @IBOutlet weak var cible_dix: UIView!
    
    // Declation des variables pour contrôler les points de le jeu et le jeu/recommencer
    //--------------------
    @IBOutlet weak var total_points: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var march_balle: UIView!
    @IBOutlet weak var jouer: UIButton!
    
    // Declation des variables pour contrôler le balle, la trajectoire, temps et points.
    //---------------------
    var objet_bounce: Targetbounce!
    var cos: Double!
    var sin: Double!
    var aTimer: Timer!
    var acm_points = 0
    
    // Music de noel pour le jeu
    // ---------------------
    var mus_jeu = AVAudioPlayer()
    var aniMusicTimer: Timer!
    //----------------------
    

    //--- Section viewDidLoad pour initialisation supplémentaire sur les vues qui ont été chargées, appelle aussi la class Targetbounce
    //----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //--- Appelle la fonction du temp et player de la music de le jeu
        loadSounds()
        player()
        
       //--- Appelle la class TargetBounce
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
      
     
        //---Faire la vue de a balle rond
        balle.layer.cornerRadius = 12.5
        
        //--- Position de la balle pour commencer
        balle.center.x = march_balle.center.x
 
        // Appelle la fonction LancerAnimation jusqu'à la fin du jeu
        lancerAnimation()
        
    }

    //Méthode pour lancer la animation
    //----------------------
    func lancerAnimation() {
  
        // Initialisation de points avec "0" quand le jeu commence
        acm_points = 0
        total_points.text = "0"
        points.text = "0"
        
        // La calcule de la trajectoire pour la balle, qui aura une motivation de 360 degrés et aura son sens changé dans les axes cosinus et sinus, avec un velocité de 0.003 seconds.
        //----------------------
        let degres: Double = Double(arc4random_uniform(360))
        cos = __cospi(degres/180)
        sin = __sinpi(degres/180)
        aTimer = Timer.scheduledTimer(timeInterval: 0.003,
                                      target: self,
                                      selector: #selector(animation),
                                      userInfo: nil,
                                      repeats: true)
    
    }
    
    ///--- Fonction pour la Animation de la balle
    //--------------------
    @objc func animation() {
        
        //--- Position de la balle
        //----------------------
        balle.center.x += CGFloat(cos)
        balle.center.y += CGFloat(sin)
        
        // Fonction returnCosSinAfterTouch dans la classe targetBounce pour calculer la nouvelle trajectoire pour la balle
        sin = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
        cos = objet_bounce.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
        
        //--- Si la balle touche les vues d' en haute ou de bas, le jeu se termine
        //----------------------
        if balle.frame.intersects(mur_bas.frame) || balle.frame.intersects(mur_haut.frame) {
            total_points.text = "0"
            points.text = "FIN DE JEU!!!"
            aTimer.invalidate(); aTimer = nil
            mus_jeu.stop()
            aniMusicTimer.invalidate(); aniMusicTimer = nil
        }
        
        //--- Si la balle touche le cible avec nombre 100, le joueur fait 100 points
        //----------------------
        if balle.frame.intersects(cible_cent.frame) {
            acm_points = acm_points + 100;
            total_points.text = "\(acm_points)"
            points.text = "100"
        }
        
        //--- Si la balle touche le cible avec nombre 50, le joueur fait 50 points
        //----------------------
        if balle.frame.intersects(cible_cinquante.frame) {
            acm_points = acm_points + 50;
            total_points.text = "\(acm_points)"
            points.text = "50"
        }
        
        //--- Si la balle touche le cible avec nombre 30, le joueur fait 30 points
        //----------------------
        if balle.frame.intersects(cible_trente.frame) {
            acm_points = acm_points + 30;
            total_points.text = "\(acm_points)"
            points.text = "30"
        }
        
        //--- Si la balle touche le cible avec nombre 10, le joueur fait 10 points
        //----------------------
        if balle.frame.intersects(cible_dix.frame) {
            acm_points = acm_points + 10;
            total_points.text = "\(acm_points)"
            points.text = "10"
        }
        
     
    }
    
    //--- Fonctions  pour la musique de jeu
    func loadSounds()
    {
        do
        {
           mus_jeu = try AVAudioPlayer(contentsOf: .init(fileURLWithPath: Bundle.main.path(forResource: "jingle", ofType: "mp3")!))
          mus_jeu.prepareToPlay()
        }
        catch{ print(error) }
    }
    
    func player()
    {
        aniMusicTimer = Timer.scheduledTimer(timeInterval: 1,
                                             target: self,
                                             selector: #selector(playerMusic),
                                             userInfo: nil,
                                             repeats: true)
    }
    
    @objc func playerMusic()
    {
        if mus_jeu.isPlaying == false
        {
            mus_jeu.play()
        }
    }
    
    //--- Fonction touchesMoved que changera de place le mur bas et le finger pour contrôller le retourne de la balle
    //------------------
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch: UITouch = touches.first!
        if touch.view == march_balle{
            march_balle.center.x = touch.location(in: self.view).x
        }
    }

}

