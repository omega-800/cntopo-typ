#import "@preview/tidy:0.4.3"
#import "/lib/main.typ" as cntopo
#import "/docs/style.typ"

#let show-module = module => tidy.show-module(
  tidy.parse-module(
    read("/lib/" + module + ".typ"),
    scope: (cntopo: cntopo),
    preamble: "
    #import cntopo: *
    #let (monitor, server, router, lock, cloud) = icons()
    ",
    // name: upper(module.first()) + lower(module.slice(1)),
  ),
  style: style,
  first-heading-level: 3,
  // show-module-name: false
)
