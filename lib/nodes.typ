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
#let node-container = (sx, sy, x, y, radius, stroke, fill, flat) => {
  let is-circle = radius > 40%
  if not flat {
    to-3d(x, y, is-circle)
    let l = if is-circle {
      (
        (sx, sy * 1 / 8, 1),
        (sx, 0, 0),
        (-sx, 0, 0),
        (-sx, sy * 1 / 8, 1),
      )
    } else {
      (
        (sx, sy, 0),
        (sx, sy, 1),
        (sx, -sy, 1),
        (sx, -sy, 0),
        (-sx, sy, 0),
        (-sx, sy, 1),
      )
    }
    let s = to-stroke(stroke)
    cetz.draw.rect(
      (-sx, -sy, 1),
      (sx, sy, 1),
      stroke: stroke,
      fill: fill,
      radius: radius,
    )
    cetz.draw.line(
      ..l,
      fill: fill,
      stroke: (
        paint: s.paint,
        thickness: if s.thickness == auto { 1pt } else { s.thickness },
        cap: s.cap,
        join: "miter",
        dash: s.dash,
        miter-limit: 1,
      ),
    )
  }
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
  detail: none,
  label: none,
  label-pos: bottom,
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
    if class == "router" { 50% } else { 5% }
  } else { radius }
  let is-circle = radius > 40%
  let (sx-i, sy-i) = if detail != none and flat {
    (sx * 3 / 4, sy * 3 / 4)
  } else {
    (sx, sy)
  }
  let off-i = if detail != none and flat { y * 1 / 25 } else { 0 }

  cetz.draw.group({
    cetz.draw.set-origin((x, y))
    cetz.draw.group({
      node-container(sx, sy, x, y, radius, stroke, fill, flat)
      cetz.draw.group({
        cetz.draw.set-origin((0, off-i))
        node-classes.at(class)(sx-i, sy-i, stroke-i, fill-i)
      })
    })

    // TODO: label-pos
    // FIXME: label absolute gap instead of relative
    if label != none {
      let pos = if flat {
        (0, -sy * 6 / 5)
      } else {
        (if is-circle { 0 } else { -sx * 1 / 5 }, -sy * 4 / 5)
      }
      cetz.draw.content(pos, label)
    }

    if detail != none {
      let pos = if flat {
        (0, -sy * 3 / 4)
      } else {
        (if is-circle { 0 } else { -sx * 1 / 5 }, -sy * 2 / 5)
      }
      if type(detail) == str and detail in node-classes {
        cetz.draw.group({
          cetz.draw.set-origin(pos)
          node-classes.at(detail)(sx * .25, sy * .25, stroke-i, fill-i)
        })
      } else {
        cetz.draw.content(
          pos,
          text(fill: fill-inner, weight: "bold", detail),
        )
      }
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
