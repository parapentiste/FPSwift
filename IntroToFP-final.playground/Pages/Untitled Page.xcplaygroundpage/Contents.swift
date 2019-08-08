/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

//: # Introduction to Functional Programming

/*:
 ## Imperative Style
 
 Command your data!
 */
var thing = 3
//some stuff
thing = 4

/*:
 ## Side effects
 
 Holy mysterious change! - Why is my thing now 5?
 */
func superHero() {
  print("I'm batman")
  thing = 5
}

print("original state = \(thing)")
superHero()
print("mutated state = \(thing)")

/*:
 ## Create a Model
 */
enum RideCategory: String {
  case family
  case kids
  case thrill
  case scary
  case relaxing
  case water
}

typealias Minutes = Double
struct Ride {
  let name: String
  let categories: Set<RideCategory>
  let waitTime: Minutes
}

/*:
 ## Create some data using that model
 */
let parkRides = [
  Ride(name: "Raging Rapids",
       categories: [.family, .thrill, .water],
       waitTime: 45.0),
  Ride(name: "Crazy Funhouse", categories: [.family], waitTime: 10.0),
  Ride(name: "Spinning Tea Cups", categories: [.kids], waitTime: 15.0),
  Ride(name: "Spooky Hollow", categories: [.scary], waitTime: 30.0),
  Ride(name: "Thunder Coaster",
       categories: [.family, .thrill],
       waitTime: 60.0),
  Ride(name: "Grand Carousel", categories: [.family, .kids], waitTime: 15.0),
  Ride(name: "Bumper Boats", categories: [.family, .water], waitTime: 25.0),
  Ride(name: "Mountain Railroad",
       categories: [.family, .relaxing],
       waitTime: 0.0)
]

/*:
 ### Attempt to change immutable data.
 */

//parkRides[0] = Ride(name: "Functional Programming", categories: [.thrill], waitTime: 5.0)

/*:
 ## Modularity
 
 Create a function that does one thing.
 
 1. Returns the names of the rides in alphabetical order.
 */

func sortedNamesImp(of rides: [Ride]) -> [String] {
  
  // 1
  var sortedRides = rides
  var key: Ride
  
  // 2
  for i in (0..<sortedRides.count) {
    key = sortedRides[i]
    
    // 3
    for j in stride(from: i, to: -1, by: -1) {
      if key.name.localizedCompare(sortedRides[j].name) == .orderedAscending {
        sortedRides.remove(at: j + 1)
        sortedRides.insert(key, at: j)
      }
    }
  }
  
  // 4
  var sortedNames: [String] = []
  for ride in sortedRides {
    sortedNames.append(ride.name)
  }
  
  return sortedNames
}

let sortedNames1 = sortedNamesImp(of: parkRides)

//: Test your new function
func testSortedNames(_ names: [String]) {
  let expected = ["Bumper Boats",
                  "Crazy Funhouse",
                  "Grand Carousel",
                  "Mountain Railroad",
                  "Raging Rapids",
                  "Spinning Tea Cups",
                  "Spooky Hollow",
                  "Thunder Coaster"]
  assert(names == expected)
  print("✅ test sorted names = PASS\n-")
}

print(sortedNames1)
testSortedNames(sortedNames1)

var originalNames: [String] = []
for ride in parkRides {
  originalNames.append(ride.name)
}

//: Test that original data is untouched

func testOriginalNameOrder(_ names: [String]) {
  let expected = ["Raging Rapids",
                  "Crazy Funhouse",
                  "Spinning Tea Cups",
                  "Spooky Hollow",
                  "Thunder Coaster",
                  "Grand Carousel",
                  "Bumper Boats",
                  "Mountain Railroad"]
  assert(names == expected)
  print("✅ test original name order = PASS\n-")
}

print(originalNames)
testOriginalNameOrder(originalNames)

/*:
 ## First class and higher order functions.
 
 Most languages that support FP will have the functions `filter`, `map` & `reduce`.
 
 ### Filter
 
 Filter takes the input `Collection` and filters it according to the function you provide.
 
 Here's a simple example.
 */

let apples = ["🍎", "🍏", "🍎", "🍏", "🍏"]
let greenapples = apples.filter { $0 == "🍏"}
print(greenapples)


//: Next, try filtering your ride data
func waitTimeIsShort(_ ride: Ride) -> Bool {
  return ride.waitTime < 15.0
}

let shortWaitTimeRides = parkRides.filter(waitTimeIsShort)
print("rides with a short wait time:\n\(shortWaitTimeRides)")

let shortWaitTimeRides2 = parkRides.filter { $0.waitTime < 15.0 }
print(shortWaitTimeRides2)

/*:
 ### Minor detour: CustomStringConvertible
 
 You want to make your console output look nice.
 */
extension RideCategory: CustomStringConvertible {
  var description: String {
    return rawValue
  }
}

extension Ride: CustomStringConvertible {
  var description: String {
    return "Ride –\"\(name)\", wait: \(waitTime) mins, categories: \(categories)\n"
  }
}

/*:
 ### Map
 
 Map converts each `Element` in the input `Collection` into a new thing based on the function that you provide.
 
 First create oranges from apples.
 */
let oranges = apples.map { _ in "🍊" }
print(oranges)

