#import "util.typ": *
#import "shapes.typ": *
#import "misc.typ": *

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
  "hub": (sx, sy, stroke, fill) => {
    arrows((0, 0), (sx * 1.6, sy), stroke: stroke, fill: fill, type: "two")
  },
  "fe-hub": (sx, sy, stroke, fill) => {
    // TODO: standardized licon sizes
    arrow((0, 0), (sx * 1.6, sy), stroke: stroke, fill: fill)
  },
  "l3-switch": (sx, sy, stroke, fill) => {
    let arrs = (sx * 0.5, sy * 0.3)
    let arrp = (sx * 0.6, 0)
    let arr = arrow.with(stroke: stroke, fill: fill)

    cetz.draw.circle(
      (0, 0),
      radius: (sx * 0.35, sy * 0.35),
      stroke: stroke,
      fill: fill,
    )
    arr(arrp, arrs)
    cetz.draw.rotate(45deg)
    arr(arrp, arrs)
    cetz.draw.rotate(45deg)
    arr(arrp, arrs)
    cetz.draw.rotate(45deg)
    arr(arrp, arrs)
    cetz.draw.rotate(45deg)
    arr(arrp, arrs)
    cetz.draw.rotate(45deg)
    arr(arrp, arrs)
    cetz.draw.rotate(45deg)
    arr(arrp, arrs)
    cetz.draw.rotate(45deg)
    arr(arrp, arrs)
  },
  "ap": (sx, sy, stroke, fill) => {
    wireless-wave((0, -sy * 2 / 7), (sx * 0.8, sy * .1), stroke: stroke)
  },
  "dual-ap": (sx, sy, stroke, fill) => {
    wireless-wave((0, -sy * 2 / 7), (sx * 0.8, sy * .1), stroke: stroke)
    wireless-wave((0, sy * 2 / 7), (sx * 0.8, sy * .1), stroke: stroke)
  },
  "mesh-ap": (sx, sy, stroke, fill) => {
    cetz.draw.content((0, sy * 2 / 7), text(
      fill: stroke-to-paint(stroke),
      // weight: "bold",
      // TODO: dynamic font size
      size: 2em,
      // FIXME: skew text?
    )[MESH])
    wireless-wave((0, -sy * 2 / 7), (sx * 0.8, sy * .1), stroke: stroke)
  },
)
#let node-details = (
  "secure": (sx, sy, stroke-i, fill-i, stroke, fill) => {
    lock(
      (0, 0),
      (sx, sy),
      stroke: fill,
      fill: fill-i,
      stroke-inner: stroke-i,
      fill-inner: fill,
    )
  },
  "cloud": (sx, sy, stroke-i, fill-i, stroke, fill) => {
    cloud(
      (0, 0),
      (sx, sy),
      stroke: fill,
      fill: fill-i,
      stroke-inner: stroke-i,
      fill-inner: fill,
    )
  },
)
#let node-containers = (
  "circle": (sx, sy, radius, stroke, fill, flat) => {
    if not flat {
      cetz.draw.circle(
        (0, 0, 1),
        radius: (sx, sy),
        stroke: stroke,
        fill: fill,
      )
      cetz.draw.line(
        (sx, sy * 1 / 8, 1),
        (sx, 0, 0),
        (-sx, 0, 0),
        (-sx, sy * 1 / 8, 1),
        fill: fill,
        stroke: stroke,
      )
    }
    cetz.draw.circle(
      (0, 0),
      radius: (sx, sy),
      stroke: stroke,
      fill: fill,
    )
  },
  "hex": (sx, sy, radius, stroke, fill, flat) => {
    if not flat {
      cetz.draw.line(
        (-sx, 0, 0),
        (-sx, 0, 1),
        (-sx, sy * 1 / 8, 1),
        (-sx / 2, -sy, 1),
        (sx / 2, -sy, 1),
        (sx, sy * 1 / 8, 1),
        (sx, 0, 0),
        fill: fill,
        stroke: stroke,
      )
    }
    cetz.draw.polygon(
      (0, 0),
      6,
      stroke: stroke,
      fill: fill,
    )
  },
  "square": (sx, sy, radius, stroke, fill, flat) => {
    if not flat {
      cetz.draw.line(
        (sx, sy, 0),
        (sx, sy, 1),
        (sx, -sy, 1),
        (-sx, -sy, 1),
        (-sx, -sy, 0),
        (-sx, 0, 0),
        fill: fill,
        stroke: stroke,
      )
      cetz.draw.line(
        stroke: stroke,
        (sx, -sy, 1),
        (sx, -sy, 0),
        (-sx, 0, 0),
      )
    }

    cetz.draw.rect(
      (-sx, -sy),
      (sx, sy),
      stroke: stroke,
      fill: fill,
      radius: radius,
    )
  },
  "rect": (sx, sy, radius, stroke, fill, flat) => {
    if not flat {
      cetz.draw.line(
        (sx, sy * 2 / 3, 0),
        (sx, sy * 2 / 3, 1),
        (sx, -sy * 2 / 3, 1),
        (-sx, -sy * 2 / 3, 1),
        (-sx, -sy * 2 / 3, 0),
        (-sx, 0, 0),
        fill: fill,
        stroke: stroke,
      )
      cetz.draw.line(
        stroke: stroke,
        (sx, -sy * 2 / 3, 1),
        (sx, -sy * 2 / 3, 0),
        (-sx, 0, 0),
      )
    }

    cetz.draw.rect(
      (-sx, -sy * 2 / 3),
      (sx, sy * 2 / 3),
      stroke: stroke,
      fill: fill,
      radius: radius,
    )
  },
)

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
  shape: auto,
  radius: auto,
  wireless: false,
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1, 1))
  let (stroke-i, fill-i) = resolve-style(
    stroke,
    fill,
    stroke-inner,
    fill-inner,
  )
  let radius = if radius == auto {
    if class == "router" { 0% } else { 5% }
  } else { radius }

  let shape = if shape == auto {
    if class == "router" {
      // FIXME: janky api
      if detail == "wavelength" { "hex" } else { "circle" }
    } else if class.ends-with("ap") { "rect" } else { "square" }
  } else { shape }

  let is-circle = shape == "hex" or shape == "circle"
  let (sx-i, sy-i) = if detail != none and flat {
    // TODO: do not transform switch arrows
    (
      if class == "switch" or class.ends-with("hub") or class.ends-with("ap") {
        sx
      } else { sx * 3 / 4 },
      sy * 3 / 4,
    )
  } else {
    (sx, sy)
  }
  let off-i = if detail != none and flat { sy / 6 } else { 0 }

  cetz.draw.group({
    cetz.draw.set-origin((x, y))
    if wireless {
      if is-circle {
        antennas((0, 0), (sx, sy), stroke: stroke-to-paint(stroke))
      } else {
        antennas(
          (sx * 1 / 4, 0),
          (sx, sy),
          stroke: stroke-to-paint(stroke),
          spacing: sx,
        )
      }
    }
    cetz.draw.group({
      // if not flat { to-3d(x, y, is-circle) }
      to-3d(flat, shape, {
        node-containers.at(shape)(sx, sy, radius, stroke, fill, flat)
        cetz.draw.group({
          cetz.draw.set-origin((0, off-i))
          node-classes.at(class)(sx-i, sy-i, stroke-i, fill-i)
        })
      })
    })

    // TODO: label-pos
    // FIXME: label absolute gap instead of relative
    if label != none {
      let x = if label-pos.x == none {
        if flat or is-circle { 0 } else if label-pos.y == top {
          sx * 1 / 5
        } else {
          -sx * 1 / 5
        }
      } else if label-pos.x == left { -sx } else { sx }
      let y = if label-pos.y == none {
        0
      } else {
        (
          // FIXME: should be relative to label, not icon size
          (if flat { sy * 6 / 5 } else { sy * 4 / 5 })
            * (if label-pos.y == top { 1 } else { -1 })
        )
      }
      let pos = (x, y)
      // let pos = if flat {
      //   (0, -sy * 6 / 5)
      // } else {
      //   (if is-circle { 0 } else { -sx * 1 / 5 }, -sy)
      // }
      let anchor-y = if label-pos.y == top {
        "south"
      } else if label-pos.y == bottom { "north" } else { none }
      let anchor-x = if label-pos.x == left {
        "east"
      } else if label-pos.x == right { "west" } else { none }
      // TODO: proper anchor
      cetz.draw.content(pos, label, anchor: if anchor-y != none {
        anchor-y
      } else { anchor-x })
    }

    if detail != none {
      let pos = if flat {
        (0, -sy * 11 / 16)
      } else {
        (if is-circle { 0 } else { -sx / 4 }, -sy * 3 / 8)
      }
      if type(detail) == str and detail in node-details {
        cetz.draw.group({
          cetz.draw.set-origin(pos)
          node-details.at(detail)(
            sx * .2,
            sy * .2,
            stroke-i,
            fill-i,
            stroke,
            fill,
          )
        })
      } else if type(detail) == str and detail in node-classes {
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
