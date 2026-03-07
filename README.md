# cntopo-typ

## icons showcase

./examples/all-icons.pdf

## examples 

./examples/main.pdf

## usage

```typst
#import "@preview/cntopo:0.0.1": icons

#let (router, switch, l3-switch, server) = icons(stroke: blue, fill: white)

#cetz.canvas({
  router((0,0))
  switch((2,0))
  l3-switch((0,2))
  server((2,2))
})
```
