//
//  ViewController.swift
//  InfinityBgTask
//
//  Created by Emerson Carvalho on 8/4/15.
//  Copyright (c) 2015 Emerson Carvalho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let btnReloadTag = 1
    let btnClearTag = 2

    @IBOutlet weak var LogTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        DB.addMessage("didReceiveMemoryWarning!!")
    }
    
    @IBAction func btnClick(sender: AnyObject) {
        
        if sender.tag == btnClearTag {
            DB.clear()
        }
        self.showLog()
    }
    
    override func viewWillAppear(animated: Bool) {
       
        super.viewWillAppear(animated)
        self.showLog()
        
    }
    
    func showLog() {
        // get all messages from the DB.
        var text = "LOG:\n"
        for message: String in DB.getMessages() {
            text = "\(text)\(message)\n"
            
        }
        LogTextView.text = text
        
        //scroll to the bottom.
        let length = count(LogTextView.text)
        let range:NSRange = NSMakeRange(length - 1, 1)
        LogTextView.scrollRangeToVisible(range)
    }


}

