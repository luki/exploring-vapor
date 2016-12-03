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



drop.run()
