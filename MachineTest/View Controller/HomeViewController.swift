//
//  HomeViewController.swift
//  MachineTest
//
//  Created by Apple on 05/11/22.
//

import UIKit
import Kingfisher
import Alamofire

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var CategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var BannerCollectionView: UICollectionView!
    
    @IBOutlet weak var ProductsCollectionVw: UICollectionView!
    
    
    var dataHomes: HomeDatas?
    var datacategoryModels = [HomeData]()
    var databannerModels = [HomeData]()
    var productsDatasModel = [HomeData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        fetchData()
//    }
    
    
    private func fetchData() {
        HomeDataFromServer(with: "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0")
      
    }
    
    func addofferShape(cell: ProductCollectionViewCell) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: cell.offerView.frame.size.width, y: 0.0))
        path.addLine(to: CGPoint(x: cell.offerView.frame.size.width * 0.85, y: cell.offerView.frame.size.height / 2))
        path.addLine(to: CGPoint(x: cell.offerView.frame.size.width, y: cell.offerView.frame.size.height))
        path.addLine(to: CGPoint(x: 0.0, y: cell.offerView.frame.size.height))
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.red.cgColor
        shape.path = path.cgPath
        cell.offerView.layer.insertSublayer(shape, at: 0)
        
    }
    
    
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CategoryCollectionView {
            return self.datacategoryModels[0].values.count
        } else if collectionView == BannerCollectionView {
            return databannerModels[0].values.count
        } else {
            return productsDatasModel[0].values.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CategoryCollectionView {
            let catgrycell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCll", for: indexPath)as!
            CategoryCollectionViewCell
            
            let catgries = datacategoryModels[0].values[indexPath.item]
            if let imgURL = catgries.imageURL {
                let img = URL(string: imgURL)!
                catgrycell.imageVw.kf.setImage(with: img)
            }
            catgrycell.NameLbl.text = catgries.name
            return catgrycell
        }else if collectionView == BannerCollectionView {
            let bannercell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCll", for: indexPath)as!
            BannerCollectionViewCell
            let bannersdata = databannerModels[0].values[indexPath.row]
            if let imgURL = bannersdata.bannerURL {
                let img = URL(string: imgURL)!
                bannercell.BannerImgVw.kf.setImage(with: img)
            }
            return bannercell
            
        } else {
            
            let productcell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCll", for: indexPath)as!
            ProductCollectionViewCell
            addofferShape(cell: productcell)
            let products = productsDatasModel[0].values[indexPath.row]
            if let offers = products.offer, let img = products.image, let offerPrice = products.offerPrice, let price = products.actualPrice, let name = products.name {
                let imguRL = URL(string: img)!
                productcell.offerLbl.text = "\(offers)% OFF"
                productcell.ImgVw.kf.setImage(with: imguRL)
               productcell.DetailsLbl.text = products.name
                productcell.OldPriceLbl.text = price
                productcell.PriceLbl.text = offerPrice
            }
            return productcell
            
        }
    }
    
    
}


extension HomeViewController{
    
    
    private func HomeDataFromServer(with url: String) {
        CustomActivityIndicator.showActivityIndicator(uiView: self.view)
        NetworkHandler.sharedNetwork.networkCall(with: url) { [self] response, isSucess, status in
            if isSucess {
                let data = response!
                do {
                    dataHomes = try JSONDecoder().decode(HomeDatas.self, from: data)
                    datacategoryModels = dataHomes!.homeData.filter({$0.type == "category"})
                    databannerModels = dataHomes!.homeData.filter({$0.type == "banners"})
                    productsDatasModel = dataHomes!.homeData.filter({$0.type == "products"})
                    CategoryCollectionView.delegate = self
                    BannerCollectionView.delegate = self
                    ProductsCollectionVw.delegate = self
                    CategoryCollectionView.dataSource = self
                    BannerCollectionView.dataSource = self
                    ProductsCollectionVw.dataSource = self
                    CategoryCollectionView.reloadData()
                    BannerCollectionView.reloadData()
                    ProductsCollectionVw.reloadData()
                } catch let error {
                    print(error.localizedDescription)
                }
                CustomActivityIndicator.hideActivityIndicator(uiView: self.view)
            } else {
                CustomActivityIndicator.hideActivityIndicator(uiView: self.view)
            }
        }
    }
    
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == CategoryCollectionView {
            let cellRect = CategoryCollectionView.frame.size
            return CGSize(width: 80.0, height: cellRect.height)
        } else if collectionView == BannerCollectionView {
            let cellRect = BannerCollectionView.frame.size
            return CGSize(width: cellRect.width * 0.85, height: cellRect.height)
        } else {
            let cellRect = ProductsCollectionVw.frame.size
            return CGSize(width: 158.0, height: cellRect.height)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == CategoryCollectionView {
            return 20
            
        } else if collectionView == BannerCollectionView {
            return 10
            
        }else {
            return 10
        }
       
    }
    

    
}
