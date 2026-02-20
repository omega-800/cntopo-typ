#import "util.typ": *
#import "shapes.typ": *

#let node-classes = (
  "router": (sx, sy, stroke, fill) => {
    let arrs = (sx * 0.65, sy * 0.4)
    let arr = arrow.with(stroke: stroke, fill: fill)

    cetz.draw.rotate(45deg)
    arr((sx / 2, 0), arrs)
    cetz.draw.rotate(90deg)
    arr((-sx / 2, 0), arrs)
    cetz.draw.rotate(90deg)
    arr((sx / 2, 0), arrs)
    cetz.draw.rotate(90deg)
    arr((-sx / 2, 0), arrs)
  },
  "switch": (sx, sy, stroke, fill) => {
    let arrs = (sx * 0.75, sy * 0.4)
    let arr = arrow.with(stroke: stroke, fill: fill)

    arr((sx * 0.5, sy * 0.6), arrs)
    arr((sx * 0.25, -sy * 0.2), arrs)
    cetz.draw.rotate(180deg)
    arr((sx * 0.5, sy * 0.6), arrs)
    arr((sx * 0.25, -sy * 0.2), arrs)
    cetz.draw.rotate(135deg)
  },
  "l3-switch": (sx, sy, stroke, fill) => {
    let arrs = (sx * 0.5, sy * 0.3)
    let arr = arrow.with(stroke: stroke, fill: fill)

    cetz.draw.circle(
      (0, 0),
      radius: (sx * 0.35, sy * 0.35),
      stroke: stroke,
      fill: fill,
    )
    arr((sx * 0.6, 0), arrs)
    cetz.draw.rotate(45deg)
    arr((sx * 0.6, 0), arrs)
    cetz.draw.rotate(45deg)
    arr((sx * 0.6, 0), arrs)
    cetz.draw.rotate(45deg)
    arr((sx * 0.6, 0), arrs)
    cetz.draw.rotate(45deg)
    arr((sx * 0.6, 0), arrs)
    cetz.draw.rotate(45deg)
    arr((sx * 0.6, 0), arrs)
    cetz.draw.rotate(45deg)
    arr((sx * 0.6, 0), arrs)
    cetz.draw.rotate(45deg)
    arr((sx * 0.6, 0), arrs)
  },
)
#let node-container = (sx, sy, radius, stroke, fill) => {
  // TODO:
  // to-3d(flat, x, y)
  // cetz.draw.circle(
  //   (0, 0, 1),
  //   radius: (sx, sy),
  //   stroke: stroke,
  //   fill: fill,
  // )
  // TODO: angle
  // cetz.draw.line(
  //   (sx, 0, 1),
  //   (sx, 0, 0),
  //   (-sx, 0, 0),
  //   (-sx, 0, 1),
  //   fill: fill,
  //   stroke: stroke,
  // )

  // TODO:
  // to-3d(flat, x, y)
  // cetz.draw.rect(
  //   (-sx, -sy, 1),
  //   (sx, sy, 1),
  //   stroke: stroke,
  //   fill: fill,
  //   radius: 5pt,
  // )
  // TODO: radius
  // cetz.draw.line(
  //   (sx, sy, 0),
  //   (sx, sy, 1),
  //   (sx, -sy, 1),
  //   (sx, -sy, 0),
  //   (-sx, sy, 0),
  //   (-sx, sy, 1),
  //   fill: fill,
  //   stroke: stroke,
  // )
  cetz.draw.rect(
    (-sx, -sy),
    (sx, sy),
    stroke: stroke,
    fill: fill,
    radius: radius,
  )
}

#let node = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
  type: "default",
  label: none,
  class: "router",
  radius: auto,
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1, 1))
  let (stroke-i, fill-i) = resolve-style(
    stroke,
    fill,
    stroke-inner,
    fill-inner,
  )
  let radius = if radius == auto {
    if class == "router" { 50% } else { 5pt }
  } else { radius }

  cetz.draw.group({
    cetz.draw.set-origin((x, y))
    node-container(sx, sy, radius, stroke, fill)
    node-classes.at(class)(sx, sy, stroke-i, fill-i)
    if label != none {
      cetz.draw.content(((sx, -sy), 0%, (sx, sy)), label)
    }
  })
}

// type: "default" | "atm" | "wl"
#let router = node.with(class: "router")

// type: "default" | "atm" | "isdn" | "workgroup"
#let switch = node.with(class: "switch")

#let l3-switch = node.with(class: "l3-switch")

// type: "default" | "small" | "1000baset"
#let hub = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
  type: "default",
) => {}

#let bridge = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => {}

#let firewall = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => {}

#let ap = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => {}
