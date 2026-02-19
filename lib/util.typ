#import "@preview/cetz:0.4.1"

// TODO: reposition
#let to-3d = (is-flat, x, y) => {
  let mat = if is-flat {
    (
      (1, 0, 0, x),
      (0, 1, 0, -y),
      (0, 0, 1, 0),
      (0, 0, 0, 1),
    )
  } else {
    (
      (1, 0, 0, x),
      (0, 0.5, 0.5, -y - 0.25),
      (0, 0, 1, 0),
      (0, 0, 0, 1),
    )
  }
  let (xs, ys, _) = cetz.matrix.mul4x4-vec3(mat, (x, y, 0))
  cetz.draw.set-transform(mat)
  if not is-flat { cetz.draw.rotate(15deg) }
}
#let stroke-to-paint = s => if type(s) == stroke { s.paint } else { s }

#let resolve-pos = (pos, ds) => (
  pos.first(default: (0, 0)),
  pos.at(1, default: ds),
)
#let resolve-style = (s, _, stroke-inner, fill-inner) => (
  if stroke-inner == auto { stroke-to-paint(s) } else { stroke-inner },
  if fill-inner == auto { stroke-to-paint(s) } else {
    fill-inner
  },
)

#let stroke-def = black + 2pt
#let fill-def = white

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
