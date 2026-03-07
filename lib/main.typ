#import "util.typ": fill-def, stroke-def
#import "shapes.typ": *
#import "nodes.typ": *
#import "clients.typ": *
#import "links.typ": *
#import "misc.typ": *

#let icon-presets = (
  // nodes
  router: node.with(class: "router"),
  secure-router: node.with(class: "router", detail: "secure"),
  w-router: node.with(class: "router", wireless: true),
  wv-router: node.with(class: "router", shape: "hex"),
  wv-w-router: node.with(class: "router", shape: "hex", wireless: true),
  switch: node.with(class: "switch"),
  l3-switch: node.with(class: "l3-switch"),
  // clients
  monitor: monitor,
  laptop: laptop,
  server: server,
  // misc
  cloud: cloud,
  lock: lock
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
