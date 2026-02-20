#import "util.typ": *

#let globe = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
) => {}

#let cloud = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1, 0.75))
  // let y = y + sy / 3
  cetz.draw.group({
    cetz.draw.set-origin((x, y))
    cetz.draw.merge-path(stroke: stroke, fill: fill, {
      cetz.draw.hobby(
        (0, sy * 0.75),
        (sx * 0.5, sy),
        (sx * 0.75, sy * 0.5),
        omega: 1,
      )
      cetz.draw.hobby(
        (sx * 0.75, sy * 0.5),
        (sx, 0),
        (sx * 0.75, -sy * 0.5),
        omega: 1,
      )
      cetz.draw.hobby(
        (sx * 0.75, -sy * 0.5),
        (sx * 0.5, -sy),
        (0, -sy * 0.75),
        omega: 1,
      )
      cetz.draw.hobby(
        (0, -sy * 0.75),
        (-sx * 0.5, -sy),
        (-sx * 0.75, -sy * 0.5),
        omega: 1,
      )
      cetz.draw.hobby(
        (-sx * 0.75, -sy * 0.5),
        (-sx, 0),
        (-sx * 0.75, sy * 0.5),
        omega: 1,
      )
      cetz.draw.hobby(
        (-sx * 0.75, sy * 0.5),
        (-sx * 0.5, sy),
        (0, sy * 0.75),
        omega: 1,
      )
    })
  })
}

#let cloud2 = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1, 1))
  // let y = y + sy / 3
  let yoff = sy / 3
  cetz.draw.group({
    cetz.draw.set-origin((x, y))
    cetz.draw.merge-path(stroke: stroke, fill: fill, {
      cetz.draw.line((-sx * 0.75, yoff - sy), (sx * 0.75, yoff - sy))
      cetz.draw.arc(
        (sx * 0.75, yoff - sy),
        start: -90deg,
        delta: 180deg,
        radius: sx / 4,
      )
      cetz.draw.arc(
        (sx * 0.75, yoff - sy / 2),
        start: -35deg,
        delta: 200deg,
        radius: sx / 2,
      )
      cetz.draw.arc(
        (-sx * 0.15, yoff - sy * 0.15),
        start: 35deg,
        delta: 180deg,
        radius: sx / 3,
      )
      cetz.draw.arc(
        (-sx * 0.75, yoff - sy / 2),
        start: 90deg,
        delta: 180deg,
        radius: sx / 4,
      )
    })
  })
}

#let lock = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
) => {}

#let shield = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
) => {}
