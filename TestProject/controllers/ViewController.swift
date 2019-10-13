//
//  ViewController.swift
//  TestProject
//
//  Created by ugur on 11.10.2019.
//  Copyright © 2019 ugur. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

 
    
     var movieList :[Movie]=[]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtSearch: UITextField!
    
    var shapeLayer : CAShapeLayer!
    var lblLoading : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListFromUrl(name: "BATMAN")
        startLoadingView()
    }
    
    
    @IBAction func btnSearch(_ sender: UIButton) {
        getListFromUrl(name: txtSearch.text!)
        
    }
    
    
    
    
    
    
    
    
    func getListFromUrl(name:String)  {
        let url = URL(string:"http://omdbapi.com/?s=\(name)&page=2&apikey=a56306d9")
        let session = URLSession.shared
    
        let task = session.dataTask(with: url!){  (data, response, error) in
            
            if error != nil {
                
                print(error!)
                
            }else
            {
                if data != nil
                {
                    do{
                        
                       let mv = try JSONDecoder().decode(Response.self,from: data!)
                    
                    
                        DispatchQueue.main.async {
                           
                       
                                self.movieList=mv.Search
                                self.stopLoadinfView()
                                self.tableView.reloadData()
                            
                           
                            
                        }
                        
                    } catch{
                        
                        let alert = UIAlertController(title: "No Data", message: "There is not any movie with that search key", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        print(error)
                    }
                }
                
            }
            
            
            }
        
         task.resume()
        }
        
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    let helper = Helper()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellMovieTableViewCell
        
        movieCell?.lblTitle.text = movieList[indexPath.row].Title
        movieCell?.lblYear.text = movieList[indexPath.row].Year
        movieCell?.lblAutor.text = movieList[indexPath.row].Type
        movieCell?.imageView?.image = helper.loadImg(path: movieList[indexPath.row].Poster)
        
        return movieCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieDetail = storyboard?.instantiateViewController(withIdentifier: "detailView") as? MovieDetailViewController
        
        movieDetail?.movieTitle = movieList[indexPath.row].Title
        movieDetail?.movieyear = movieList[indexPath.row].Year
        movieDetail?.movieType = movieList[indexPath.row].Type
        movieDetail?.moviePath = movieList[indexPath.row].Poster
        
        
        self.navigationController?.pushViewController( movieDetail! , animated: true)
        
    }
    
    
    func startLoadingView(){
        shapeLayer = CAShapeLayer()
        let center = view.center
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 60, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise:true)
          shapeLayer.path = circularPath.cgPath
        
          shapeLayer.fillColor =  UIColor.clear.cgColor
          shapeLayer.strokeColor =  UIColor.darkGray.cgColor
          shapeLayer.lineWidth = 10
        
        shapeLayer.lineDashPattern = [5]
        
        let lineDashPhaseAnimation = CABasicAnimation(keyPath: "lineDashPhase")
        lineDashPhaseAnimation.byValue = 10.0
        lineDashPhaseAnimation.duration = 0.75
        lineDashPhaseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        lineDashPhaseAnimation.repeatCount = .greatestFiniteMagnitude
        
        shapeLayer.add(lineDashPhaseAnimation, forKey: "lineDashPhaseAnimation")
        
    
          view.layer.addSublayer(shapeLayer)
        
         lblLoading = UILabel()
         lblLoading.text = "Loading..."
         lblLoading.font = UIFont.systemFont(ofSize: 15)
         lblLoading.sizeToFit()
         lblLoading.center = view.center
        
         view.addSubview(lblLoading)
        
        
        fadeViewInThenOut(view: lblLoading!,delay: 0)
    }
    
   
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {
        
        let animationDuration = 0.5
        
        UIView.animate(withDuration: animationDuration, delay: delay, options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat], animations: {
            view.alpha = 0
            print("animation repead")
        }, completion: nil)
        
    }
    
    
    func stopLoadinfView(){
        
        lblLoading.isHidden = true
        shapeLayer.isHidden = true
    }

}






