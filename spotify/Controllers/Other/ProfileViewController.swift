//
//  ProfileViewController.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 6/27/23.
//
import SDWebImage
import UIKit

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
return tableView
    }()
    struct Constants{
       static let default_profile_image:String = "https://static.independent.co.uk/s3fs-public/thumbnails/image/2015/06/06/15/Chris-Pratt.jpg?quality=75&width=990&crop=4%3A3%2Csmart&auto=webp"
    }
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        fetchProfile()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func fetchProfile(){
        APICaller.shared.getCurrentUserProfile{ [weak self] result in
            DispatchQueue.main.async {
            
                switch result{
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedToGetProfile()
                }
            }
            
        }
    }
    
    private func updateUI(with model:UserProfile){
        tableView.isHidden = false
        models.append("Full Name:\(model.display_name)")
        models.append("Email Address:\(model.email)")
        models.append("User ID:\(model.id)")
        models.append("Plan:\(model.product)")
        createTableHeader(with: model.images.first?.url)
        tableView.reloadData()
    }
    private func createTableHeader(with string:String?){
        let urlString = string ?? Constants.default_profile_image
        guard let url = URL(string:urlString) else{
            return
        }
        
        let headerView = UIView(frame: CGRect(x:0,y:0,width:view.width,height: view.width/2))
        
        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x:0,y:0,width: imageSize,height:imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url,completed:nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        
        tableView.tableHeaderView = headerView
        
    }
    private func failedToGetProfile()
    {
        let label = UILabel(frame: .zero)
        label.text = "Failed to Load Profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    
    
    // MARK: - TABLEVIEW
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section:Int) -> Int{
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let model = sections[indexPath.section].options[indexPath.row]
//        model.handler()
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let model = sections[section]
//        return model.title
//    }
   
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
