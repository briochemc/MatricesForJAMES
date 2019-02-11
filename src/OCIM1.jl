# activate current Julia project
using Pkg
Pkg.activate(".")

using DataDeps # to download the OCIM file

register(
    DataDep(
        "OCIM1",
        """
        References:
        - DeVries, T. (2014), The oceanic anthropogenic CO2 sink: Storage, air‐sea fluxes, and transports over the industrial era, Global Biogeochem. Cycles, 28, 631–647, doi:10.1002/2013GB004739.
        - DeVries, T. and F. Primeau, 2011: Dynamically and Observationally Constrained Estimates of Water-Mass Distributions and Ages in the Global Ocean. J. Phys. Oceanogr., 41, 2381–2401, https://doi.org/10.1175/JPO-D-10-05011.1
        """,
        "https://dl.dropboxusercontent.com/s/n0j1swt4bqgbj75/CTL.mat",
        sha2_256
    )
)

using MAT # to load `.mat` files

mat_file = @datadep_str string("OCIM1/", "CTL.mat")
vars = matread(mat_file)

using JLD2, FileIO # to save into `.jld2` files

path_to_package_root = joinpath(splitpath(@__DIR__)[1:end-1]...)
jld_file = joinpath(path_to_package_root, "data/OCIM1/CTL.jld2")
@save jld_file vars


