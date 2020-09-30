import UIKit

class listviewcontroller: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var equipmentArray: [Equipment] = []
    
    var selected: Equipment? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        getEquipments()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let detailvc = segue.destination as! DetailViewController
            detailvc.selectedequipament = selected
        }
    }
    
    func getEquipments() {
        let url = URL(string: "https://welding-server.herokuapp.com/equipments")!
        URLSession.shared.dataTask(with: url) {
            data, _, _ in
            if let data = data {
                if let json = try? JSONDecoder().decode([Equipment].self, from: data) {
                    for newEquipment in json {
                        self.equipmentArray.append(newEquipment)
                    }
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
                    }
                }
            }
        }.resume()
    }
}

extension listviewcontroller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipmentArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: TableViewCell.rouseidentifier, for: indexPath) as? TableViewCell else {
            fatalError("cannot create the cell")
        }
        
        cell.equipmentname.text = equipmentArray[indexPath.row].name
        cell.equipmentinfo.text = equipmentArray[indexPath.row].wire_diameter
        getImage(urlstring: equipmentArray[indexPath.row].image, imageView: cell.equipmentimage)
        
        return cell
    }
    
    func getImage(urlstring: String, imageView: UIImageView) {
        let url = URL(string: urlstring)!
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

extension listviewcontroller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let equipment = equipmentArray[indexPath.row]
        selected = equipment
        performSegue(withIdentifier: "detail", sender: nil)
        
    }
}

struct Equipment: Codable {
    var name: String
    var process: String
    var voltage: String
    var polarity: String
    var wire_diameter: String
    var image: String
}
