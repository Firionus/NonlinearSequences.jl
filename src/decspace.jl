"""
TODO put docs here
"""
function decspace end

# methods with different numbers of positional arguments

# 3 positional arguments
decspace(start, stop, step; length=nothing, adjust_step=nothing) = 
    logspace(start=start, stop=stop, step=step, base=10, length=length, adjust_step=adjust_step)

# 2 positional arguments
decspace(start, stop; step=nothing, length=nothing, adjust_step=nothing) = 
    logspace(start=start, stop=stop, step=step, base=10, length=length, adjust_step=adjust_step)

# 1 positional arguments
decspace(start; stop=nothing, step=nothing, length=nothing, adjust_step=nothing) = 
    logspace(start=start, stop=stop, step=step, base=10, length=length, adjust_step=adjust_step)

# 0 positional arguments
decspace(; start=nothing, stop=nothing, step=nothing, length=nothing, adjust_step=nothing) = 
    logspace(start=start, stop=stop, step=step, base=10, length=length, adjust_step=adjust_step)