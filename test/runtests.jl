# using AgileRoboticsTutorial
using Base.Test


C_code = """
#include <stddef.h>
double c_sum(size_t n, double *X) {
    double s = 0.0;
    for (size_t i = 0; i < n; ++i) {
        s += X[i];
    }
    return s;
}
"""

const Clib = "my_c_library"   # make a temporary file


# compile to a shared library by piping C_code to gcc
# (works only if you have gcc installed):

open(`gcc -fPIC -O3 -msse3 -xc -shared -o $(Clib * "." * Libdl.dlext) -`, "w") do f
    print(f, C_code) 
end

# define a Julia function that calls the C function:
c_sum(X::Array{Float64}) = ccall(("c_sum", Clib), Float64, (Csize_t, Ptr{Float64}), length(X), X)

# const module_tempdir = joinpath(Base.tempdir(), string(module_name(AgileRoboticsTutorial)))

# @testset "example notebooks" begin
#     using IJulia

#     outputdir = module_tempdir
#     if !isdir(outputdir)
#         mkpath(outputdir)
#     end
#     jupyter = IJulia.jupyter
#     for f in filter(x -> endswith(x, "ipynb"), readdir("../notebooks"))
#         if contains(f, "JuMP")
#             if Pkg.installed("Gurobi") === nothing
#                 continue
#             end
#         end
#         notebook = joinpath("..", "notebooks", f)
#         output = joinpath(outputdir, f)
#         @test begin run(`$jupyter nbconvert --to notebook --execute $notebook --output $output --ExecutePreprocessor.timeout=90`); true end
#     end
# end
