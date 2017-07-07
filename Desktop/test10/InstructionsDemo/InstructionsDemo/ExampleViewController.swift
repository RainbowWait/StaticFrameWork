    //
    //  ExampleViewController.swift
    //  InstructionsDemo
    //
    //  Created by 郑小燕 on 2017/6/20.
    //  Copyright © 2017年 ZXY. All rights reserved.
    //
    
    import UIKit
    import Instructions
    
    class ExampleViewController: UIViewController {
        @IBOutlet weak var imgIcon: UIImageView!
        
        @IBOutlet weak var btnMes: UIButton!
        
        @IBOutlet weak var btnPho: UIButton!
        @IBOutlet weak var btnEma: UIButton!
        var coachMarksController = CoachMarksController()
        let avatarText = "That's your profile picture. You look gorgeous!"
        let emailText = "This is your email address. Nothing too fancy."
        let mesText = "Here, is the number of posts you made. You are just starting up!"
        let phoText = "That's your reputation around here, that's actually quite good."
        let nextText = "下一步"
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            self.coachMarksController.dataSource = self
            //是否允许点击空白地方跳过
            self.coachMarksController.overlay.allowTap = false
            self.coachMarksController.overlay.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
            let skipView = CoachMarkSkipDefaultView()
            skipView.setTitle("跳过", for: .normal)
            skipView.setTitleColor(UIColor.white, for: .normal)
            skipView.setBackgroundImage(nil, for: .normal)
            skipView.setBackgroundImage(nil, for: .highlighted)
            skipView.layer.cornerRadius = 0
            skipView.backgroundColor = UIColor.darkGray
            self.coachMarksController.skipView = skipView
        }
        
        override func viewDidAppear(_ animated: Bool) {
            self.coachMarksController.start(on: self)
        }
        override func viewWillDisappear(_ animated: Bool) {
            self.coachMarksController.stop()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
    
    extension ExampleViewController: CoachMarksControllerDataSource {
        //引导数量
        func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
            return 5
        }
        
        //哪些需要添加引导
        func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
            /* //普通样式
            switch index {
            case 0:
                return coachMarksController.helper.makeCoachMark(for: self.navigationController?.navigationBar)
                
            case 1:
                return coachMarksController.helper.makeCoachMark(for: self.imgIcon)
            case 2:
                return coachMarksController.helper.makeCoachMark(for: self.btnMes)
            case 3:
                return coachMarksController.helper.makeCoachMark(for: self.btnEma)
            case 4:
                return coachMarksController.helper.makeCoachMark(for: self.btnPho)
            default:
                return coachMarksController.helper.makeCoachMark()
            }
            */
            
            //customer样式
            let flatCutoutPathMaker = {(frame: CGRect) -> UIBezierPath in
                return UIBezierPath.init(rect: frame)
            }
            var coachMark: CoachMark
            
            switch index {
            case 0:
                coachMark = coachMarksController.helper.makeCoachMark(for: self.navigationController?.navigationBar)
                
            case 1:
                coachMark = coachMarksController.helper.makeCoachMark(for:  self.imgIcon)
//                {(frame: CGRect) -> UIBezierPath in
//                    return UIBezierPath(ovalIn: frame.insetBy(dx: 0, dy: -4))
//                }
            case 2:
                coachMark = coachMarksController.helper.makeCoachMark(for: self.btnMes)
                coachMark.arrowOrientation = .top
            case 3:
                coachMark = coachMarksController.helper.makeCoachMark(for: self.btnEma)
            case 4:
                coachMark =  coachMarksController.helper.makeCoachMark(for: self.btnPho)
            default:
                coachMark =  coachMarksController.helper.makeCoachMark()
            }
            return coachMark
        }
        
        func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
            //普通样式
            /*
             let coachViews =
             /*
             withArrow: 是否有箭头
             arrowOrientation: 箭头方向
             */
             coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
             switch index {
             case 0:
             coachViews.bodyView.hintLabel.text = self.avatarText
             coachViews.bodyView.nextLabel.text = self.nextText
             case 1:
             coachViews.bodyView.hintLabel.text = self.avatarText
             coachViews.bodyView.nextLabel.text = self.nextText
             case 2:
             coachViews.bodyView.hintLabel.text = self.mesText
             coachViews.bodyView.nextLabel.text = self.nextText
             
             case 3:
             coachViews.bodyView.hintLabel.text = self.emailText
             coachViews.bodyView.nextLabel.text = self.nextText
             case 4:
             coachViews.bodyView.hintLabel.text = self.phoText
             coachViews.bodyView.nextLabel.text = self.nextText
             
             default:
             break
             }
             return (bodyView: coachViews.bodyView,arrowView: coachViews.arrowView)
             */
            /*
            //无下一步样式
            var hintText = ""
            
            switch(index) {
            case 0:
                hintText = self.avatarText
            case 1:
                hintText = self.avatarText
            case 2:
                hintText = self.mesText
            case 3:
                hintText = self.emailText
            case 4:
                hintText = self.phoText
            default: break
            }
            let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation, hintText: hintText, nextText: nil)
            
            
            return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
     */
            //自定义
             let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation, hintText: nextText, nextText: nil)
            let coachMarkBodyView = CustomCoachMarkBodyView()
            var coachMarkArrowView: CustomCoachMarkArrowView? = nil
             var width: CGFloat = 0.0
            switch index {
            case 0:
                coachMarkBodyView.hintLabel.text = self.avatarText
                coachMarkBodyView.nextButton.setTitle(self.nextText, for: .normal)
                if let navigation = self.navigationController?.navigationBar {
                    width = navigation.bounds.width
                }
            case 1:
                coachMarkBodyView.hintLabel.text = self.avatarText
                coachMarkBodyView.nextButton.setTitle(self.nextText, for: .normal)
                if let imgava = imgIcon {
                    width = imgIcon.bounds.width
                }
            case 2:
                coachMarkBodyView.hintLabel.text = self.mesText
                coachMarkBodyView.nextButton.setTitle(self.nextText, for: .normal)
                if let mes = btnMes {
                    width = mes.bounds.width
                }
 
            case 3:
                coachMarkBodyView.hintLabel.text = self.emailText
                coachMarkBodyView.nextButton.setTitle(self.nextText, for: .normal)
                if let ema = btnEma {
                    width = ema.bounds.width
                }
                
            case 4:
                coachMarkBodyView.hintLabel.text = self.phoText
                coachMarkBodyView.nextButton.setTitle(self.nextText, for: .normal)
                if let pho = btnPho {
                    width = pho.bounds.width
                }
                
            default:
                break
            }
            
            if let arrowOrientation = coachMark.arrowOrientation {
                coachMarkArrowView = CustomCoachMarkArrowView.init(orientation: arrowOrientation)
                let oneThirdOfWidth = self.view.window!.frame.size.width / 3
                let adjustedWidth = width >= oneThirdOfWidth ? width - 2 * coachMark.horizontalMargin : width
                coachMarkArrowView!.plate.addConstraint(NSLayoutConstraint(item: coachMarkArrowView!.plate, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
            }
              return (bodyView: coachMarkBodyView, arrowView: coachMarkArrowView)
            
        }
        
        func coachMarksController(_ coachMarksController: CoachMarksController, constraintsForSkipView skipView: UIView, inParent parentView: UIView) -> [NSLayoutConstraint]? {
            //自动布局使用可视化语言
            var constraints: [NSLayoutConstraint] = []
            var topMargin: CGFloat = 20.0
            if UIApplication.shared.isStatusBarHidden {
                topMargin = UIApplication.shared.statusBarFrame.size.height
            }
            
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[skipView(==80)]-space-|", options: NSLayoutFormatOptions(rawValue:0), metrics: ["space": 10], views: ["skipView": skipView]))
            
            if UIApplication.shared.isStatusBarHidden {
                constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[skipView]", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: ["skipView": skipView]))
            } else {
                constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-topMargin-[skipView(==44)]", options: NSLayoutFormatOptions(rawValue: 0), metrics:["topMargin": topMargin], views: ["skipView": skipView]))
            }
            
            return constraints
        }
        
    }
