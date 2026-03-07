#import "util.typ": fill-def, stroke-def
#import "shapes.typ": *
#import "nodes.typ": *
#import "clients.typ": *
#import "links.typ": *
#import "misc.typ": *

#let default-nodes = (
  router: node.with(class: "router"),
  wl-router: node.with(class: "router", shape: "hex"),
  switch: node.with(class: "switch"),
  l3-switch: node.with(class: "l3-switch"),
  ap: node.with(class: "ap"),
  dual-ap: node.with(class: "dual-ap"),
  mesh-ap: node.with(class: "mesh-ap"),
  hub: node.with(class: "hub"),
  fe-hub: node.with(class: "fe-hub"),
)

#let icon-presets = (
  default-nodes
    .pairs()
    .map(((k, v)) => (
      (k, v),
      ("w-" + k, v.with(wireless: true)),

      ("sec-" + k, v.with(detail: "secure")),
      ("w-sec-" + k, v.with(detail: "secure", wireless: true)),

      ("cl-" + k, v.with(detail: "cloud")),
      ("w-cl-" + k, v.with(detail: "cloud", wireless: true)),
    ))
    .join()
    .to-dict()
    + (
      // clients
      monitor: monitor,
      // laptop: laptop,
      server: server,
      // misc
      cloud: cloud,
      lock: lock,
    )
)

#let icons = (
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => (
  icon-presets
    .pairs()
    .map(((k, v)) => (
      k,
      v.with(
        stroke: stroke,
        fill: fill,
        stroke-inner: stroke-inner,
        fill-inner: fill-inner,
        flat: flat,
      ),
    ))
    .to-dict()
)

#let to-fletcher-shapes = i => (
  i
    .pairs()
    .map(((k, v)) => (
      k,
      (node, extrude, ..extra) => {
        // TODO: radius
        // panic(node, extrude, extra.pos(), extra.named())
        v(
          (0, 0),
          node.size.map(i => i / 2 + extrude),
          ..extra.named(),
          stroke: node.stroke,
          fill: node.fill,
          fill-inner: stroke-to-paint(node.stroke),
          stroke-inner: node.stroke,
        )
      },
    ))
    .to-dict()
)

#let fletcher-shapes = (..args) => to-fletcher-shapes(icons(..args.named()))
