"""
    powspace(start, stop, power, length)

Returns an array of values given by a power function. 

The `length` many output values go from `start` to `stop`. They are taken from
the power function `y = x^power` where values of `x` are chosen appropriately.

# Examples 

Quadratic sequence:
```jldoctest
julia> powspace(0, 1, 2, 3)
3-element Vector{Float64}:
 0.0
 0.25
 1.0
```

Square Root sequence:
```jldoctest
julia> powspace(0, 1, 1/2, 3)
3-element Vector{Float64}:
 0.0
 0.7071067811865476
 1.0

```
"""
function powspace(start, stop, power, length)
    invpower = 1/power
    powstart = start^invpower
    powstop = stop^invpower
    range(powstart, powstop, length=length).^power
end