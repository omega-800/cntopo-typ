// #import "util.typ": *
// #import "shapes.typ": *
//
// #let wireless-wave-link = (
//   target,
//   start: 1%,
//   stop: 99%,
//   rest: "LINE",
//   width: 1,
//   segments: 10,
//   segment-length: none,
//   align: "START",
//   stroke: stroke-def,
//   ..p,
// ) => cetz.draw.get-ctx(ctx => {
//   let (segments, close) = get-segments(ctx, target)
//   wireless-wave(segments.at(0).at(2).slice(1), stroke: stroke)
// })
