//
//  AppDelegate.swift
//  InfinityBgTask
//
//  Created by Emerson Carvalho on 8/4/15.
//  Copyright (c) 2015 Emerson Carvalho. All rights reserved.
//

import UIKit
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    
    var manager: CLLocationManager?
    
    var bgTask: BackgroundTaskManager = BackgroundTaskManager.sharedBackgroundTaskManager()!
    
    var timer : NSTimer? = nil

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        DB.addMessage("App Started.")
        
        manager = CLLocationManager()
        manager?.delegate = self;
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        
        manager?.requestAlwaysAuthorization()
        manager?.startUpdatingLocation()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        DB.addMessage("App Resign Active.")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        DB.addMessage("App Enter Background.")
        self.runningInBg()
        
        if timer == nil {
         // Call running in bg every 10 seconds
         timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "runningInBg", userInfo: nil, repeats: true)
        }
        
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        DB.addMessage("App Enter Foregorund.")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        DB.addMessage("App Become Active.")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        DB.addMessage("App Will Terminate.")
    }

    func runningInBg()
    {
        bgTask.beginNewBackgroundTask()
        DB.addMessage("Running in bg.")
        
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var loc: CLLocation? = locations.last as? CLLocation
        
        if loc != nil {
            // display just 4 decimal places to look good and easy to read.
            var lat = String(format: "%.4f", Float(loc!.coordinate.latitude))
            var lng = String(format: "%.4f", Float(loc!.coordinate.longitude))
            DB.addMessage("lat: \(lat) lng: \(lng)")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
            DB.addMessage("didFailWithError \(error.localizedDescription)")
    }
    

}

