#import "../lib/main.typ": (
  cetz, cloud2, icons, to-fletcher-shapes, wireless-wave,
)
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#set text(font: "FreeSans")


#let (
  monitor,
  router,
  wl-router,
  switch,
  l3-switch,
  server,
  cloud,
  lock,
  ap,
  dual-ap,
  hub,
  fe-hub,
) = icons(
  fill: blue,
  fill-inner: white,
  stroke-inner: white,
  stroke: blue.lighten(50%) + 2pt,
  flat: false,
)

#cetz.canvas(length: 2cm, {
  import cetz.draw: *
  grid(
    (-4, -6),
    (4, 6),
    stroke: blue,
    step: 1,
  )
  monitor(label: "a", (-3, 3))
  server(label: "as", (-1, 3))
  switch(label: "asd", (1, 3), detail: "Sw099112")
  switch(label: "asdf", (-3, 1), detail: "S1")
  router(label: "asdff", (-1, 1), detail: "R1")
  cloud(label: "asdfff", (1, 1))
  wl-router(label: "q", (1, -1), wireless: true, detail: "secure")
  router(label: "q", (-1, -1), wireless: true)
  switch(label: "qw", (-3, 5), flat: true, detail: "S2")
  router(label: "qwe", (-1, 5), flat: true, detail: [router])
  l3-switch(label: "qwer", (1, 5), flat: true, detail: "L3S2")
  l3-switch(label: "qwerr", (3, 5), flat: true, detail: "router")
  l3-switch(label: "qwerrr", (3, 3), flat: false, detail: "router")
  lock(label: "qwerrr", (-3, -1))
  switch(label: "q", (3, -1), wireless: true, detail: "secure")
  router(label: "q", (1, -3), flat: true, detail: "secure")
  switch(label: "q", (3, -3), flat: true, detail: "secure")
  switch(label: "q", (3, 1), flat: true, detail: "secure")
  ap((-3, -3), flat: true)
  ap((-1, -3))
  dual-ap((-3, -5))
  dual-ap((-1, -5), flat: true)
  hub((1, -5))
  fe-hub((3, -5))
})
