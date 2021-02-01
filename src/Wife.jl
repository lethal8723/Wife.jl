module Wife

# Write your package code here.
using DataFrames, DelimitedFiles 

export DatToDataFrame


"""
    skipline(f::AbstractString)

Read Abaqus output file(with .dat extension) and 
return the number of header rows.
"""
function skipline(f)
    @assert occursin(r"\.dat$",f)
    skiplinenum=1
    for line in readlines(f)
        occursin(r"^-{10,}$",line) && break
        skiplinenum +=1
    end
    return skiplinenum
end

"""
    DatToDataFrame(f::AbstractString)

Read Abaqus output file(with .dat extension) and 
transform it into a DataFrame.
"""
function DatToDataFrame(f)
    skipstart = skipline(f)
    colnames = split(readlines(f)[skipstart-2])
    DataFrame(readdlm(f,skipstart=skipstart),colnames)
end

end