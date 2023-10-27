#include("../src/QuantumCircuit.jl")

using Revise
using QuantumCircuit
const QC = QuantumCircuit

test()

N::Int = 5;

psi = zeros(ComplexF64, repeat([2], N)...);

println(size(psi))


A = randn(ComplexF64, 2, 3, 4);
B = randn(ComplexF64, 5, 3, 2);
C = contract(A, B, [1,2], [3,2]);

println(size(C))

C = permutedims(C, [2,1]);

println(size(C))

println(size(A))

println(zero_state(4))
println(state_from_vector([1,0,0,1,0,0,0,0]))

psi = zero_state(3);

X = GeneralGate([0 1; 1 0], [1]);
H = GeneralGate([1 1; 1 -1]/sqrt(2), [1]);
CNOT = GeneralGate([1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0], [1,2]);
CNOT23 = GeneralGate([1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0], [2,3]);



println(psi)

new_psi = apply(psi, H);

println([new_psi...])

new_psi = apply(new_psi, CNOT);

println([new_psi...])

new_psi = apply(new_psi, CNOT23);

println([new_psi...])

new_psi = apply_hadamard(new_psi, [1]);
println([new_psi...])

new_psi = apply(new_psi,QC.hadamard(1));
println([new_psi...])

println(" Next ")


phi = zero_state(2);
phi = apply(phi, QC.hadamard(1));
#println("phi = ", [phi...])
phi = apply(phi, QC.cnot(1, 2));
#println("phi = ", [phi...])
