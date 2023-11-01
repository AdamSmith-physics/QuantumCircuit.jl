
using Revise
using BenchmarkTools
using MethodAnalysis
using TensorOperations
using QuantumCircuit
const QC = QuantumCircuit

H = GeneralGate([1 1; 1 -1]/sqrt(2), [1]);
CNOT = GeneralGate([1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0], [1,2]);



phi = zero_state(2);
@time phi = apply(phi, QC.hadamard(1));
#println("phi = ", [phi...])
@time phi = apply(phi, QC.cnot(1, 2));
#println("phi = ", [phi...])

@time @tensor phi[:] := phi[1,-2] * H.matrix[-1,1];  # quick because tensorcontract is already compiled for these shapes

methodinstances(apply)  # compiles a new version for all input shapes! Completely unnecessary!


phi = zero_state(3);

@time @tensor phi[:] := phi[1,-2,-3] * H.matrix[-1,1];  # much slower now! Around 5s

@time phi = apply(phi, QC.hadamard(1));  # still nearly 100% of the time is compilation! But now under 1s
#println("phi = ", [phi...])
@time phi = apply(phi, QC.cnot(1, 2));
#println("phi = ", [phi...])

methodinstances(apply)  # compiles a new version for all input shapes! Completely unnecessary!