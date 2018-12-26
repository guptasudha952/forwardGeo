//
//  WeatherViewController.swift
//  forwardGeo
//
//  Created by Student 06 on 25/12/18.
//  Copyright © 2018 Student 06. All rights reserved.
//

import UIKit
//https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=468458440214e1027ae56b4535ca3f7c

class WeatherViewController: UIViewController {
    var latit:Float = 0.0
    var logit: Float = 0.0
    var desArray = [String]()
    
    @IBOutlet weak var templabel: UILabel!
    
    @IBOutlet weak var pressurelabel: UILabel!
    @IBOutlet weak var humiditylabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
jsonParse()
        // Do any additional setup after loading the view.
    }
func jsonParse()
{
    let urlstring = "https://api.openweathermap.org/data/2.5/weather?lat=\(latit)&lon=\(logit)&appid=468458440214e1027ae56b4535ca3f7c"
    let url:URL = URL(string: urlstring)!
    let session:URLSession = URLSession(configuration: .default)
    let datatask = session.dataTask(with: url) { (data, response, error) in
        if response != nil
        {
            if data  != nil
            {
                do
                {
                    let dic:[String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    
        
                    let mainDic:[String:Any] = dic["main"] as! [String:Any]
                    let humidityDic:NSNumber = mainDic["humidity"] as! NSNumber
                    
                    let strhumidity:String = humidityDic.stringValue
                    
                    print("Got humidity \(strhumidity)")
                    
                    let tempdic:NSNumber = mainDic["temp"] as! NSNumber
                    
                    let strtemp:String = tempdic.stringValue
                    
                    print("cot temp \(strtemp)")
                    let pressureDic:NSNumber = mainDic["pressure"] as! NSNumber
                    
                    let strpressure:String = pressureDic.stringValue
                    
                    print("got pressure = \(strpressure)")
                    DispatchQueue.main.async {
                        self.humiditylabel.text = strhumidity
                        self.templabel.text = strtemp
                        self.pressurelabel.text = strpressure
                    }
                    
                }
                
            catch
            {
               print(error.localizedDescription)
            }
        }
        else
        {
         print(error?.localizedDescription)
        }
    }
    }
    datatask.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
