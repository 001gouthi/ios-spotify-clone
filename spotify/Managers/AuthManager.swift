//
//  AuthManager.swift
//  spotify
//
//  Created by SHAHID AFRIDI SHAIK on 6/27/23.
//

import Foundation

final class AuthManager{
    static let shared = AuthManager()
private var refreshingToken = false
    struct Constants {
        static let clientID = "968fef3ef2ea4150b3d563a3642384b1"
        static let clientSecret = "1580f7b24dfb468b9b967dc021a945eb"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static let redirect_uri = "https://www.apple.com/"
        static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    private init(){}
    
    public var signInURL:URL?{
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirect_uri)&show_dialog=TRUE"
        print("signIn url is \(string)")
        
        return URL(string:string)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil

    }
    private var accessToken: String?{
        return UserDefaults.standard.string(forKey: "access_token")
        
    }
    private var refreshToken: String?{
        return UserDefaults.standard.string(forKey: "refresh_token")
        
    }
    private var tokenExpirationdate:Date?{
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    private var shouldRefreshToken:Bool {
        guard let expirationDate = tokenExpirationdate else {
            return false
        }
        let currentDate  = Date()
        let fiveMinutes:TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(
        code:String,
        completion: @escaping ((Bool)->Void)
    )
    {
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        var components = URLComponents()
        components.queryItems = [
        URLQueryItem(name: "grant_type", value: "authorization_code"),
        URLQueryItem(name: "code", value: code),
        URLQueryItem(name: "redirect_uri", value: Constants.redirect_uri)
        ]
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let basictoken = Constants.clientID+":"+Constants.clientSecret
        let data = basictoken.data(using: .utf8)
        guard let base64 = data?.base64EncodedString() else {
            print("Error in Base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        let task  = URLSession.shared.dataTask(with: request) { [weak self] data,_ ,error in
            guard let data = data,
                  error == nil else{
                completion(false)
                return
            }
            do{
                let result  = try JSONDecoder().decode(AuthResponse.self,from: data)
                self?.cacheToken(result:result)
                print("Success:\(result)")
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
        
    }
    private func cacheToken(result:AuthResponse){
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refreshToken = result.refresh_token{
            UserDefaults.standard.setValue(refreshToken, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }

    private var onRefreshBlocks = [(String)->Void]()
    
    // Supplies valid token for every call
    public func withValidToken(completion: @escaping (String)-> Void){
        guard !refreshingToken else{
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken {
            //refresh
            refreshIfNeeded{ [weak self] success in
                if let token = self?.accessToken,success {
                    completion(token)
                }
            }
        }else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshIfNeeded(completion: @escaping (Bool)->Void) {
        guard !refreshingToken else {
            return
        }
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        guard let refreshToken = self.refreshToken else{return}
        
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
        URLQueryItem(name: "grant_type", value: "refresh_token"),
        URLQueryItem(name: "refresh_token", value: refreshToken),
        ]
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let basictoken = Constants.clientID+":"+Constants.clientSecret
        let data = basictoken.data(using: .utf8)
        guard let base64 = data?.base64EncodedString() else {
            print("Error in Base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        let task  = URLSession.shared.dataTask(with: request) { [weak self] data,_ ,error in
            self?.refreshingToken = false
            guard let data = data,
                  error == nil else{
                completion(false)
                return
            }
            do{
                let result  = try JSONDecoder().decode(AuthResponse.self,from: data)
                self?.onRefreshBlocks.forEach({$0(result.access_token)})
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result:result)
                print("Success:\(result)")
            }catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
       
    }
}
