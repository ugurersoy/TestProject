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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListFromUrl(name: "BATMAN")
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
    
    
    func loadingView(){
        
    }
    
   
    

}






