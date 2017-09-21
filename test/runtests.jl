using AgileRoboticsTutorial
using Base.Test
using NBInclude

const module_tempdir = joinpath(Base.tempdir(), string(module_name(AgileRoboticsTutorial)))

@testset "example notebooks" begin
    for f in filter(x -> endswith(x, "ipynb"), readdir("../notebooks"))
        notebook = joinpath("..", "notebooks", f)
        nbinclude(notebook)
    end
end
