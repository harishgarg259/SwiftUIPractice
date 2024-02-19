import Foundation


class CountriesData: ObservableObject  {
    @Published var countries = [Country]()
    
        
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        let countries = try? JSONDecoder().decode([Country].self, from: data!)
        self.countries = countries!
        
    }
     
}


struct Country : Codable {
//    var id = UUID()
    var code2 : String?
    var code3 : String?
    var name : String?
    var capital : String?
    var region : String?
    var subregion : String?
    var states : [States]?
}

struct States : Codable {
//    var id = UUID()
    var code : String?
    var name : String?
}
