//
//  Game.swift
//  Snake
//
//  Created by AutumnCAT on 2018/6/26.
//  Copyright © 2018年 AutumnCAT. All rights reserved.
//

import Foundation
import GameplayKit


enum  Move{
    case left , right,not
}

/*enum  Status{
 case move , hurt , dead  //case move , eat , dead
 }*/

struct People {
    //var type: Int       //1:頭   2:身體    3:尾
    var x: Int
    var y: Int
    var move: Move
}
struct Square {
    var type: Int  //1:平台 ２:刺 3:滾輪
    var x:Int
    var y:Int
    var width:Int
    var a:Bool
    //var foodImg:Int
}

//19*25
class Game {
    var foodImgCount = 2
    var people = People(x:10 , y:1 ,move:Move.not)
    var square = Array<Square>()
    //var food:Food
    var boundaryX = 20 //19+1  0和20當邊界
    var boundaryY = 26 //25+1  0和26當邊界
    var point=0
    //var status=Status.move
    var life=10
    var i=1
    init(){
        while i<=25{
            square.append(Square(type:隨機數字(random1:1, random2: 3),x:隨機數字(random1:1, random2:15), y:i,width:5,a:false))
            i+=3
        }
    }
    
    
    func 移動()->Bool{
        //移動頭
        //print(people.x,people.y)
        let tmp=people
        switch people.move {
        case .right:
            if !碰撞(people:tmp,move:.right){
                return false
            }
            people.x+=1
            print("右")
            break
        case .left:
            if !碰撞(people: tmp, move: .left){
                return false
            }
            people.x-=1
            print("左")
            break
        case .not:
            return true
        }
        return true
    }
    func 碰撞磚塊()->Int{
        for i in 0...square.count-1{
            if (square[i].x<=people.x && (square[i].x+square[i].width)>people.x){
                if(people.y==square[i].y-2){
                print(i)
                    return i
                }
                if(people.y==square[i].y-3){
                   people.y-=1
                }
        }
       }
        return -1
    }
    func 碰撞(people:People ,move:Move)->Bool{
        //是否碰到邊界
        var people1=people
        switch people.move {
        case .right:
            people1.x+=1
            if people1.x == boundaryX {
                return false
            }
            break
        case .left:
            people1.x-=1
            if people1.x == 0 {
                return false
            }
            break
        case .not:
            return true
        }
        return true
    }
    func 隨機數字(random1:Int,random2:Int)->Int{
        let  randomDistributionX  =  GKRandomDistribution(lowestValue:random1,  highestValue:random2)
        return randomDistributionX.nextInt()
    }
    func 碰觸結束(i:Int){
        //移動頭
        //將原本頭的位置加入身體
        if square[i].type==2{
            //status=Status.hurt
            life=life-4
        }
        if square[i].type==3{
            //status=Status.hurt
            if 碰撞(people:people ,move:.right){
                people.x+=1
                
            }
            if life<10{
                life=life+1
            }
            if square[i].a==false{
                square[i].a=true
                point=point+1
            }
            people.move=Move.not
        }
        if square[i].type==1 && square[i].a==false{
            //status=Status.move
            if life<10{
                life=life+1
            }
            point=point+1
            square[i].a=true
        }
    }
    func 生磚塊(){
        for i in 0...square.count-1{
            if square[i].y<0{
                square[i]=Square(type:隨機數字(random1:1, random2: 3), x:隨機數字(random1:1, random2:15), y:25,width:5,a:false)
                break
            }
        }
    }
    
    func runOneRound()->Bool{
        移動()
        let x=碰撞磚塊()
        if x == -1{
            people.y+=1
        }
        else{
            people.y-=1
            碰觸結束(i:x)
        }
        if people.y==0{
            people.y+=1
            life-=4
        }
        for i in 0...square.count-1{
            square[i].y-=1
        }
        生磚塊()
        if life<=0 || people.y+1==boundaryY{
            //status=Status.dead
            print("你死拉")
            return false
        }
        return true
    }
    
    
 }

