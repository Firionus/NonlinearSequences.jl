using NonuniformSmoothing1D
using Documenter

DocMeta.setdocmeta!(NonuniformSmoothing1D, :DocTestSetup, :(using NonuniformSmoothing1D); recursive=true)

makedocs(;
    modules=[NonuniformSmoothing1D],
    authors="Johannes Fried <jcmf.schule@gmail.com> and contributors",
    repo="https://github.com/Firionus/NonuniformSmoothing1D.jl/blob/{commit}{path}#{line}",
    sitename="NonuniformSmoothing1D.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
