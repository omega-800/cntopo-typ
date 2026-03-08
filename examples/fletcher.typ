#import "../lib/main.typ": cetz, fletcher-shapes, wireless-wave-link
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#set text(font: "FreeSans")

#let node = node.with(width: 4em, height: 4em)
#let ex = flat => {
  let (monitor, switch, router, l3-switch, cloud) = fletcher-shapes(flat: flat)
  diagram(
    node-stroke: orange,
    node-fill: orange.lighten(90%),
    node((-1, 1), shape: monitor.with(label: "192.168.0.69"), name: <c1>),
    node((-1, 2), shape: monitor.with(label: "192.168.0.33"), name: <c2>),
    node(
      (0, 2),
      shape: switch.with(
        detail: "S2",
      ),
      name: <s2>,
    ),
    node((0, 1), shape: switch.with(detail: "S1"), name: <s1>),
    node(
      (1, 1.5),
      shape: router.with(detail: "R1"),
      name: <r1>,
    ),
    node(
      (2, 1),
      shape: l3-switch.with(detail: "S3"),
      name: <s3>,
    ),
    node(
      enclose: (<c1>, <c2>, <s1>, <s2>),
      inset: 4em,
      fill: white,
      // label: [net1\ 192.168.1.0/24],
      shape: cloud.with(label: [net1\ 192.168.1.0/24]),
    ),
    edge(<s1>, <c1>),
    edge(<s2>, <c2>),
    edge(<r1>, <s1>),
    edge(<r1>, <s2>),
    edge(<r1>, <s3>, dash: "dashed"),
  )
}
#ex(true)
#ex(false)

#let (
  monitor,
  router,
  switch,
  l3-switch,
  server,
  cloud,
) = fletcher-shapes(flat: false)

#diagram(
  node-stroke: blue,
  node-fill: white,
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
  node-fill: white,
  node((1, 0), shape: router.with(detail: "DR"), name: <c1>),
  node((2, 1), shape: router.with(detail: "BDR"), name: <c2>),
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
  node-fill: white,
  node((1, 0), shape: router.with(detail: "DR"), name: <c1>),
  node((2, 1), shape: router.with(detail: "BDR"), name: <c2>),
  node(
    (0, 1),
    shape: router.with(detail: text(size: .7em)[DROTHER]),
    name: <c3>,
  ),
  node(
    (1.5, 2),
    shape: router.with(detail: text(size: .7em)[DROTHER]),
    name: <c4>,
  ),
  node(
    (0.5, 2),
    shape: router.with(detail: text(size: .7em)[DROTHER]),
    name: <c5>,
  ),
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
