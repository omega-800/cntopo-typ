# cntopo-typ

## examples 

./examples/main.pdf

## usage

```typst
#import "@preview/cntopo:0.0.1": icons

#let (router, switch, l3-switch, server) = icons(stroke: blue, fill: white)

#cetz.canvas({
  router()
  switch()
  l3-switch()
  server()
})
```
