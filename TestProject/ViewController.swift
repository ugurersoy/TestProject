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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      movieList = getListFromUrl(name: "a")
    }
    
    
    
    
    
    func getListFromUrl(name:String) -> [Movie] {
        let url = URL.init(string: "http://www.omdbapi.com/?t=\\(name)")
        let session = URLSession.shared
        var movies :[Movie]=[]
        let task = session.dataTask(with: url!){  (data, response, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "No Data", message: "There is not any movie with that search key", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }else
            {
                if data != nil
                {
                    do{
                        
                        movies = try JSONDecoder().decode([Movie].self,from: data!)
                        
                        
                        DispatchQueue.main.async {
                            
                          //loading durdurulacak.
                            
                        }
                        
                    } catch{
                        
                    }
                }
                
            }
            
            
            }
        
         task.resume()
        
        return movies
        }
        
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellMovieTableViewCell
        
        movieCell?.lblTitle.text = movieList[indexPath.row].Title
        movieCell?.lblYear.text = movieList[indexPath.row].Year
        movieCell?.lblAutor.text = movieList[indexPath.row].Writer
        
        return movieCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}



