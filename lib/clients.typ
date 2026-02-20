#import "util.typ": *

#let laptop = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => {}

#let pc = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => {}

#let monitor = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1, 0.8))
  let (stroke-i, fill-i) = resolve-style(stroke, fill, stroke-inner, fill-inner)

  let rt = cetz.draw.rect.with(
    stroke: stroke,
    fill: fill,
  )
  let crc = cetz.draw.circle.with(
    stroke: stroke,
    fill: fill,
  )
  cetz.draw.group({
    cetz.draw.set-origin((x, y))
    rt(
      (-sx, -sy * 0.5),
      (sx, sy),
      radius: 5pt,
    )
    rt(
      (-sx*0.9, -sy * 0.4),
      (sx*0.9, sy * 0.9),
      fill: fill-i
      // radius: 5pt,
    )
    rt(
      (-sx*0.2, -sy * 0.5),
      (sx*0.2, -sy * 0.8),
    )
    rt(
      (-sx*0.5, -sy),
      (sx*0.5, -sy * 0.8),
      radius: 5pt,
    )
  })
}

#let printer = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => {}

#let phone = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => {}

#let mobile = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => {}

// type: "default" | "db" | "file" | "comm" | "secure" | "dns"
#let server = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
  type: "default",
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (0.5, 1))
  let (stroke-i, fill-i) = resolve-style(stroke, fill, stroke-inner, fill-inner)

  let rt = cetz.draw.rect.with(
    stroke: stroke,
    fill: fill,
  )
  let crc = cetz.draw.circle.with(
    stroke: stroke,
    fill: fill,
  )
  cetz.draw.group({
    cetz.draw.set-origin((x, y))
    rt(
      (-sx, sy * 0.55),
      (sx, sy),
      radius: (
        north-east: 5pt,
        north-west: 5pt,
      ),
    )
    rt(
      (sx, -sy * 0.4),
      (-sx, sy * 0.5),
    )
    crc((0, sy * 0.3), radius: (sx * 0.2, sy * 0.1))
    // FIXME:
    cetz.draw.line((0, sx * 0.6), (0, sx * 0.8), stroke: stroke)
    rt(
      (-sx, -sy * 0.7),
      (sx, -sy * 0.45),
    )
    rt(
      (-sx, -sy),
      (sx, -sy * 0.75),
      radius: (
        south-east: 5pt,
        south-west: 5pt,
      ),
    )
  })
}
