import UIKit

class DetailViewController: UIViewController {
    
    var selectedequipament: Equipment?
    
    
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var equipamentimg: UIImageView!
    @IBOutlet weak var equiptxt: UITextView!
    
    override func viewDidLoad() {
        
        if let selectedequipament = selectedequipament {
            productname.text = selectedequipament.name
            equiptxt.text = "Process: \(selectedequipament.process)\n"
                + "Voltage: \(selectedequipament.voltage)\n"
                + "Polarity: \(selectedequipament.polarity)\n"
                + "wire diameter: \(selectedequipament.wire_diameter)\n"
            downloadimage(imageurl: selectedequipament.image, imageview: equipamentimg)
        }
    }
    func downloadimage(imageurl: String, imageview: UIImageView){
        let url = URL(string: imageurl)!
        URLSession.shared.dataTask(with: url) { data,_,_ in
            guard let data = data else {return}
            DispatchQueue.main.async {
                imageview.image = UIImage(data: data)
            }
        }.resume()
    }
}


