using AgileRoboticsTutorial
using Base.Test
using NBInclude
using Reactive

const module_tempdir = joinpath(Base.tempdir(), string(module_name(AgileRoboticsTutorial)))

@testset "example notebooks" begin
    for f in filter(x -> endswith(x, "ipynb"), readdir("../notebooks"))
        notebook = joinpath("..", "notebooks", f)
        cd(dirname(notebook)) do
            nbinclude(notebook)
        end
    end
end
