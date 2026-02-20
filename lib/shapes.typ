#import "util.typ": *

#let arrow = (
  ..pos,
  dir: ltr,
  connect: true,
  ratio-tail: 3 / 5,
  ratio-head: 2 / 3,
  stroke: stroke-def,
  fill: fill-def,
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1, 0.5))

  let sxh = sx / 2
  let sxm = sx / 2 * (1 - ratio-head)

  let syh = sy / 2
  let sym = sy / 2 * (1 - ratio-head)

  let lin = cetz.draw.line.with(stroke: stroke, fill: fill)
  cetz.draw.group({
    if dir == ltr {
      let sxf = sx * ratio-tail
      let x = x - sx / 2
      cetz.draw.set-origin((x, y))
      lin(
        (0, sym),
        (sxf, sym),
        (sxf, syh),
        (sx, 0),
        (sxf, -syh),
        (sxf, -sym),
        (0, -sym),
        if connect { (0, sym) } else { () },
      )
    } else if dir == rtl {
      let sxf = sx - sx * ratio-tail
      let x = x - sx / 2
      cetz.draw.set-origin((x, y))
      lin(
        (sx, sym),
        (sxf, sym),
        (sxf, syh),
        (0, 0),
        (sxf, -syh),
        (sxf, -sym),
        (sx, -sym),
        if connect { (sx, sym) } else { () },
      )
    } else if dir == ttb {
      let syf = sy - sy * ratio-tail
      let y = y - sy / 2
      cetz.draw.set-origin((x, y))
      lin(
        (sxm, sy),
        (sxm, syf),
        (sxh, syf),
        (0, 0),
        (-sxh, syf),
        (-sxm, syf),
        (-sxm, sy),
        if connect { (sxm, sy) } else { () },
      )
    } else if dir == btt {
      let syf = sy * ratio-tail
      let y = y - sy / 2
      cetz.draw.set-origin((x, y))
      lin(
        (sxm, 0),
        (sxm, syf),
        (sxh, syf),
        (0, sy),
        (-sxh, syf),
        (-sxm, syf),
        (-sxm, 0),
        if connect { (sxm, 0) } else { () },
      )
    }
  })
}
// type: "cross" | "two" | "two-v"
#let arrows = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  type: "cross",
  ratio-tail: 3 / 5,
  ratio-head: 2 / 3,
) => {
  let ((x, y), (sx, sy)) = resolve-pos(pos.pos(), (1.5, 0.6))
  let sdy = (sy - sy * ratio-head) / 4
  let sdx = (sx - sx * ratio-head) / 4
  let arr = arrow.with(
    connect: false,
    ratio-tail: ratio-tail,
    ratio-head: ratio-head,
    stroke: stroke,
    fill: fill,
  )
  if type == "cross" {
    arr(
      (x + sx / 4 + sdx / 2, y),
      (sx / 2 - sdx, sy / 2),
      dir: ltr,
    )
    arr(
      (x - sx / 4 - sdx / 2, y),
      (sx / 2 - sdx, sy / 2),
      dir: rtl,
    )
    arr(
      (x, y + sy / 4 + sdy / 2),
      (sx / 2, sy / 2 - sdy),
      dir: btt,
    )
    arr(
      (x, y - sy / 4 - sdy / 2),
      (sx / 2, sy / 2 - sdy),
      dir: ttb,
    )
  } else {
    if type == "two-v" {
      arr(
        (x, y + sy / 4),
        (sx / 2, sy / 2),
        dir: btt,
      )
      arr(
        (x, y - sy / 4),
        (sx / 2, sy / 2),
        dir: ttb,
      )
    } else {
      arr(
        (x + sx / 4, y),
        (sx / 2, sy / 2),
        dir: ltr,
      )
      arr(
        (x - sx / 4, y),
        (sx / 2, sy / 2),
        dir: rtl,
      )
    }
  }
}

