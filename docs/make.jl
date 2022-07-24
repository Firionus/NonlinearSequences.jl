using NonlinearSequences
using Documenter

DocMeta.setdocmeta!(NonlinearSequences, :DocTestSetup, :(using NonlinearSequences); recursive=true)

makedocs(;
    modules=[NonlinearSequences],
    authors="Johannes Fried <jcmf.schule@gmail.com> and contributors",
    repo="https://github.com/Firionus/NonlinearSequences.jl/blob/{commit}{path}#{line}",
    sitename="NonlinearSequences.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
