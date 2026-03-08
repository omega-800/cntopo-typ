#import "deps.typ": *

#let lbl = (
  label,
  // TODO:
  label-pos,
  sx,
  sy,
) => if label != none {
  cetz.draw.content(((sx, -sy), 0%, (sx, sy)), label)
} else {}

#let to-3d = (flat, shape, c) => {
  let circle = shape == "hex" or shape == "circle"
  let off = if shape == "rect" { 1.08 } else { 1 }
  if flat { c } else if circle {
    cetz.draw.translate(y: .25)
    cetz.draw.scale(y: 64%)
    cetz.draw.ortho(
      x: 60deg,
      y: 0deg,
      z: 0deg,
      sorted: false,
      c,
    )
  } else {
    cetz.draw.translate(y: .25)
    cetz.draw.scale(x: 84% * off, y: 50%)
    cetz.draw.rotate(x: -17deg * off, y: -6deg * off)
    cetz.draw.ortho(
      x: 60deg,
      y: -11deg,
      z: -10deg,
      sorted: false,
      c,
    )
  }
}

// FIXME: fletcher doesn't provide x,y pos
// #let to-3d = (x, y, circle) => {
// let (yn, xn) = if circle { (0, 1) } else { (1 / 4, 3 / 4) }
// let mat = (
//   (xn, yn, 0, x),
//   (0, -3 / 8, 1 / 2, -y - 1 / 4),
//   (0, 0, 1, 0),
//   (0, 0, 0, 1),
// )
// cetz.draw.set-transform(mat)
// }
#let stroke-to-paint = s => if type(s) == stroke { s.paint } else { s }
#let to-stroke = s => if type(s) == stroke { s } else { (paint: s) }
#let override-stroke = (s, ..o) => {
  let s-dict = if type(s) == stroke {
    (
      paint: s.paint,
      thickness: s.thickness,
      cap: s.cap,
      join: s.join,
      dash: s.dash,
      miter-limit: s.miter-limit,
    )
  } else { (paint: s) }
  (:..s-dict, ..o.named())
}

#let resolve-pos = (pos, (dsx, dsy)) => {
  let s = pos.at(1, default: (dsx, dsy))
  let size = if type(s) == array { s } else { (s * dsx, s * dsy) }
  (
    pos.first(default: (0, 0)),
    size,
  )
}
#let resolve-style = (s, _, stroke-inner, fill-inner) => (
  if stroke-inner == auto { stroke-to-paint(s) } else { stroke-inner },
  if fill-inner == auto { stroke-to-paint(s) } else {
    fill-inner
  },
)

#let stroke-def = black + 2pt
#let fill-def = white
