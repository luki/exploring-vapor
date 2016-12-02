import Vapor

let drop = Droplet()

drop.get { request in
  return try JSON(node: [
    "message": "Hello"
  ])
}

drop.get("beers", Int.self) { request, beers in
  return try JSON(node: [
    "message": "I am tired of saying hello!"
  ])
}

drop.post("") { request in
  guard let name = request.data["name"]?.string else {
    throw Abort.badRequest
  }
  return try JSON(node: [
    "message": "Hello, \(name)"
  ])
}


drop.run()
