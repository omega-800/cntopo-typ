#import "deps.typ": *

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
