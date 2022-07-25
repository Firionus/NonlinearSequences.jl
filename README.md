
<a id='NonlinearSequences.jl'></a>

<a id='NonlinearSequences.jl-1'></a>

# NonlinearSequences.jl


Nonlinearly spaced values in Julia with ergonomic APIs. Currently supports logarithmic and power function spacing. 


<a id='Installation'></a>

<a id='Installation-1'></a>

## Installation


The package is currently not registered, so you'll have to install it from GitHub. Open a Julia REPL and run:


```
]add https://github.com/Firionus/NonlinearSequences.jl
```


This package is quite new. It is recommended to only use it for non-critical applications. 


<a id='Getting-Started'></a>

<a id='Getting-Started-1'></a>

## Getting Started


```julia-repl
julia> using NonlinearSequences

julia> logspace(20, 40, length=4)
4-element Vector{Float64}:
 19.999999999999996
 25.198420997897465
 31.748021039363984
 40.0
```


<a id='Function-Overview'></a>

<a id='Function-Overview-1'></a>

## Function Overview


  * [`logspace`](#NonlinearSequences.logspace): logarithmically spaced values
  * [`octspace`](#NonlinearSequences.octspace): logarithmically spaced values with step in octaves
  * [`decspace`](#NonlinearSequences.decspace): logarithmically spaced values with step in decades
  * [`powspace`](#NonlinearSequences.powspace): values spaced by power function


<a id='API-Reference'></a>

<a id='API-Reference-1'></a>

## API Reference

<a id='NonlinearSequences.logspace' href='#NonlinearSequences.logspace'>#</a>
**`NonlinearSequences.logspace`** &mdash; *Function*.



```julia
logspace(start, stop, length)
logspace(start, stop; length, step, base, adjust_step)
logspace(start; stop, length, step, base, adjust_step)
logspace(; start, stop, length, step, base, adjust_step)
```

Returns an array of logarithmically spaced values. 

All arguments can be provided as keyword arguments. Additionally, `start`, `stop` and `length` can be provided as positional arguments. 

4 different combinations of arguments are valid:

  * `start`, `stop` and `length`: `length` many values from `start` to `stop`.
  * `start`, `stop`, `step` and `base`: values from `start` up to `stop` whose logarithms of base `base` are spaced linearly with `step`. By default, the step size is obeyed and values may end before `stop`. To adjust the step to reach `stop` precisely, set `adjust_step=true`.
  * `start`, `step`, `base`, `length`: `length` many values starting at `start` whose logarithms of base `base` are spaced linearly with `step`.
  * `stop`, `step`, `base`, `length`: `length` many values ending at `stop` whose logarithms of base `base` are spaced linearly with `step`.

**Examples**

```julia-repl
julia> logspace(1, 2, 3)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(1, 2.1, step=1/2, base=2)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(1, 2.1, step=1/2, base=2, adjust_step=true)
3-element Vector{Float64}:
 1.0
 1.449137674618944
 2.1

julia> logspace(1, step=1/2, base=2, length=3)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(stop=2, step=1/2, base=2, length=3)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(start=1, stop=2, length=3)
3-element Vector{Float64}:
 1.0
 1.414213562373095
 2.0

julia> logspace(stop=1, step=-1/2, base=2, length=3)
3-element Vector{Float64}:
 2.0
 1.414213562373095
 1.0
```


<a target='_blank' href='https://github.com/Firionus/NonlinearSequences.jl/blob/e775f6fdec0be12404a6890d388066be2f9466ee/src/logspace.jl#L1-L67' class='documenter-source'>source</a><br>

<a id='NonlinearSequences.octspace' href='#NonlinearSequences.octspace'>#</a>
**`NonlinearSequences.octspace`** &mdash; *Function*.



```julia
octspace(start, stop, step; adjust_step)
octspace(start, stop; step, length, adjust_step)
octspace(start; stop, step, length, adjust_step)
octspace(; start, stop, step, length, adjust_step)
```

Returns an array of values spaced by `step` octaves.

All arguments can be provided as keyword arguments. Additionally, `start`, `stop` and `step` can be provided as positional arguments. 

4 different combinations of arguments are valid:

  * `start`, `stop`, `step`: values from `start` up to `stop` spaced by `step` in octaves. By default, the step size is obeyed and values may end before `stop`. To adjust the step to reach `stop` precisely, set the keyword argument `adjust_step=true`.
  * `start`, `step`, `length`: `length` many values starting at `start` spaced by `step` octaves.
  * `stop`, `step`, `length`: `length` many values ending at `stop` spaced by `step` octaves.
  * `start`, `stop`, `length`: `length` many logarithmically spaced values from `start` to `stop`.

**Examples**

```julia-repl
julia> octspace(20, 42, 1/3)
4-element Vector{Float64}:
 19.999999999999996
 25.198420997897465
 31.748021039363984
 40.0

julia> octspace(20, 42, 1/3, adjust_step=true)
4-element Vector{Float64}:
 19.999999999999996
 25.61158329974988
 32.79765995600137
 42.00000000000001

julia> octspace(20, step=1/3, length=4)
4-element Vector{Float64}:
 19.999999999999996
 25.198420997897465
 31.748021039363984
 40.0

julia> octspace(stop=40, step=1/3, length=4)
4-element Vector{Float64}:
 19.999999999999996
 25.198420997897465
 31.748021039363984
 40.0

julia> octspace(20, 40, length=4)
4-element Vector{Float64}:
 19.999999999999996
 25.198420997897465
 31.748021039363984
 40.0

julia> octspace(40, 20, -1/3)
4-element Vector{Float64}:
 40.0
 31.748021039363984
 25.198420997897465
 19.999999999999996
```


<a target='_blank' href='https://github.com/Firionus/NonlinearSequences.jl/blob/e775f6fdec0be12404a6890d388066be2f9466ee/src/octspace.jl#L1-L68' class='documenter-source'>source</a><br>

<a id='NonlinearSequences.decspace' href='#NonlinearSequences.decspace'>#</a>
**`NonlinearSequences.decspace`** &mdash; *Function*.



```julia
decspace(start, stop, step; adjust_step)
decspace(start, stop; step, length, adjust_step)
decspace(start; stop, step, length, adjust_step)
decspace(; start, stop, step, length, adjust_step)
```

Returns an array of values spaced by `step` decades.

All arguments can be provided as keyword arguments. Additionally, `start`, `stop` and `step` can be provided as positional arguments. 

4 different combinations of arguments are valid:

  * `start`, `stop`, `step`: values from `start` up to `stop` spaced by `step` in decades. By default, the step size is obeyed and values may end before `stop`. To adjust the step to reach `stop` precisely, set the keyword argument `adjust_step=true`.
  * `start`, `step`, `length`: `length` many values starting at `start` spaced by `step` decades.
  * `stop`, `step`, `length`: `length` many values ending at `stop` spaced by `step` decades.
  * `start`, `stop`, `length`: `length` many logarithmically spaced values from `start` to `stop`.

**Examples**

```julia-repl
julia> decspace(1, 10, 1/3)
4-element Vector{Float64}:
  1.0
  2.154434690031884
  4.641588833612779
 10.000000000000002

julia> decspace(1, step=1/3, length=4)
4-element Vector{Float64}:
  1.0
  2.154434690031884
  4.641588833612779
 10.000000000000002

julia> decspace(stop=10, step=1/3, length=4)
4-element Vector{Float64}:
  1.0
  2.154434690031884
  4.641588833612779
 10.000000000000002

julia> decspace(1, 10, length=4)
4-element Vector{Float64}:
  1.0
  2.154434690031884
  4.641588833612779
 10.000000000000002

julia> decspace(10, 1, -1/3)
4-element Vector{Float64}:
 10.000000000000002
  4.641588833612779
  2.154434690031884
  1.0
```


<a target='_blank' href='https://github.com/Firionus/NonlinearSequences.jl/blob/e775f6fdec0be12404a6890d388066be2f9466ee/src/decspace.jl#L1-L61' class='documenter-source'>source</a><br>

<a id='NonlinearSequences.powspace' href='#NonlinearSequences.powspace'>#</a>
**`NonlinearSequences.powspace`** &mdash; *Function*.



```julia
powspace(start, stop, power, length)
```

Returns an array of values given by a power function. 

The `length` many output values go from `start` to `stop`. They are taken from the power function `y = x^power` where values of `x` are chosen appropriately.

**Examples**

Quadratic sequence:

```julia-repl
julia> powspace(0, 1, 2, 3)
3-element Vector{Float64}:
 0.0
 0.25
 1.0
```

Square Root sequence:

```julia-repl
julia> powspace(0, 1, 1/2, 3)
3-element Vector{Float64}:
 0.0
 0.7071067811865476
 1.0

```


<a target='_blank' href='https://github.com/Firionus/NonlinearSequences.jl/blob/e775f6fdec0be12404a6890d388066be2f9466ee/src/powspace.jl#L1-L29' class='documenter-source'>source</a><br>


<a id='Development'></a>

<a id='Development-1'></a>

## Development


Feedback on the design of the package, feature requests or bug reports are welcome! Just [open an issue](https://github.com/Firionus/NonlinearSequences.jl/issues/new). 


Possible ideas for the future include:


  * lazy computation
  * improving the API
  * other nonlinear spacings
  * reducing code bulk while keeping the ergonomic API
  * improving performance
  * more control over the output type
  * integration into a bigger package or splitting into even smaller packages


If you want to know more about the status of these future ideas or want to discuss, please look at the [issues](https://github.com/Firionus/NonlinearSequences.jl/issues).

