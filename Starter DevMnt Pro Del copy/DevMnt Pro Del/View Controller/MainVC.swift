//
//  PizzaVC.swift
//  DevMnt Pro Del
//
//  Created by Ivan Ramirez on 1/19/22.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate  {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    private let pizzaData = PizzaData()
    var tally: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailMenuVC,
              let cell = sender as? ItemCVCell,
              let indexPath = self.myCollectionView.indexPath(for: cell) else {
            return
        }
        
        let pizza = pizzaData.pizzas[indexPath.row]
        
        destinationVC.pizza = pizza
        destinationVC.placeOrderDelegate = self
        
    }

    // MARK: - Animation
    func animateAstroDude(myImageView: UIImageView) {
        let originalCenter = myImageView.center
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                myImageView.center.x -= 80.0
                myImageView.center.y += 10.0
            })

            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4) {
                myImageView.transform = CGAffineTransform(rotationAngle: -.pi / 80)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                myImageView.center.x -= 100.0
                myImageView.center.y += 50.0
                myImageView.alpha = 0.0
            }

            UIView.addKeyframe(withRelativeStartTime: 0.51, relativeDuration: 0.01) {
                myImageView.transform = .identity
                myImageView.center = CGPoint(x:  900.0, y: 100.0)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45) {
                myImageView.center = originalCenter
                myImageView.alpha = 1.0
            }

        }, completion: { (_) in
            //
        })
    }


    // MARK: - Action
    @IBAction func orderButtonTapped(_ sender: Any) {
        guard tally > 0 else {
            self.logoImageView.shake()
            return
        }
        tally = 0
        self.totalLabel.text = "\(tally)"
        self.animateAstroDude(myImageView: self.logoImageView)
    }

}

extension MainVC: PlaceOrderProtocol {
    func addOrder() {
        tally += 1
        totalLabel.text = "\(tally)"
    }
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pizzaData.pizzas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pizzaCell", for: indexPath) as? ItemCVCell else {
            return UICollectionViewCell()
        }
        
        let pizza = pizzaData.pizzas[indexPath.row]
        
        cell.pizza = pizza
        
        return cell
    }
    

}
