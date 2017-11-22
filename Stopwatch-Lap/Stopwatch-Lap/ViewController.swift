//
//  ViewController.swift
//  Stopwatch-Lap
//
//  Created by Abi Sayuti on 11/22/17.
//  Copyright © 2017 Abi Sayuti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var laps: [String] = []
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    
    var stopwatchString : String = ""
    
    var startStopWatch: Bool = true
    var addLap:Bool = false
    
    @IBOutlet weak var StopWatchLabel: UILabel!
    @IBOutlet weak var lapTableView: UITableView!
    @IBOutlet weak var btnStartStop: UIButton!
    @IBOutlet weak var btnLapReset: UIButton!
    
    @IBAction func StartStop(_ sender: Any) {
        if startStopWatch == true {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateStopwatch), userInfo: nil, repeats: true)
            startStopWatch = false
            btnStartStop.setImage(UIImage(named: "Pause.png"), for: UIControlState.normal)
            btnLapReset.setImage(UIImage(named: "Lap.png"), for: UIControlState.normal)
            
            addLap = true
        }else{
            timer.invalidate()
            startStopWatch = true
            btnStartStop.setImage(UIImage(named: "Start.png"), for: .normal)
            btnLapReset.setImage(UIImage(named: "Reset.png"), for: .normal)
            
            addLap = false
        }
    }
    
    @IBAction func LapReset(_ sender: Any) {
        
        
        if addLap == true {
            laps.insert(stopwatchString, at: 0)
            lapTableView.reloadData()
        }else{
            addLap = false
            btnLapReset.setImage(UIImage(named: "Lap.png"), for: .normal )
            laps.removeAll(keepingCapacity: false)
            lapTableView.reloadData()
            
            fractions = 0
            minutes = 0
            seconds = 0
            
            stopwatchString = "00:00:00"
            StopWatchLabel.text = stopwatchString
        }
    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        StopWatchLabel.text = "00:00:00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateStopwatch() {
        fractions += 1
        if fractions == 100 {
            seconds += 1
            fractions = 0
        }
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopwatchString = "\(minutesString):\(secondsString):\(fractionsString)"
        StopWatchLabel.text = stopwatchString
    }
    
    //table view method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        
        cell.backgroundColor = self.view.backgroundColor
        
        cell.textLabel?.text = "Lap \(laps.count-indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
}
