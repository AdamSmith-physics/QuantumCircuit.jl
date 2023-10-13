include("../src/QuantumCircuit.jl")

test()

N::Int = 5

psi = zeros(ComplexF64, repeat([2], N)...)

println(size(psi))


A = randn(ComplexF64, 2, 3, 4)
B = randn(ComplexF64, 4, 3, 2)
C = contract(A, B, 2, 2)

println(size(C))