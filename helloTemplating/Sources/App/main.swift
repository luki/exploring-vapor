import Vapor

let drop = Droplet()

drop.get("template") { request in
  return try drop.view.make("hello", Node(node:["name":"Holly"]))
}

// Names by after slash
drop.get("template2", String.self) { request, name in
  return try drop.view.make("hello", Node(node: ["name": name]))
}

// Loop
drop.get("template3") { request in
  let users = try ["Holly", "Jorge", "Tom"].makeNode()
  return try drop.view.make("hello2", Node(node: ["users": users]))
}

drop.get("template4") { request in
  let users = try [
    ["name": "Holly", "email": "hollyr655@gmail.com"].makeNode(),
    ["name": "Lukas", "email": "lamuller@protonmail.com"].makeNode(),
    ["name": "Alexandra", "email": "ali.mueller@web.de"].makeNode()
  ].makeNode()
  return try drop.view.make("hello3", Node(node: ["users": users]))
}

drop.get("template5") { request in
  guard let sayHello = request.data["sayHello"]?.bool else {
    throw Abort.badRequest
  }
  return try drop.view.make("hellogoodbye", Node(node: ["sayHello": sayHello.makeNode()]))
}

drop.run()
