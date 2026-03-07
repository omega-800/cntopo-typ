#import "../lib/main.typ": (
  cetz, cloud2, icons, to-fletcher-shapes, wireless-wave,
)
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#set text(font: "FreeSans")

#let i = icons(
  fill: blue,
  fill-inner: white,
  stroke-inner: white,
  stroke: blue.lighten(50%) + 2pt,
  flat: false,
)

#let (
  i-monitor,
  i-router,
  i-wl-router,
  i-switch,
  i-l3-switch,
  i-server,
  i-cloud,
  i-lock,
  i-ap,
  i-dual-ap,
  i-hub,
  i-fe-hub,
) = (
  i.pairs().map(((k, v)) => ("i-" + k, v)).to-dict()
)

#let (
  monitor,
  router,
  switch,
  l3-switch,
  server,
  cloud,
) = to-fletcher-shapes(
  i,
)

#cetz.canvas(length: 2cm, {
  import cetz.draw: *
  grid(
    (-4, -6),
    (4, 6),
    stroke: blue,
    step: 1,
  )
  i-monitor(label: "a", (-3, 3))
  i-server(label: "as", (-1, 3))
  i-switch(label: "asd", (1, 3), detail: "Sw099112")
  i-switch(label: "asdf", (-3, 1), detail: "S1")
  i-router(label: "asdff", (-1, 1), detail: "R1")
  i-cloud(label: "asdfff", (1, 1))
  // i-switch(label: "asdffff",(-2, -2), (2, 2), detail: "S3")
  // i-router(label: "q",(2, -2), (2, 2), detail: "R3")
  i-wl-router(label: "q", (1, -1), wireless: true, detail: "secure")
  i-router(label: "q", (-1, -1), wireless: true)
  i-switch(label: "qw", (-3, 5), flat: true, detail: "S2")
  i-router(label: "qwe", (-1, 5), flat: true, detail: [router])
  i-l3-switch(label: "qwer", (1, 5), flat: true, detail: "L3S2")
  i-l3-switch(label: "qwerr", (3, 5), flat: true, detail: "router")
  i-l3-switch(label: "qwerrr", (3, 3), flat: false, detail: "router")
  i-lock(label: "qwerrr", (-3, -1))
  i-switch(label: "q", (3, -1), wireless: true, detail: "secure")
  i-router(label: "q", (1, -3), flat: true, detail: "secure")
  i-switch(label: "q", (3, -3), flat: true, detail: "secure")
  i-switch(label: "q", (3, 1), flat: true, detail: "secure")
  i-ap((-3, -3), flat: true)
  i-ap((-1, -3))
  i-dual-ap((-3, -5))
  i-dual-ap((-1, -5), flat: true)
  i-hub((1, -5))
  i-fe-hub((3, -5))
})

#let node = node.with(width: 4em, height: 4em)
#diagram(
  node-stroke: orange,
  node-fill: orange.lighten(90%),
  node((1, -1), shape: monitor.with(label: "192.168.0.69"), name: <c1>),
  node((2, -1), shape: monitor.with(label: "192.168.0.33"), name: <c2>),
  node((2, 0), shape: switch.with(label: "s2"), name: <s2>),
  node((1, 0), shape: switch.with(label: "s1"), name: <s1>),
  node((1.5, 1), shape: router.with(label: "192.168.0.1"), name: <r1>),
  node((2, 2), shape: l3-switch.with(label: "192.168.0.1"), name: <s3>),
  node(
    enclose: (<c1>, <c2>, <s1>, <s2>),
    inset: 4em,
    fill: white,
    label: [net1\ 192.168.1.0/24],
    shape: cloud,
  ),
  edge(<s1>, <c1>),
  edge(<s2>, <c2>, label: "x"),
  edge(<r1>, <s1>),
  edge(<r1>, <s2>),
  edge(<r1>, <s3>),
)

#diagram(
  node-stroke: blue,
  node((0, 0), shape: router, name: <c1>),
  node((1, 0), shape: router, name: <c2>),
  node((2, 0), shape: router, name: <c3>),
  node((0.5, 1), shape: router, name: <c4>),
  node((1.5, 1), shape: router, name: <c5>),
  edge(<c1>, (0, 0.5)),
  edge(<c2>, (1, 0.5)),
  edge(<c3>, (2, 0.5)),
  edge(<c4>, (0.5, 0.5)),
  edge(<c5>, (1.5, 0.5)),
  edge((-0.5, 0.5), (2.5, 0.5)),
)

#diagram(
  node-stroke: blue,
  node((1, 0), shape: router.with(label: "DR"), name: <c1>),
  node((2, 1), shape: router.with(label: "BDR"), name: <c2>),
  node((0, 1), shape: router, name: <c3>),
  node((1.5, 2), shape: router, name: <c4>),
  node((0.5, 2), shape: router, name: <c5>),
  edge(<c1>, <c2>, "<|--|>"),
  edge(<c1>, <c3>, "<|--|>"),
  edge(<c1>, <c4>, "<|--|>"),
  edge(<c1>, <c5>, "<|--|>"),
  edge(<c2>, <c3>, "<|--|>"),
  edge(<c2>, <c5>, "<|--|>"),
)

#diagram(
  node-stroke: blue,
  node((1, 0), shape: router.with(label: "DR"), name: <c1>),
  node((2, 1), shape: router.with(label: "BDR"), name: <c2>),
  node((0, 1), shape: router.with(label: "DROTHER"), name: <c3>),
  node((1.5, 2), shape: router.with(label: "DROTHER"), name: <c4>),
  node((0.5, 2), shape: router.with(label: "DROTHER"), name: <c5>),
  edge(<c1>, <c2>, "<|--|>", label: "full"),
  edge(<c1>, <c3>, "<|--|>", label: "full"),
  edge(<c1>, <c4>, "<|--|>", label: "full"),
  edge(<c1>, <c5>, "<|--|>", label: "full"),
)

#diagram(
  node-stroke: blue,
  node-fill: white,
  node((0, 0), shape: router, name: <c1>),
  node((1, 0), shape: router, name: <c2>),
  node((2, 0), shape: router, name: <c3>),
  node((1, 1), shape: switch, name: <s>),
  node((0, 2), shape: router, name: <c4>),
  node((1, 2), shape: router, name: <c5>),
  node((2, 2), shape: router, name: <c6>),
  edge(<c1>, <s>),
  edge(<c2>, <s>),
  edge(<c3>, <s>),
  edge(<c4>, <s>),
  edge(<c5>, <s>),
  edge(<c6>, <s>),
  node(
    enclose: (<c1>, <c2>, <c3>, <c4>, <c5>, <c6>, <s>),
    inset: 4em,
    fill: blue.transparentize(90%),
    shape: cloud,
  ),
)
