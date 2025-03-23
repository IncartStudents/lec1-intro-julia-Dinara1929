
module GameOfLife
begin
using Plots

mutable struct Life
    current_frame::Matrix{Int}
    next_frame::Matrix{Int}
end
 
function step!(Life)
 #function step!(state::Life)    UndefVarError: `state` not defined in `Main.GameOfLife`
    #curr = state.current_frame
    #next = state.next_frame 
    (a,b)=size(Life.current_frame)
    curr = Life.current_frame
    next = Life.next_frame 

    #=
    TODO: вместо случайного шума
    реализовать один шаг алгоритма "Игра жизнь"
    =#

    function neighbors(curr,i,j)
    begin
        return curr[i-1][j]+curr[i+1][j]+curr[i][j-1]+curr[i][j+1]+curr[i-1][j-1]+curr[i-1][j+1]+curr[i+1][j-1]+curr[i+1][j+1]
    end

    if curr[1][1]==1
        if curr[2][2]+curr[2][1]+curr[1][2]<2
            next[1][1]=0
        else
            if curr[2][2]+curr[2][1]+curr[1][2]>3
                next[1][1]=0
            else
                next[1][1]=1
            end
        end 
    else
        if curr[2][2]+curr[1][2]+curr[2][1]==3
            next[1][1]=1
        end
    end   
    
    if curr[1][b]==1
        if curr[2][b-1]+curr[1][b-1]+curr[2][b]<2
            next[1][b]=0
        else
            if curr[2][b-1]+curr[1][b-1]+curr[2][b]>3
                next[1][b]=0
            else
                next[1][b]=1
            end
        end 
    else
        if curr[2][b-1]+curr[1][b-1]+curr[2][b]==3
            next[1][b]=1
        end
    end

    if curr[a][1]==1
        if curr[a-1][2]+curr[a][2]+curr[a-1][1]<2
            next[a][1]=0
        else
            if curr[a-1][2]+curr[a][2]+curr[a-1][1]>3
                next[a][1]=0
            else
                next[a][1]=1
            end
        end 
    else
        if curr[a-1][2]+curr[a][2]+curr[a-1][1]==3
            next[a][1]=1
        end
    end

    if curr[a][b]==1
        if curr[a-1][b-1]+curr[a][b-1]+curr[a-1][b]<2
            next[a][b]=0
        else
            if curr[a-1][b-1]+curr[a][b-1]+curr[a-1][b]>3
                next[a][b]=0
            else
                next[a][b]=1
            end
        end 
    else
        if curr[a-1][b-1]+curr[a][b-1]+curr[a-1][b]==3
            next[a][b]=1
        end
    end 

    for i in 2:(a-1)
        if curr[i][1]==1
            if curr[i-1][1]+curr[i+1][1]+curr[i][2]+curr[i-1][2]+curr[i+1][2]<2
                next[i][1]=0
            else
                if curr[i-1][1]+curr[i+1][1]+curr[i][2]+curr[i-1][2]+curr[i+1][2]>3
                    next[i][1]=0
                else
                    next[i][1]=1
                end
            end
        else
            if curr[i-1][1]+curr[i+1][1]+curr[i][2]+curr[i-1][2]+curr[i+1][2]==3
                next[i][1]=1
            end
        end
    end

    for i in 2:(a-1)
        if curr[i][b]==1
            if curr[i-1][b]+curr[i+1][b]+curr[i][b-1]+curr[i-1][b-1]+curr[i+1][b-1]<2
                next[i][1]=0
            else
                if curr[i-1][b]+curr[i+1][b]+curr[i][b-1]+curr[i-1][b-1]+curr[i+1][b-1]>3
                    next[i][1]=0
                else
                    next[i][1]=1
                end
            end
        else
            if curr[i-1][b]+curr[i+1][b]+curr[i][b-1]+curr[i-1][b-1]+curr[i+1][b-1]==3
                next[i][1]=1
            end
        end
    end

    for i in 2:(a-1)
        for j in 2:(b-1)
            if curr[i][j]==1
                if neighbors(curr,i,j)<2
                    next[i][j]=0
                else
                    if neighbors(curr,i,j)>3
                        next[i][j]=0
                    else
                        next[i][j]=1
                    end
                end
            else
                if neighbors(curr,i,j)==3
                    next[i][j]=1
                end
            end
        end
    end

    for j in 2:(b-1)
        if curr[1][j]==1
            if curr[2][j]+curr[1][j-1]+curr[1][j+1]+curr[2][j-1]+curr[2][j+1]<2
                next[1][j]=0
            else
                if curr[2][j]+curr[1][j-1]+curr[1][j+1]+curr[2][j-1]+curr[2][j+1]>3
                    next[1][j]=0
                else
                    next[1][j]=1
                end
            end
        else
            if curr[2][j]+curr[1][j-1]+curr[1][j+1]+curr[2][j-1]+curr[2][j+1]==3
                next[1][j]=1
            end
        end
    end

    for j in 2:(b-1)
        if curr[a][j]==1
            if curr[a-1][j]+curr[a][j-1]+curr[a][j+1]+curr[a-1][j-1]+curr[a-1][j+1]<2
                next[1][j]=0
            else
                if curr[a-1][j]+curr[a][j-1]+curr[a][j+1]+curr[a-1][j-1]+curr[a-1][j+1]>3
                    next[1][j]=0
                else
                    next[1][j]=1
                end
            end
        else
            if curr[2][j]+curr[1][j-1]+curr[1][j+1]+curr[2][j-1]+curr[2][j+1]==3
                next[1][j]=1
            end
        end
    end


    #=
    for i in 1:length(curr)
        curr[i] = rand(0:1)
    end
    =#

    # Подсказка для граничных условий - тор:
    # julia> mod1(10, 30)
    # 10
    # julia> mod1(31, 30)
    # 1
    Life.current_frame = next_frame
    Life.next_frame = next
    return nothing
end

#function (@main)(ARGS)  UndefVarError: `main` not defined in `Main.GameOfLife`
function Game()
    using Plots
    n = 30
    m = 30
    init = rand(0:1, n, m)

    game = Life(init, zeros(n, m))

    anim = Plots.@animate for time = 1:100
        step!(game)
        cr = game.current_frame
        heatmap(cr)
    end
    gif(anim, "life.gif", fps = 10)
end

#export main

end
end

#-----

using .GameOfLife
using Plots
#GameOfLife.main("")   UndefVarError: `main` not defined in `Main.GameOfLife`
Game()
end

#ERROR: LoadError: UndefVarError: `Plots` not defined in `Main.GameOfLife`

#Run active Julia file
 #=
 Activating project at `c:\Users\Dinara\.julia\dev\lec1-intro-julia-Dinara1929`
┌ Error: Some Julia code in the VS Code extension crashed
└ @ VSCodeDebugger c:\Users\Dinara\.vscode\extensions\julialang.language-julia-1.127.2\scripts\error_handler.jl:15
ERROR: ArgumentError: lowering returned an error, $(Expr(:error, "\"using\" expression not at top level"))
 =#
