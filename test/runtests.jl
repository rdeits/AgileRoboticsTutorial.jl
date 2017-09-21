using AgileRoboticsTutorial
using Base.Test

const module_tempdir = joinpath(Base.tempdir(), string(module_name(AgileRoboticsTutorial)))

@testset "example notebooks" begin
    using IJulia

    outputdir = module_tempdir
    if !isdir(outputdir)
        mkpath(outputdir)
    end
    jupyter = IJulia.jupyter
    for f in filter(x -> endswith(x, "ipynb"), readdir("../notebooks"))
        notebook = joinpath("..", "notebooks", f)
        output = joinpath(outputdir, f)
        @test begin run(`$jupyter nbconvert --to notebook --execute $notebook --output $output --ExecutePreprocessor.timeout=90`); true end
    end
end
