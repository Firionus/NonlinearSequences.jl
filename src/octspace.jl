"""
    octspace(start, stop, step; adjust_step)
    octspace(start, stop; step, length, adjust_step)
    octspace(start; stop, step, length, adjust_step)
    octspace(; start, stop, step, length, adjust_step)

Returns an array of values spaced by `step` octaves.

All arguments can be provided as keyword arguments. Additionally, `start`,
`stop` and `step` can be provided as positional arguments. 

4 different combinations of arguments are valid:
- `start`, `stop`, `step`: values from `start` up to `stop` spaced by `step` in
  octaves. By default, the step size is obeyed and values may end before `stop`.
  To adjust the step to reach `stop` precisely, set the keyword argument
  `adjust_step=true`.
- `start`, `step`, `length`: `length` many values starting at `start` spaced by
  `step` octaves. 
- `stop`, `step`, `length`: `length` many values ending at `stop` spaced by
  `step` octaves. 
- `start`, `stop`, `length`: `length` many logarithmically spaced values from
  `start` to `stop`.

# Examples
```jldoctest
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
"""
function octspace end

# methods with different numbers of positional arguments

# 3 positional arguments
octspace(start, stop, step; adjust_step=nothing) = 
    octspace(start=start, stop=stop, step=step, adjust_step=adjust_step)

# 2 positional arguments
octspace(start, stop; step=nothing, length=nothing, adjust_step=nothing) =
    octspace(start=start, stop=stop, step=step, length=length, adjust_step=adjust_step)

# 1 positional arguments
octspace(start; stop=nothing, step=nothing, length=nothing, adjust_step=nothing) = 
    octspace(start=start, stop=stop, step=step, length=length, adjust_step=adjust_step)

# 0 positional arguments
function octspace(; start=nothing, stop=nothing, step=nothing, length=nothing, adjust_step=nothing)
    if step|>isnothing
        logspace(start=start, stop=stop, length=length)
    else
        logspace(start=start, stop=stop, step=step, base=2, length=length, adjust_step=adjust_step)
    end
end