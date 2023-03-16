//
//  ViewController.swift
//  coolCombineExample
//
//  Created by Shubham Deshmukh on 15/03/23.
//

import UIKit

struct Comment: Codable {
    var body: String
}

enum NetworkError: String, Error {
    case badURL = " bad URL, please use valid url"

}

class ViewController: UIViewController {
    
   // changes for main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData(with: URL(string: "http://localhost:3000/comments")!) { result in
                
            switch result {
                
            case .success(let comments):
                print("Comments : \(comments)")
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            
            }
        }
        
    }
    
    
    func getData(with url: URL, completion: @escaping (Result<[Comment], NetworkError>) -> Void )  {
      
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.badURL))
            }else{
                
                do{
                    let comments = try JSONDecoder().decode([Comment].self, from: data!)
                    
                    completion(.success(comments))
                }catch {
                    print("failed converstion")
                }
                
            }
            
        }.resume()
        
    }
    
}

