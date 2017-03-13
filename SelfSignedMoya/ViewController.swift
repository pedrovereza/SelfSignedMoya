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
        /*
         Error Domain=NSURLErrorDomain Code=-1202 "The certificate for this server is invalid. You might be connecting to a server that is pretending to be “ride.com” which could put your confidential information at risk." UserInfo={NSURLErrorFailingURLPeerTrustErrorKey=<SecTrustRef: 0x6000001173d0>, NSLocalizedRecoverySuggestion=Would you like to connect to the server anyway?, _kCFStreamErrorDomainKey=3, _kCFStreamErrorCodeKey=-9814, NSErrorPeerCertificateChainKey=(
         "<cert(0x7fb419026e00) s: *.ride.com i: COMODO RSA Domain Validation Secure Server CA>",
         "<cert(0x7fb419025e00) s: COMODO RSA Domain Validation Secure Server CA i: COMODO RSA Certification Authority>
*/

        let manager = Manager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: CustomServerTrustPoliceManager()
        )


        let provider = MoyaProvider<ExampleTarget>(manager: manager, plugins: [NetworkLoggerPlugin(verbose: true)])

        provider.request(.example) { result in
            switch result {
            case .success(_):
                print("SUCCESS")

            case let .failure(error):

                print(error)
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
