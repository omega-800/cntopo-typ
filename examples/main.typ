#import "../lib/main.typ": cetz, icons

#let (monitor, laptop, router, switch, l3-switch, server) = icons(
  fill: white,
  fill-inner: blue,
  stroke-inner: blue,
  stroke: blue + 2pt,
)

#cetz.canvas(length: 3cm, {
  import cetz.draw: *
  monitor((0, 0))
  server((0, -3))
  switch((3, 0), flat: false)
  l3-switch((3, -3))
  router((2, 4))
})
