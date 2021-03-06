//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Adrian Koo on 18/06/20.
//

import UIKit


class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var restaurant: RestaurantMO!
    
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateRestaurant(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: {
            if let rating = segue.identifier{
                // if restaurant.rating is the same as the users current selection remove the rating and animate
                 if self.restaurant.rating == rating{
                    self.restaurant.rating = ""
                    
                    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                        appDelegate.saveContext()
                    }
                    
                    // MARK: - fadeOut animation ratingImageView
                    UIView.animate(withDuration: 0.6){
                        self.headerView.ratingImageView.alpha = 0
                    }
                    
                }else{
                    //if the restaurant taing is different assign the image to the view and animate
                    self.restaurant.rating = rating
                    self.headerView.ratingImageView.image = UIImage(named: rating)
                    
                    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                        appDelegate.saveContext()
                    }
                
                    let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                
                    self.headerView.ratingImageView.transform = scaleTransform
                    self.headerView.ratingImageView.alpha = 0
                    
                    // MARK: - fade in animation ratingImageView
                    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: [], animations: {
                        self.headerView.ratingImageView.transform = .identity
                        self.headerView.ratingImageView.alpha = 1
                    }, completion: nil)
                }
            }
        })
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        // MARK: Implementation of Phone row
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
            cell.iconImageView.image = UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = restaurant.phone
            cell.selectionStyle = .none
            
            return cell
        // MARK: Implementation of Map row
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
            cell.iconImageView.image = UIImage(systemName: "map")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            cell.shortTextLabel.text = restaurant.location
            cell.selectionStyle = .none
            
            return cell
        // MARK: Implementation of Description row
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
            cell.descriptionLabel.text = restaurant.summary
            cell.selectionStyle = .none
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailSeperatorCell.self), for: indexPath) as! RestaurantDetailSeperatorCell
            cell.titleLabel.text = "How to get there"
            cell.selectionStyle = .none
            
            return cell
        
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self), for: indexPath) as! RestaurantDetailMapCell
            if let restaurantLocation = restaurant.location {
                cell.configure(location: restaurantLocation)
            }

            
            return cell
            
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        // Configure header view
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        if let restaurantImage = restaurant.image{
                    headerView.headerImageView.image = UIImage(data: restaurantImage as Data)
        }
        headerView.heartImageView.isHidden = (restaurant.isVisited) ? false : true
        
        // MARK: - unwrapping of rating
        if let restaurantRating = restaurant.rating{
                    headerView.ratingImageView.image = UIImage(named: restaurantRating)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        tableView.contentInsetAdjustmentBehavior = .never

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        // Set navigation controllers bar style to white
        navigationController?.makeStatusBarWhite()
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Reset navagation controllers barstyle to default
        navigationController?.makeStatusBarDefault()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
            
        }else if segue.identifier == "showReview" {
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = restaurant
            
        }
    }

    }

