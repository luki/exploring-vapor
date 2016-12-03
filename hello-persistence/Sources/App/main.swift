import Vapor
import VaporPostgreSQL

let drop = Droplet(
  preparations: [Acronym.self],
  providers: [VaporPostgreSQL.Provider.self]
)

let basic = BasicController()
basic.addRoute(drop: drop)

drop.get("test") { request in
  var acronym = Acronym(short: "Ily", long: "I love you")
  try acronym.save()
  return try JSON(node: Acronym.all().makeNode())
}

drop.get("all") { request in
  return try JSON(node: Acronym.all().makeNode())
}

drop.get("first") { request in
  return try JSON(node: Acronym.all().first?.makeNode())
}

drop.get("ily") { request in
  return try JSON(node: Acronym.query().filter("short", "Ily").all().makeNode())
}

drop.get("notily") { request in
  return try JSON(node: Acronym.query().filter("short", .notEquals, "Ily").all().makeNode())
}

drop.get("update") { request in
  guard var first = try Acronym.query().first(),
    let long = request.data["long"]?.string else {
      throw Abort.badRequest
  }
  first.long = long
  try first.save()
  return first
}


drop.run()
