#import "../lib/main.typ": cetz, icons, to-fletcher-shapes
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let i = icons(
  fill: white,
  fill-inner: blue,
  stroke-inner: blue,
  stroke: blue + 2pt,
  flat: false,
)

#let (
  i-monitor,
  i-laptop,
  i-router,
  i-switch,
  i-l3-switch,
  i-server,
  i-cloud,
) = (
  i.pairs().map(((k, v)) => ("i-" + k, v)).to-dict()
)

#let (
  monitor,
  laptop,
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
    (-4, -4),
    (4, 4),
    stroke: blue,
    step: 1,
  )
  i-monitor((-3, 3))
  i-server((-1, 3))
  i-switch((1, 3))
  i-l3-switch((-3, 1))
  i-router((-1, 1))
  i-cloud((1, 1))
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
