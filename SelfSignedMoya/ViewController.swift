//
//  ViewController.swift
//  SelfSignedMoya
//
//  Created by Pedro Vereza on 3/13/17.
//  Copyright © 2017 Pedro Vereza. All rights reserved.
//

import UIKit
import Moya
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Note entry in Info.plist: Allow Arbitrary Loads = YES
        //
        //Remove the manager to reproduce SSL issue:
        // NSURLSession/NSURLConnection HTTP load failed (kCFStreamErrorDomainSSL, -9814)

        let manager = Manager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: CustomServerTrustPoliceManager()
        )


        let provider = RxMoyaProvider<ExampleTarget>(manager: manager, plugins: [NetworkLoggerPlugin(verbose: true)])

        provider.request(.example).subscribe { event in
            switch event {
            case .next:
                print("SUCCESS")

            case .error:
                print("FAILURE")

            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    public init() {
        super.init(policies: [:])
    }
}
