import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var timer=Timer()
    var game:Game!
    var counter = 0.0
    var notfinish = false
    var pausee=true
    var setting=Setting.readLoversFromFile()
    var speed=1
    var audioDeadPlayer: AVAudioPlayer!
    var audioEatPlayer: AVAudioPlayer!
    //var audioDeadPlayer: AVAudioPlayer!
    
    @IBOutlet weak var gameRange: UIView!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var life: UILabel!

    @IBAction func startGame(_ sender: Any) {
        game=Game()
        
        timer = Timer.scheduledTimer(timeInterval: 1-(0.05*Double(15-1)),
                                     target:self,
                                     selector: #selector( tickDown ),
                                     userInfo:nil,repeats:true)
        start.setTitle("重新開始", for: .normal)
        pause.isEnabled=true
        start.isEnabled=false
        
        life.isEnabled=true
        rightButton.isEnabled=true
        leftButton.isEnabled=true
        stop.isEnabled=true
        /*let urlDead = Bundle.main.url(forResource: "死亡bgm", withExtension: "m4a")
        do {
            audioDeadPlayer = try AVAudioPlayer(contentsOf: urlDead!)
            audioDeadPlayer.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        
        let urlEat = Bundle.main.url(forResource: "吃到食物", withExtension: "m4a")
        do {
            audioEatPlayer = try AVAudioPlayer(contentsOf: urlEat!)
            audioEatPlayer.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }*/
    }
    
    
    
    @IBAction func pauseGame(_ sender: Any) {
        if pausee{
            timer.invalidate()
            pause.setTitle("恢復", for: .normal)
            pausee=false
            
            stop.isEnabled=false
            rightButton.isEnabled=false
            leftButton.isEnabled=false
        }
        else{
            /*if (1-(0.05*Double(15-1)+Double(game.point/5))) >= 0{
                timer.invalidate()*/
                
                timer = Timer.scheduledTimer(timeInterval: 1-(0.05*Double(15-1)+0.1*Double(game.point/5)),
                                             target:self,
                                             selector: #selector( tickDown ),
                                             userInfo:nil,repeats:true)
           /* }
            else {*//*
                timer = Timer.scheduledTimer(timeInterval:1 - 0.95,
                                             target:self,
                                             selector: #selector( tickDown ),
                                             userInfo:nil,repeats:true)
            }*/
            
            
            
            
            pause.setTitle("暫停", for: .normal)
            pausee=true
            stop.isEnabled=true
            rightButton.isEnabled=true
            leftButton.isEnabled=true
        }
    }
    
    @IBAction func 轉方向(_ sender: UIButton) {
        if sender.titleLabel?.text=="左"{
                game.people.move=Move.left
        }
        else if sender.titleLabel?.text=="右"{
                game.people.move=Move.right
        }
        else if sender.titleLabel?.text=="靜止"{
                game.people.move=Move.not
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start.isEnabled=true
        pause.isEnabled=false
        rightButton.isEnabled=false
        leftButton.isEnabled=false
        stop.isEnabled=false
        
        /*if let speedd = setting?.speed{
            speed=speedd
        }*/
        // 向上滑動
        let swipeUp = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeUp.direction = .up
        
        // 幾根指頭觸發 預設為 1
        swipeUp.numberOfTouchesRequired = 1
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeUp)
        
        
        // 向左滑動
        let swipeLeft = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeLeft.direction = .left
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeLeft)
        
        
        // 向下滑動
        let swipeDown = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeDown.direction = .down
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeDown)
        
        
        // 向右滑動
        let swipeRight = UISwipeGestureRecognizer(
            target:self,
            action:#selector(GameViewController.滑動(recognizer:)))
        swipeRight.direction = .right
        
        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    
    
    
    @objc func tickDown()
    {
        notfinish=game.runOneRound()
        if notfinish {
            let cgX=gameRange.frame.size.width/(CGFloat(game.boundaryX)-1)
            let cgY=gameRange.frame.size.height/(CGFloat(game.boundaryY)-1)
            
            
            //print(cgX,cgY)
            //清空圖片
            for v in gameRange.subviews as [UIView] {
                v.removeFromSuperview()
            }
            
            //畫人
            var myImageView = UIImageView(
                frame: CGRect(
                    x: CGFloat(game.people.x-1)*cgX,
                    y: CGFloat(game.people.y-1)*cgY,
                    width: cgX,
                    height: cgY+20))
            myImageView.image = UIImage(named: "8.jpg")
            //myImageView.backgroundColor=UIColor.red
            gameRange.addSubview(myImageView)
            
            //畫身體
            for sn in game.square{
                var myImageView = UILabel(
                    frame: CGRect(
                        x: CGFloat(sn.x-1)*cgX,
                        y: CGFloat(sn.y-1)*cgY,
                        width:CGFloat(sn.x+sn.width-1)*cgX-CGFloat(sn.x-1)*cgX,
                        height: cgY))
                
                if sn.type==1{
                    myImageView.backgroundColor=UIColor.green
                    //myImageView.image = UIImage(named: "蛇身 2.png")
                }
                else if sn.type==2{
                    myImageView.backgroundColor=UIColor.blue
                    //myImageView.image = UIImage(named: "蛇身 4.png")
                }
                else{
                    myImageView.backgroundColor=UIColor.red
                }
                gameRange.addSubview(myImageView)
            }
            //修改分數
            point.text="分數： " + String(format: "%02i", game.point)
            life.text="生命： "+String(format: "%02i", game.life)
            if game.life<5{
                life.backgroundColor=UIColor(red: 50, green: 0, blue: 0, alpha: 1)
            }
            else{
                life.backgroundColor=UIColor(red: 50, green: 50, blue: 50, alpha: 1)
            }
            if game.point >= 20 {
                point.backgroundColor = UIColor(red: 50, green: 0, blue: 0, alpha: 1)
            }
            else if game.point >= 15 {
                point.backgroundColor = UIColor(red: 50, green: 0, blue: 50, alpha: 1)
            }
            else if game.point >= 10 {
                point.backgroundColor = UIColor(red: 50, green: 50, blue: 0, alpha: 1)
            }
            else if game.point >= 5 {
                point.backgroundColor = UIColor(red: 0, green: 25, blue: 50, alpha: 1)
            }
            
            
            // print(game.food)
            // print(game.snakeHead)
            
            //吃到食物時播音樂
            /* if game.status==Status.eat{
             audioEatPlayer.play()
             }*/
            //加速
            /*if game.point%5 == 0 && game.point != 0{
                if (1-(0.05*Double(speed-1)+0.1*Double(game.point/5))) >= 0{
                    timer.invalidate()
                    
                    timer = Timer.scheduledTimer(timeInterval: 1-(0.05*Double(speed-1)+0.1*Double(game.point/5)),
                                                 target:self,
                                                 selector: #selector( tickDown ),
                                                 userInfo:nil,repeats:true)
                }
                else {
                    timer.invalidate()
                    
                    timer = Timer.scheduledTimer(timeInterval: 1-0.95,
                                                 target:self,
                                                 selector: #selector( tickDown ),
                                                 userInfo:nil,repeats:true)
                }
            }*/
        }
        else{
            //遊戲結束，紀錄成績 重設遊戲
            var tmp=User(no: 0, point: game.point, user: (setting?.name)!, description: "")
            
            User.saveToFile(user: tmp)
            
            timer.invalidate()
            start.isEnabled=true
            pause.isEnabled=false
            stop.isEnabled=false
            rightButton.isEnabled=false
            leftButton.isEnabled=false
            

            //audioDeadPlayer.play()
            
        }
        //game.people.move=Move.not
        print("------------------")
        for i in game.square{
            print(i.x,i.y,i.type)
        }
        print(game.people.x,game.people.y)
    }
    
    
    @objc func 滑動(recognizer:UISwipeGestureRecognizer) {
        if recognizer.direction == .left {
            if game.people.move != Move.right{
                game.people.move=Move.left
            }
        }
        else if recognizer.direction == .right {
            if game.people.move != Move.left{
                game.people.move=Move.right
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
        // Show the navigation bar on other view controllers
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
