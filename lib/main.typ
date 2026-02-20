#import "util.typ": fill-def, stroke-def
#import "shapes.typ": *
#import "nodes.typ": *
#import "clients.typ": *
#import "links.typ": *
#import "misc.typ": *

#let icons = (
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => (
  cloud: cloud.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
  ),
  monitor: monitor.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  laptop: laptop.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  server: server.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  router: router.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  switch: switch.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  l3-switch: l3-switch.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
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
