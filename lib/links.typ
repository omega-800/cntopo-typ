#import "util.typ": *
#import "shapes.typ": *

// copypasta from cetz
#let first-subpath-closed(path) = {
  if path != () {
    let (_, closed, _) = path.first()
    return closed
  }
  return false
}
#let get-segments(ctx, target) = {
  if type(target) == array {
    assert.eq(
      target.len(),
      1,
      message: "Expected a single element, got " + str(target.len()),
    )
    target = target.first()
  }

  let (ctx, drawables, ..) = cetz.process.element(ctx, target)
  if drawables == none or drawables == () {
    return ()
  }

  let first = drawables.first()
  let closed = first-subpath-closed(first.segments)
  return (segments: first.segments, close: closed)
}

#let wireless-wave-link = (
  target,
  start: 1%,
  stop: 99%,
  rest: "LINE",
  width: 1,
  segments: 10,
  segment-length: none,
  align: "START",
  stroke: stroke-def,
  ..p,
) => cetz.draw.get-ctx(ctx => {
  // let (segments, close) = get-segments(ctx, target)

  // panic(segments, close.slice(1))
  // panic(p.pos().at(0).at(0)())
  // wireless-wave(segments.at(0).at(2).slice(1), stroke: stroke)
})

// #let link = (
//   stroke: stroke-def,
//   fill: fill-def,
//   stroke-inner: auto,
//   fill-inner: auto,
//   flat: true,
// ) => {}
//
// #let eth = (
//   stroke: stroke-def,
//   fill: fill-def,
//   stroke-inner: auto,
//   fill-inner: auto,
//   flat: true,
// ) => {}
//
// #let logic = (
//   stroke: stroke-def,
//   fill: fill-def,
//   stroke-inner: auto,
//   fill-inner: auto,
//   flat: true,
// ) => {}
//
