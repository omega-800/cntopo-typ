#import "../lib/main.typ": cetz, icons

#let (monitor, laptop, router, switch, l3-switch, server) = icons()

#cetz.canvas(length: 3cm, {
  import cetz.draw: *
  monitor((0, 0))
  server((0, -3))
  switch((3, 0))
  l3-switch((3, -3))
  router((3, 3))
})
