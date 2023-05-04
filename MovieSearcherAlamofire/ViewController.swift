//
//  ViewController.swift
//  MovieSearcherAlamofire
//
//  Created by Nancy Hernandez Yanez on 04-05-23.
//

import UIKit
import Alamofire
import Kingfisher


class ViewController: UIViewController {
  
  @IBOutlet weak var movieName: UITextField!
  
  @IBOutlet weak var movieTitle: UILabel!
  
  @IBOutlet weak var launchDate: UILabel!
  
  @IBOutlet weak var awards: UILabel!
  
  @IBOutlet weak var actors: UILabel!
  
  @IBOutlet weak var poster: UIImageView!
  
  @IBOutlet weak var genre: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func search() {
    if !movieName.text!.isEmpty {
      AF.request("https://www.omdbapi.com/?apikey=8bb5255f&t=\(movieName.text ?? "")").responseDecodable(of: MovieModel.self) { (response) in
        // show data
        self.movieTitle.text = response.value?.title ?? ""
        self.launchDate.text = ("Release: \(response.value?.released ?? "")")
        self.awards.text = ("Awards: \(response.value?.awards ?? "")")
        self.actors.text = ("Actors: \(response.value?.actors ?? "")")
        self.genre.text = ("Genre: \(response.value?.genre ?? "")")
        print(response)
        //Show image
        let urlNoImage = "https://sobreplanos.s3.amazonaws.com/uploads/real_estate_attachment/picture/2201668/apartamento_en_venta_en_boston_de_3_hab_con_zonas_humedas_cover_0569e7d07904c61fb0bf.png"
        guard let url = URL(string: response.value?.poster ?? urlNoImage) else { return }
        self.poster.kf.setImage(with: url)
        
        self.movieName.text = ""
      }
    }
    else {
      let alert = UIAlertController(title: "Error", message: "Type the name of the movie", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "Accept", style: .default)
      alert.addAction(alertAction)
      present(alert, animated: true)
    }
  }
  
  @IBAction func searchButton(_ sender: Any) {
    search()
  }
  
}
