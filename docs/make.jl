using Pkg

Pkg.activate(".")
Pkg.instantiate()

using NonlinearSequences
using Documenter, DocumenterMarkdown

DocMeta.setdocmeta!(NonlinearSequences, :DocTestSetup, :(using NonlinearSequences); recursive=true)

makedocs(;
    format=Markdown(),
    modules=[NonlinearSequences],
)

cp("build/README.md", "../README.md", force=true)
