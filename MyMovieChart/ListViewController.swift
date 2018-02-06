//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by Wonmi Kang on 2018. 1. 17..
//  Copyright © 2018년 odong. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var list = Array<Movie>()
    var page = 1

    @IBOutlet var movieTable: UITableView!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBAction func more(_ sender: Any) {
        page = page + 1
        
        callMovieAPI()
        
        self.movieTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        callMovieAPI()
    }
    
    func callMovieAPI() {
        
        let apiURI = URL(string: "http://115.68.183.178:2029/hoppin/movies?order=releasedateasc&count=10&page=\(self.page)&version=1&genreId=")
        
        do {
            var root:HoppinRoot?
            let data:Data? = try Data(contentsOf: apiURI!)
            
            if let apidata = data {
                print("API Result=%@", String(data: apidata, encoding: .utf8)!)
                root = try JSONDecoder().decode(HoppinRoot.self, from: apidata)
                
                guard let movies = root?.hoppin.movies?.movie else {
                    return
                }
                
                var movie:Movie
                for row in movies {
                    movie = Movie()
                    
                    movie.title = row.title
                    movie.genreNames = row.genreNames
                    movie.linkUrl = row.linkUrl
                    movie.ratingAverage = Float(row.ratingAverage)!
                    movie.thumbnail = row.thumbnailImage
                    
                    self.list.append(movie)
                }
            }
            
            guard let totalCount = Int((root?.hoppin.totalCount)!) else {
                return
            }
            
            if (self.list.count >= totalCount) {
                self.moreBtn.isHidden = true
            }
        } catch {
            print("Parse error!!")
        }
    }
    
    func getThumbnailImage(index:Int) -> UIImage {
        let mv = self.list[index]
        
        if let savedImage = mv.thumbnailImage {
            return savedImage
        } else {
            var url = URL(string: mv.thumbnail)
            var imageData = try? Data(contentsOf:url!)
            mv.thumbnailImage = UIImage(data:imageData!)
            
            return mv.thumbnailImage!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! MovieCell

        let movie = self.list[indexPath.row]
        
        cell.title?.text = movie.title
        cell.desc?.text = movie.genreNames
        //cell.opendate?.text = row.opendate
        cell.rating?.text = "\(movie.ratingAverage)"
        
        DispatchQueue(label: "").async {
            DispatchQueue.main.async {
                cell.thumbnail.image = self.getThumbnailImage(index: indexPath.row)
            }
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue_detail" {
            if let destination = segue.destination as? DetailViewController, let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                destination.movie = self.list[selectedIndex] as Movie
            }
        }
        
    }

}
