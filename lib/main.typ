#import "@preview/cetz:0.4.2"

#let stroke-def = black + 2pt
#let fill-def = white
#let fill2-def = black

/* util */

#let arrow = (
  ..pos,
  dir: ltr,
  connect: true,
  ratio-tail: 3 / 5,
  ratio-head: 2 / 3,
  stroke: stroke-def,
  fill: fill-def,
) => {
  let (x, y) = pos.pos().first(default: (0, 0))
  let (sx, sy) = pos.pos().at(1, default: (1, 0.5))
  let sxh = sx / 2
  let sxm = sx / 2 * (1 - ratio-head)

  let syh = sy / 2
  let sym = sy / 2 * (1 - ratio-head)

  // let ((x1,x2,x3),(y1,y2,y3)) = if dir == ltr {
  //   ((0,sxf,sx),(sym,syh,0))
  // } else if dir == rtl {
  //   ((sx,sxb,0),(sym,syh,0))
  // } else if dir == ttb {
  //   ((sxm,sxh,0),(sy,syb,0))
  // } else if dir == btt {
  //   ((sxm,sxh,0),(y,syf,sy))
  // }
  // cetz.draw.line(
  //   (x + x1, y + y1),
  //   (x + x2, y + y1),
  //   (x + x2, y + y2),
  //   (x + x3, y + y3),
  //   (x + x2, y - y2),
  //   (x + x2, y - y1),
  //   (x + x1, y - y1),
  //   (x + x1, y + y1),
  // )
  //
  let lin = cetz.draw.line.with(stroke: stroke, fill: fill)
  if dir == ltr {
    let sxf = sx * ratio-tail
    let x = x - sx / 2
    lin(
      (x, y + sym),
      (x + sxf, y + sym),
      (x + sxf, y + syh),
      (x + sx, y),
      (x + sxf, y - syh),
      (x + sxf, y - sym),
      (x, y - sym),
      if connect { (x, y + sym) } else { () },
    )
  } else if dir == rtl {
    let sxf = sx - sx * ratio-tail
    let x = x - sx / 2
    lin(
      (x + sx, y + sym),
      (x + sxf, y + sym),
      (x + sxf, y + syh),
      (x, y),
      (x + sxf, y - syh),
      (x + sxf, y - sym),
      (x + sx, y - sym),
      if connect { (x + sx, y + sym) } else { () },
    )
  } else if dir == ttb {
    let y = y - sy / 2
    let syf = sy - sy * ratio-tail
    lin(
      (x + sxm, y + sy),
      (x + sxm, y + syf),
      (x + sxh, y + syf),
      (x, y),
      (x - sxh, y + syf),
      (x - sxm, y + syf),
      (x - sxm, y + sy),
      if connect { (x + sxm, y + sy) } else { () },
    )
  } else if dir == btt {
    let y = y - sy / 2
    let syf = sy * ratio-tail
    lin(
      (x + sxm, y),
      (x + sxm, y + syf),
      (x + sxh, y + syf),
      (x, y + sy),
      (x - sxh, y + syf),
      (x - sxm, y + syf),
      (x - sxm, y),
      if connect { (x + sxm, y) } else { () },
    )
  }
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
  let (x, y) = pos.pos().first(default: (0, 0))
  let (sx, sy) = pos.pos().at(1, default: (1.5, 0.6))
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

/* nodes */

// type: "default" | "atm" | "wl"
#let router = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
  type: "default",
) => {
  let (x, y) = pos.pos().first(default: (0, 0))
  let (sx, sy) = pos.pos().at(1, default: (1, 1))
  let arrs = (sx * 0.65, sy * 0.4)
  let arr = arrow.with(stroke: stroke, fill: fill2)

  cetz.draw.group({
    cetz.draw.set-origin((x, y))
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
  fill2: fill2-def,
  flat: true,
  type: "default",
) => {
  let (x, y) = pos.pos().first(default: (0, 0))
  let (sx, sy) = pos.pos().at(1, default: (1, 1))
  let arr = arrow.with(stroke: stroke, fill: fill2)
  let arrs = (sx * 0.75, sy * 0.4)

  cetz.draw.group({
    cetz.draw.set-origin((x, y))
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
  fill2: fill2-def,
  flat: true,
  type: "default",
) => {
  let (x, y) = pos.pos().first(default: (0, 0))
  let (sx, sy) = pos.pos().at(1, default: (1, 1))
  let arr = arrow.with(stroke: stroke, fill: fill2)
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
      fill: fill2,
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
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
  type: "default",
) => {}

#let bridge = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let firewall = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let ap = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}

/* clients */
#let laptop = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let pc = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let monitor = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {
  let (x, y) = pos.pos().first(default: (0, 0))
  let (sx, sy) = pos.pos().at(1, default: (1, 0.8))
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
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let phone = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let mobile = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
// type: "default" | "db" | "file" | "comm" | "secure" | "dns"
#let server = (
  ..pos,
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
  type: "default",
) => {
  let (x, y) = pos.pos().first(default: (0, 0))
  let (sx, sy) = pos.pos().at(1, default: (0.5, 1))
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

/* links */
#let link = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let eth = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let logic = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}

/* misc */
#let globe = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let cloud = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let lock = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}
#let shield = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => {}

#let icons = (
  stroke: stroke-def,
  fill: fill-def,
  fill2: fill2-def,
  flat: true,
) => (
  monitor: monitor.with(stroke: stroke, fill: fill, fill2: fill2, flat: flat),
  laptop: laptop.with(stroke: stroke, fill: fill, fill2: fill2, flat: flat),
  server: server.with(stroke: stroke, fill: fill, fill2: fill2, flat: flat),
  router: router.with(stroke: stroke, fill: fill, fill2: fill2, flat: flat),
  switch: switch.with(stroke: stroke, fill: fill, fill2: fill2, flat: flat),
  l3-switch: l3-switch.with(
    stroke: stroke,
    fill: fill,
    fill2: fill2,
    flat: flat,
  ),
)
