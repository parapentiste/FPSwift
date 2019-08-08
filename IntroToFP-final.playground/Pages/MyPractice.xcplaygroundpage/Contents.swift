//: [Previous](@previous)

import Foundation


// imperative programming style
/*
 in multi-threaded system, when more than 2 threads access the same variable concurrently, this will leads to unexpected behavior. These include "race conditions", "dead locks".
 */
var thing = 3
thing = 4

func superHero() {
    print("I'm batman")
    thing = 5
}
print("original state = \(thing)")
superHero()
print("mutated state = \(thing)")


// funcitonal programming concepts
/*
 immutalbe state, lack of side effects
 */

// set up the data structure
enum RideCategory: String, CustomStringConvertible {
    case family
    case kids
    case thrill
    case scary
    case relaxing
    case water
    
    var description: String {
        return rawValue
    }
}

typealias Minutes = Double
struct Ride: CustomStringConvertible {
    let name: String
    let categories: Set<RideCategory>
    let waitTime: Minutes
    
    var description: String {
        return "Ride -\"\(name)\", wait: \(waitTime) mins, " + "categories: \(categories)\n"
    }
}

// create some data using that model
let parkRides = [
    Ride(name: "Raing Rapids",
        categories: [.famly, .thrill, .water],
        waitTime: 45.0),
    Ride(name: "crazy funhouse", categories: [.family], waitTime: 10.0),
    Ride(name: "Spining Tea Cups", categories: [.kids], waitTime: 15.0),
    Ride(name: "Spooky Hollow", categories: [.scary], waitTime: 30.0),
    Ride(name: "Thunder Coaster", categories: [.family, .thrill], waitTime: 60.0),
    Ride(name: "Crand Carousel", categories: [.family, .kids], waitTime: 15.0),
    Ride(name: "Bumper Boats", catetories: [.family, .water], waitTime: 25.0),
    Ride(name: "Mountain Railroad", categories: [.family, .relaxing], waitTime: 0.0)
]

// modularity
func sortedNamesImp(of rides: [Ride]) -> [String] {
    // 1
    var sortedRides = rides
    var key: Ride
    
    // 2
    for i in (0..<sortedRides.count) {
        key = sortedRides[i]
        
        // 3
        for J in stride
        
    }
    
}


//: [Next](@next)
