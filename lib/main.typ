#import "util.typ": arrow, arrows, fill-def, stroke-def
#import "nodes.typ": *
#import "clients.typ": *
#import "links.typ": *
#import "misc.typ": *

#let icons = (
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) => (
  monitor: monitor.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  laptop: laptop.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  server: server.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  router: router.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  switch: switch.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
  l3-switch: l3-switch.with(
    stroke: stroke,
    fill: fill,
    stroke-inner: stroke-inner,
    fill-inner: fill-inner,
    flat: flat,
  ),
)
