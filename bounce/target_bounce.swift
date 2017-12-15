//
//  target_bounce.swift
//  
//
//  Created by Alessandra Nishikawa on 17-12-13.
//  Adaptation de classe Bounce de Mario pour l'inclusion de cibles, la ponctuation, et la vue por utiliser la fonction touchesMoved
//--------------------------------------------------
import UIKit
import Foundation
//--------------------------------------------------
//--------------------------------------------------
class Targetbounce {
    //--------------------------------------------------
    var b: UIView!
    var lw: UIView!
    var rw: UIView!
    var tw: UIView!
    var bw: UIView!
    var tg1: UIView!
    var tg2: UIView!
    var tg3: UIView!
    var tg4: UIView!
    var pt: UILabel!
    var tp: UILabel!
    var mb: UIView!
    var sg: UIButton!
    //--------------------------------------------------
    init(ball b: UIView,
         left_window lw: UIView,
         right_window rw: UIView,
         top_window tw: UIView,
         bottom_window bw: UIView,
         target_1 tg1: UIView,
         target_2 tg2: UIView,
         target_3 tg3: UIView,
         target_4 tg4: UIView,
         points pt: UILabel,
         total_points tp: UILabel,
         move_ball mb: UIView,
         start_game sg: UIButton) {
        self.b = b
        self.lw = lw
        self.rw = rw
        self.tw = tw
        self.bw = bw
        self.tg1 = tg1
        self.tg2 = tg2
        self.tg3 = tg3
        self.tg4 = tg4
        self.pt = pt
        self.tp = tp
        self.mb = mb
        self.sg = sg
    }
    
    //--------------------------------------------------
    func returnCosSinAfterTouch(sin s: Double, cos c: Double) -> [Double] {
        
        let r = atan2f(Float(s), Float(c))
        var d = r * (180 / Float(Double.pi))
        
            if b.frame.intersects(lw.frame) || b.frame.intersects(rw.frame) {
                d = 180 - d }
            if b.frame.intersects(tw.frame) {
                let p = abs(d)
                d=p }
            if b.frame.intersects(tg1.frame) {
                let p = abs(d)
                d=p}
            if b.frame.intersects(tg2.frame) {
                let p = abs(d)
                d=p}
            if b.frame.intersects(tg3.frame) {
                let p = abs(d)
                d=p}
            if b.frame.intersects(tg4.frame) {
                let p = abs(d)
                d=p}
            if b.frame.intersects(mb.frame) {
                let n = (d) * -1
                d=n }
            if b.frame.intersects(bw.frame){
              let n = (d) * -1
                d=n }
            return [__sinpi(Double(d/180.0)), __cospi(Double(d/180.0))]
        
    }
}

