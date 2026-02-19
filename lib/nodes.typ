#import "util.typ": *

// type: "default" | "atm" | "wl"
#let router = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
  type: "default",
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1, 1))
  let arrs = (sx * 0.65, sy * 0.4)
  let (stroke-i, fill-i) = resolve-style(stroke, fill, stroke-inner, fill-inner)
  let arr = arrow.with(stroke: stroke-i, fill: fill-i)

  cetz.draw.group({
    to-3d(flat, x, y)

    cetz.draw.circle(
      (0, 0, 1),
      radius: (sx, sy),
      stroke: stroke,
      fill: fill,
    )
    // TODO: angle
    cetz.draw.line(
      (sx, 0, 1),
      (sx, 0, 0),
      (-sx, 0, 0),
      (-sx, 0, 1),
      fill: fill,
      stroke: stroke,
    )
    cetz.draw.circle((0, 0), radius: (sx, sy), stroke: stroke, fill: fill)
    cetz.draw.rotate(45deg)
    arr((sx / 2, 0), arrs)
    cetz.draw.rotate(90deg)
    arr((-sx / 2, 0), arrs)
    cetz.draw.rotate(90deg)
    arr((sx / 2, 0), arrs)
    cetz.draw.rotate(90deg)
    arr((-sx / 2, 0), arrs)
  })
}

// type: "default" | "atm" | "isdn" | "workgroup"
#let switch = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
  type: "default",
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1, 1))
  let (stroke-i, fill-i) = resolve-style(stroke, fill, stroke-inner, fill-inner)

  let arr = arrow.with(stroke: stroke-i, fill: fill-i)
  let arrs = (sx * 0.75, sy * 0.4)

  cetz.draw.group({
    to-3d(flat, x, y)
    cetz.draw.rect(
      (-sx, -sy, 1),
      (sx, sy, 1),
      stroke: stroke,
      fill: fill,
      radius: 5pt,
    )
    // TODO: radius
    cetz.draw.line(
      (sx, sy, 0),
      (sx, sy, 1),
      (sx, -sy, 1),
      (sx, -sy, 0),
      (-sx, sy, 0),
      (-sx, sy, 1),
      fill: fill,
      stroke: stroke,
    )
    cetz.draw.rect(
      (-sx, -sy),
      (sx, sy),
      stroke: stroke,
      fill: fill,
      radius: 5pt,
    )
    arr((sx * 0.5, sy * 0.6), arrs)
    arr((sx * 0.25, -sy * 0.2), arrs)
    cetz.draw.rotate(180deg)
    arr((sx * 0.5, sy * 0.6), arrs)
    arr((sx * 0.25, -sy * 0.2), arrs)
  })
}

#let l3-switch = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
  type: "default",
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1, 1))
  let (stroke-i, fill-i) = resolve-style(stroke, fill, stroke-inner, fill-inner)
  let arr = arrow.with(stroke: stroke-i, fill: fill-i)
  let arrs = (sx * 0.5, sy * 0.3)

  cetz.draw.group({
    cetz.draw.set-origin((x, y))
    cetz.draw.rect(
      (-sx, -sy),
      (sx, sy),
      stroke: stroke,
      fill: fill,
      radius: 5pt,
    )
    cetz.draw.circle(
      (0, 0),
      radius: (sx * 0.35, sy * 0.35),
      stroke: stroke,
      fill: fill-i,
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
  })
}

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
