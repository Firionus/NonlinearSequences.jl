"""
    decspace(start, stop, step; adjust_step)
    decspace(start, stop; step, length, adjust_step)
    decspace(start; stop, step, length, adjust_step)
    decspace(; start, stop, step, length, adjust_step)

Returns an array of values spaced by `step` decades.

All arguments can be provided as keyword arguments. Additionally, `start`,
`stop` and `step` can be provided as positional arguments. 

4 different combinations of arguments are valid:
- `start`, `stop`, `step`: values from `start` up to `stop` spaced by `step` in
  decades. By default, the step size is obeyed and values may end before `stop`.
  To adjust the step to reach `stop` precisely, set the keyword argument
  `adjust_step=true`.
- `start`, `step`, `length`: `length` many values starting at `start` spaced by
  `step` decades. 
- `stop`, `step`, `length`: `length` many values ending at `stop` spaced by
  `step` decades. 
- `start`, `stop`, `length`: `length` many logarithmically spaced values from
  `start` to `stop`.

# Examples
```jldoctest
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
"""
function decspace end

# methods with different numbers of positional arguments

# 3 positional arguments
decspace(start, stop, step; adjust_step=nothing) = 
    decspace(start=start, stop=stop, step=step, adjust_step=adjust_step)

# 2 positional arguments
decspace(start, stop; step=nothing, length=nothing, adjust_step=nothing) = 
    decspace(start=start, stop=stop, step=step, length=length, adjust_step=adjust_step)

# 1 positional arguments
decspace(start; stop=nothing, step=nothing, length=nothing, adjust_step=nothing) = 
    decspace(start=start, stop=stop, step=step, length=length, adjust_step=adjust_step)

# 0 positional arguments
function decspace(; start=nothing, stop=nothing, step=nothing, length=nothing, adjust_step=nothing)
    if step|>isnothing
        logspace(start=start, stop=stop, length=length, adjust_step=adjust_step)
    else
        logspace(start=start, stop=stop, step=step, base=10, length=length, adjust_step=adjust_step)
    end
end