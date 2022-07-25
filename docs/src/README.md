# NonlinearSequences.jl

Nonlinearly spaced values in Julia with ergonomic APIs. Currently supports
logarithmic and power function spacing. 

## Installation

The package is currently not registered, so you'll have to install it from
GitHub. Open a Julia REPL and run:

```
]add https://github.com/Firionus/NonlinearSequences.jl
```

This package is quite new. It is recommended to only use it for non-critical
applications. 

## Function Overview

- [`logspace`](@ref): logarithmically spaced values
- [`octspace`](@ref): logarithmically spaced values with step in octaves
- [`decspace`](@ref): logarithmically spaced values with step in decades
- [`powspace`](@ref): values spaced by power function

## API Reference

```@docs
logspace
octspace
decspace
powspace
```

## Development

Feedback on the design of the package, feature requests or bug reports are
welcome! Just [open an
issue](https://github.com/Firionus/NonlinearSequences.jl/issues/new). 

Possible ideas for the future include:
- lazy computation
- improving the API
- other nonlinear spacings
- reducing code bulk while keeping the ergonomic API
- improving performance
- more control over the output type
- integration into a bigger package or splitting into even smaller packages

If you want to know more about the status of these future ideas or want to
discuss, please look at the
[issues](https://github.com/Firionus/NonlinearSequences.jl/issues).