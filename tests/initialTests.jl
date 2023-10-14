#include("../src/QuantumCircuit.jl")

using QuantumCircuit

test()

N::Int = 5

psi = zeros(ComplexF64, repeat([2], N)...)

println(size(psi))


A = randn(ComplexF64, 2, 3, 4)
B = randn(ComplexF64, 5, 3, 2)
C = contract(A, B, [1,2], [3,2])

println(size(C))

C = permutedims(C, [2,1])

println(size(C))

println(size(A))