//: Now extract the names of your rides
let rideNames = parkRides.map { $0.name }
print(rideNames)
testOriginalNameOrder(rideNames)

print(rideNames.sorted(by: <))

func sortedNamesFP(_ rides: [Ride]) -> [String] {
  let rideNames = parkRides.map { $0.name }
  return rideNames.sorted(by: <)
}

let sortedNames2 = sortedNamesFP(parkRides)
testSortedNames(sortedNames2)

/*:
 ### Reduce
 
 Reduce iterates across the input `Collection` to reduce it to a single value.
 
 You can squish your oranges into one juicy string.
 */
let juice = oranges.reduce(""){juice, orange in juice + "🍹"}
print("fresh 🍊 juice is served – \(juice)")

//: Here you **reduce** the collection to a single value of type `Minutes` (a.k.a `Double`)
let totalWaitTime = parkRides.reduce(0.0) { (total, ride) in
  total + ride.waitTime
}
print("total wait time for all rides = \(totalWaitTime) minutes")


/*:
 ## Partial Functions
 
 A function can return a function.
 
 `filter(for:)` returns a function of type `([Ride]) -> ([Ride])`
 it takes and returns an array of `Ride` objects
 */
func filter(for category: RideCategory) -> ([Ride]) -> [Ride] {
  return { (rides: [Ride]) in
    rides.filter { $0.categories.contains(category) }
  }
}

//: you can use it to filter the list for all rides that are suitable for kids.
let kidRideFilter = filter(for: .kids)
print("some good rides for kids are:\n\(kidRideFilter(parkRides))")


/*:
 ## Pure Functions
 
 - Always give same output for same input
 - Have no side effects
 */
func ridesWithWaitTimeUnder(_ waitTime: Minutes,
                            from rides: [Ride]) -> [Ride] {
  return rides.filter { $0.waitTime < waitTime }
}

let shortWaitRides = ridesWithWaitTimeUnder(15, from: parkRides)

func testShortWaitRides(_ testFilter:(Minutes, [Ride]) -> [Ride]) {
  let limit = Minutes(15)
  let result = testFilter(limit, parkRides)
  print("rides with wait less than 15 minutes:\n\(result)")
  let names = result.map{ $0.name }.sorted(by: <)
  let expected = ["Crazy Funhouse",
                  "Mountain Railroad"]
  assert(names == expected)
  print("✅ test rides with wait time under 15 = PASS\n-")
}


testShortWaitRides(ridesWithWaitTimeUnder(_:from:))

//: when you replace the function with its body, you expect the same result
testShortWaitRides({ waitTime, rides in
  rides.filter{ $0.waitTime < waitTime }
})

/*:
 ## Recursion
 
 Recursion is when a function calls itself as part of its function body.
 
 Make `Ride` conform to `Comparable` so you can compare two `Ride` objects:
 */
extension Ride: Comparable {
  static func <(lhs: Ride, rhs: Ride) -> Bool {
    return lhs.waitTime < rhs.waitTime
  }
  
  static func ==(lhs: Ride, rhs: Ride) -> Bool {
    return lhs.name == rhs.name
  }
}

/*:
 Next add a `quickSorted` algorithim to `Array`
 */
extension Array where Element: Comparable {
  func quickSorted() -> [Element] {
    if self.count > 1 {
      let (pivot, remaining) = (self[0], dropFirst())
      let lhs = remaining.filter { $0 <= pivot }
      let rhs = remaining.filter { $0 > pivot }
      return lhs.quickSorted() + [pivot] + rhs.quickSorted()
    }
    return self
  }
}

//: test your algorithm
let quickSortedRides = parkRides.quickSorted()
print("\(quickSortedRides)")


/*:
 check that your solution matches the expected value from the standard library function
 */
func testSortedByWaitRides(_ rides: [Ride]) {
  let expected = rides.sorted(by:  { $0.waitTime < $1.waitTime })
  assert(rides == expected, "unexpected order")
  print("✅ test sorted by wait time = PASS\n-")
}

testSortedByWaitRides(quickSortedRides)

/*:
 ## Imperative vs Declarative style
 
 ### Imperitive style. Fill a container with the right things.
 */
var ridesOfInterest: [Ride] = []
for ride in parkRides where ride.waitTime < 20 {
  for category in ride.categories where category == .family {
    ridesOfInterest.append(ride)
    break
  }
}

let sortedRidesOfInterest1 = ridesOfInterest.quickSorted()
print(sortedRidesOfInterest1)

func testSortedRidesOfInterest(_ rides: [Ride]) {
  let names = rides.map({ $0.name }).sorted(by: <)
  let expected = ["Crazy Funhouse",
                  "Grand Carousel",
                  "Mountain Railroad"]
  assert(names == expected)
  print("✅ test rides of interest = PASS\n-")
}

testSortedRidesOfInterest(sortedRidesOfInterest1)

/*:
 ### Functional Approach
 
 Declare what you're doing. Filter, Sort, Profit :]
 */
let sortedRidesOfInterest2 = parkRides
  .filter { $0.categories.contains(.family) && $0.waitTime < 20 }
  .sorted(by: <)

testSortedRidesOfInterest(sortedRidesOfInterest2)

