//
//  TrendingDetailDataManager.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

protocol TrendingDetailDataManagerDelegate: Errorable {
    func foundAll(cast: [TrendingCast], crew: [TrendingCrew])
    func apiError()
}

class TrendingDetailDataManager {

    var delegate: TrendingDetailDataManagerDelegate?
    var castLists = [TrendingCast]()
    var crewLists = [TrendingCrew]()

    func loadMovieCastCrew(slug: String) {
        NetworkManager.getCastAndCrewFromAPI(slug, success: { [weak self] (results) in
            self?.populateMovieCastCrewFromJSON(results)
            }, failure: { _ in
            self.delegate?.apiError()
        })
    }

    func populateMovieCastCrewFromJSON(results: [String: AnyObject]) {

        if let itemsCast = results[JSONResponseKeys.cast] as? [AnyObject] {

            var casts = [Cast]()

            for item in itemsCast {
                let cast = Cast()
                cast.character = item.valueForKey(JSONResponseKeys.character) as? String
                cast.name = item.valueForKeyPath(JSONResponseKeys.Person.name) as? String
                cast.headshot = item.valueForKeyPath(JSONResponseKeys.Person.Images.headshot) as? String
                casts.append(cast)
            }

            castLists = casts.map { dictionary in
                return CastParser.mapElement(dictionary)
            }.sort { $0.name < $1.name }
        }

        if let itemsCrew = results[JSONResponseKeys.crew] as? [String: AnyObject] {

            var crews = [Crew]()

            if let productions = itemsCrew[JSONResponseKeys.production] as? [AnyObject] {
                for production in productions {
                    let crew = Crew()
                    crew.job = production.valueForKey(JSONResponseKeys.job) as? String
                    crew.name = production.valueForKeyPath(JSONResponseKeys.Person.name) as? String
                    crew.headshot = production.valueForKeyPath(JSONResponseKeys.Person.Images.headshot) as? String
                    crews.append(crew)
                }
            }

            if let arts = itemsCrew[JSONResponseKeys.art] as? [AnyObject] {
                for art in arts {
                    let crew = Crew()
                    crew.job = art.valueForKey(JSONResponseKeys.job) as? String
                    crew.name = art.valueForKeyPath(JSONResponseKeys.Person.name) as? String
                    crew.headshot = art.valueForKeyPath(JSONResponseKeys.Person.Images.headshot) as? String
                    crews.append(crew)
                }
            }

            if let crewings = itemsCrew[JSONResponseKeys.crew] as? [AnyObject] {
                for crewing in crewings {
                    let crew = Crew()
                    crew.job = crewing.valueForKey(JSONResponseKeys.job) as? String
                    crew.name = crewing.valueForKeyPath(JSONResponseKeys.Person.name) as? String
                    crew.headshot = crewing.valueForKeyPath(JSONResponseKeys.Person.Images.headshot) as? String
                    crews.append(crew)
                }
            }

            if let costumes = itemsCrew[JSONResponseKeys.costume] as? [AnyObject] {
                for costume in costumes {
                    let crew = Crew()
                    crew.job = costume.valueForKey(JSONResponseKeys.job) as? String
                    crew.name = costume.valueForKeyPath(JSONResponseKeys.Person.name) as? String
                    crew.headshot = costume.valueForKeyPath(JSONResponseKeys.Person.Images.headshot) as? String
                    crews.append(crew)
                }
            }

            if let directings = itemsCrew[JSONResponseKeys.directing] as? [AnyObject] {
                for directing in directings {
                    let crew = Crew()
                    crew.job = directing.valueForKey(JSONResponseKeys.job) as? String
                    crew.name = directing.valueForKeyPath(JSONResponseKeys.Person.name) as? String
                    crew.headshot = directing.valueForKeyPath(JSONResponseKeys.Person.Images.headshot) as? String
                    crews.append(crew)
                }
            }

            if let writings = itemsCrew[JSONResponseKeys.writing] as? [AnyObject] {
                for writing in writings {
                    let crew = Crew()
                    crew.job = writing.valueForKey(JSONResponseKeys.job) as? String
                    crew.name = writing.valueForKeyPath(JSONResponseKeys.Person.name) as? String
                    crew.headshot = writing.valueForKeyPath(JSONResponseKeys.Person.Images.headshot) as? String
                    crews.append(crew)
                }
            }

            if let sounds = itemsCrew[JSONResponseKeys.sound] as? [AnyObject] {
                for sound in sounds {
                    let crew = Crew()
                    crew.job = sound.valueForKey(JSONResponseKeys.job) as? String
                    crew.name = sound.valueForKeyPath(JSONResponseKeys.Person.name) as? String
                    crew.headshot = sound.valueForKeyPath(JSONResponseKeys.Person.Images.headshot) as? String
                    crews.append(crew)
                }
            }

            if let cameras = itemsCrew[JSONResponseKeys.camera] as? [AnyObject] {
                for camera in cameras {
                    let crew = Crew()
                    crew.job = camera.valueForKey(JSONResponseKeys.job) as? String
                    crew.name = camera.valueForKeyPath(JSONResponseKeys.Person.name) as? String
                    crew.headshot = camera.valueForKeyPath(JSONResponseKeys.Person.Images.headshot) as? String
                    crews.append(crew)
                }
            }

            crewLists = crews.map { dictionary in
                return CrewParser.mapElement(dictionary)
            }.sort { $0.name < $1.name }
        }
        
        delegate?.foundAll(castLists, crew: crewLists)
    }
}