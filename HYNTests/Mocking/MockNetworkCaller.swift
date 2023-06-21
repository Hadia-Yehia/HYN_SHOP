//
//  MockAPICaller.swift
//  SportsHubTests
//
//  Created by Yousra Mamdouh Ali on 02/06/2023.
//

import UIKit
import Foundation
@testable import HYN
class MockNetworkCaller : Mockable {
    var shouldReturnError:Bool
   
    init(shouldReturnError:Bool)
    {
     
        self.shouldReturnError = shouldReturnError
    }
 
     enum ResponseWithError : Error
     {
         case responseError
     }

//     func load<T: Decodable>(_ filename: String)-> T {
//         var data: Data
//         guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//                 else
//         {
//              fatalError("Can't open file called \(filename)")
//         }
//         do{
//             data = try Data(contentsOf: file)
//         }catch
//         {
//             fatalError("Can't open file called \(filename)")
//         }
//         do{
//            return try JSONDecoder().decode(T.self, from: data)
//         }
//         catch
//         {
//             fatalError("Can't open file called \(filename)")
//         }
//     }

}
extension MockNetworkCaller
{
    
    // MARK: get all addresses
    func getCurrencyExchange(url:String , complitionHandler: @escaping (Currency?,Error?)->Void)
    {
        if shouldReturnError
        {
            complitionHandler(nil,ResponseWithError.responseError)
        }else
        {
            do {
                let currency:Currency = try loadJSON(filename: "Leagues", type: Currency.self)
                complitionHandler(currency,nil)
            }catch
            {
                print("Error")
            }
    
        }
    }
    
   // MARK: get upcomingEvents : Basketball
//    func getUpcomingEvents(url:String , complitionHandler: @escaping ([Event]?,Error?)->Void)
//    {
//        if shouldReturnError
//        {
//            complitionHandler(nil,ResponseWithError.responseError)
//        }else
//        {
//            do {
//                let upComingEvents:Events = try loadJSON(filename: "UpComingEvents", type: Events.self)
//                complitionHandler(upComingEvents.result,nil)
//            }catch
//            {
//                print("Error")
//            }
//
//        }
//    }
//
//    // MARK: get latest events : cricket
//
//    func getLatestEvents(url:String , complitionHandler: @escaping ([Event]?,Error?)->Void)
//    {
//        if shouldReturnError
//        {
//            complitionHandler(nil,ResponseWithError.responseError)
//        }else
//        {
//            do {
//                let latestEvents:Events = try loadJSON(filename: "LatestEvents", type: Events.self)
//                complitionHandler(latestEvents.result,nil)
//            }catch
//            {
//                print("Error")
//            }
//
//        }
//    }
//
//    //MARK: get teams : football
//    func getTeams(url:String , complitionHandler: @escaping ([Team]?,Error?)->Void)
//    {
//        if shouldReturnError
//        {
//            complitionHandler(nil,ResponseWithError.responseError)
//        }else
//        {
//            do {
//                let teams:Teams = try loadJSON(filename: "Teams", type: Teams.self)
//                complitionHandler(teams.result,nil)
//            }catch
//            {
//                print("Error")
//            }
//
//        }
//    }
//
//
//    // MARK: get footballTeamDetails
//    func getTeamDetails(url:String , complitionHandler: @escaping ([TeamDetails]?,Error?)->Void)
//    {
//        if shouldReturnError
//        {
//            complitionHandler(nil,ResponseWithError.responseError)
//        }else
//        {
//            do {
//                let teams:FootballTeam = try loadJSON(filename: "TeamDetails", type: FootballTeam.self)
//                complitionHandler(teams.result,nil)
//            }catch
//            {
//                print("Error")
//            }
//
//        }
//    }
//
//    // MARK: get tennis players
//
//    func getTennisPlayers(url:String , complitionHandler: @escaping ([TennisPlayer]?,Error?)->Void)
//    {
//        if shouldReturnError
//        {
//            complitionHandler(nil,ResponseWithError.responseError)
//        }else
//        {
//            do {
//                let players:TennisPlayers = try loadJSON(filename: "TeamDetails", type: TennisPlayers.self)
//                complitionHandler(players.result,nil)
//            }catch
//            {
//                print("Error")
//            }
//
//        }
//    }
}
