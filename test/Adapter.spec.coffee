test = require("tape")
{ r } = require("renaissance")
Adapter = require("../../dist/Adapter")

test("Adapter can be instantiated", (t) =>
  t.ok(new Adapter())
  t.end()
)

test("Adapter has tmpl method", (t) =>
  adapter = new Adapter()
  t.ok(typeof adapter.tmpl == "function")
  t.end()
)

test("Adapter can be registered with renaissance", (t) =>
  t.ok(r.registerAdapter("appendHTML", Adapter))
  t.end()
)
