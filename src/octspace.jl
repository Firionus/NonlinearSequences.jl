"""
TODO put docs here
"""
function octspace end

octspace(start, stop, step; adjust_step=nothing) = 
    logspace(start=start, stop=stop, step=step, base=2, adjust_step=adjust_step)

octspace(start, stop; step=nothing, adjust_step=nothing) = 
    logspace(start=start, stop=stop, step=step, base=2, adjust_step=adjust_step)

octspace(start; stop=nothing, step=nothing, adjust_step=nothing) = 
    logspace(start=start, stop=stop, step=step, base=2, adjust_step=adjust_step)

octspace(; start=nothing, stop=nothing, step=nothing, adjust_step=nothing) = 
    logspace(start=start, stop=stop, step=step, base=2, adjust_step=adjust_step)