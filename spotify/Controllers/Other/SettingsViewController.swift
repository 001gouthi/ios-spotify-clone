//
//  SettingsViewController.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 6/27/23.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView: UITableView = {
        let tableview = UITableView(frame: .zero,style:.grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    private var sections = [Section]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func configureModels(){
        sections.append(Section(title: "Profile", options: [
            Option(title: "View Your Profile", handler: { [weak self] in
                DispatchQueue.main.async {
                    self?.viewProfile()
                }
            })
        ]))
        
        sections.append(Section(title: "Account", options: [
            Option(title: "Sign Out", handler: { [weak self] in
                DispatchQueue.main.async {
                    self?.signOutTapped()
                }
            })
        ]))
    }
    
    private func viewProfile(){
        let vc = ProfileViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func signOutTapped(){
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int{
        return sections.count
    }
    func tableView(_ tableView: UITableView,numberOfRowsInSection section:Int) -> Int{
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
