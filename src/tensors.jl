export contract

"""
    contract(x::Array{}, y::Array{}, idx1::Int, idx2::Int)
    contract(x::Array{}, y::Array{}, idxs1::Vector{Int}, idxs2::Vector{Int})

Contract two tensors across specified indexs.
"""
function contract(x::Array{}, y::Array{}, idx1::Int, idx2::Int)
    sz = length(size(x))
    dims1 = [i == idx1 ? 0 : i for i = 1:sz]
    dims2 = [j == idx2 ? 0 : sz + j for j = 1:length(size(y))]
    return tensorcontract(x, dims1, y, dims2)
end

function contract(x::Array{}, y::Array{}, idxs1::Vector{Int}, idxs2::Vector{Int})
    length(idxs1) != length(idxs2) && error("The length of contracting indexs differ.")
    labels = [-i for i = 1:length(idxs1)]
    dims1 = [i in idxs1 ? -findall(x -> x == i, idxs1)[1] : i for i = 1:length(size(x))]
    dims2 = [i in idxs2 ? -findall(x -> x == i, idxs2)[1] : i+length(size(x)) for i = 1:length(size(y))]
    return tensorcontract(x, dims1, y, dims2)
end

function moveaxis(x::Array{}, from::Int, to::Int)::Array{}
    sz = length(size(x))

    dims1 = setdiff([i for i = 1:(to-1)], from)  # 1:to-1 with "from" removed
    dims2 = setdiff([i for i = (to):sz], from)  # to:end with "from" removed

    dims = [dims1; from; dims2]
    # only actually need to permute if not already in order!
    return permutedims(x, dims)
end

function moveaxis(x::Array{}, from::Vector{Int}, to::Vector{Int})::Array{}
    # add check that length(from) == length(to)
    
    ## from should be in order!!

    x_new = copy(x)
    for i in 1:length(from)
        x_new = moveaxis(x_new, from[i], to[i])
    end
    return x_new
end
