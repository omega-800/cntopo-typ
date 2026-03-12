#import "util.typ": fill-def, stroke-def
#import "shapes.typ": *
#import "nodes.typ": *
#import "clients.typ": *
#import "links.typ": *
#import "misc.typ": *

/// Default node icons
///
/// ```example
///   TODO
/// ```
///
/// -> dict
#let default-nodes = (
  router: node.with(class: "router"),
  wl-router: node.with(class: "router", shape: "hex"),
  switch: node.with(class: "switch"),
  l3-switch: node.with(class: "l3-switch"),
  ap: node.with(class: "ap"),
  dual-ap: node.with(class: "dual-ap"),
  // mesh-ap: node.with(class: "mesh-ap"),
  hub: node.with(class: "hub"),
  fe-hub: node.with(class: "fe-hub"),
)

/// Icon presets
///
/// ```example
///   TODO
/// ```
///
/// -> dict
#let icon-presets = (
  default-nodes
    .pairs()
    .map(((k, v)) => (
      (k, v),
      ("w-" + k, v.with(wireless: true)),

      ("sec-" + k, v.with(detail: "secure")),
      ("w-sec-" + k, v.with(detail: "secure", wireless: true)),

      ("cl-" + k, v.with(detail: "cloud")),
      ("w-cl-" + k, v.with(detail: "cloud", wireless: true)),
    ))
    .join()
    .to-dict()
    + (
      bridge: node.with(shape: "bridge", class: none),
      sec-bridge: node.with(shape: "bridge", class: none, detail: "secure"),
      bridge-ap: node.with(shape: "bridge", class: "ap"),
      firewall: node.with(shape: "firewall", class: none),
      cl-firewall: node.with(shape: "firewall", class: "cloud"),
      sec-firewall: node.with(shape: "firewall", class: "secure"),
      // clients
      monitor: monitor,
      // laptop: laptop,
      server: server,
      // misc
      cloud: cloud,
      lock: lock,
    )
)

/// Applies styling to all of the CeTZ icons
///
/// ```example
///   TODO
/// ```
///
/// -> dict
#let icons(
  stroke: stroke-def,
  fill: fill-def,
  stroke-inner: auto,
  fill-inner: auto,
  flat: true,
) = (
  icon-presets
    .pairs()
    .map(((k, v)) => (
      k,
      v.with(
        stroke: stroke,
        fill: fill,
        stroke-inner: stroke-inner,
        fill-inner: fill-inner,
        flat: flat,
      ),
    ))
    .to-dict()
)

/// Helper function to convert the CeTZ icons to Fletcher shapes
///
/// ```example
///   TODO
/// ```
///
/// -> dict
#let to-fletcher-shapes(
  /// CeTZ icons
  /// -> TODO
  i,
) = (
  i
    .pairs()
    .map(((k, v)) => (
      k,
      (node, extrude, ..extra) => {
        let (xr, yr) = if k in ratios {
          ratios.at(k)
        } else { (1, 1) }
        let (xs, ys) = node.size.map(i => i / 2 + extrude)
        v(
          (0, 0),
          // node.pos.uv,
          (xr * xs, yr * ys),
          ..extra.named(),
          ..(
            if "override-color" in extra.named()
              and extra.named().override-color {
              (
                stroke: node.stroke,
                fill: node.fill,
                fill-inner: stroke-to-paint(node.stroke),
                stroke-inner: node.stroke,
              )
            } else {
              (:)
            }
          ),
        )
      },
    ))
    .to-dict()
)

/// Shapes to use in Fletcher diagrams.
///
/// ```example
///  #import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
///  #diagram(node((0,0), "TO"), edge("->"), node((2,0), "DO"))
/// ```
///
/// -> dict
#let fletcher-shapes(
  /// The same args as in icons
  /// -> TODO
  ..args,
) = to-fletcher-shapes(icons(..args.named()))
