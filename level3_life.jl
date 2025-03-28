module GameOfLife
using Plots

mutable struct Life
    current_frame::Matrix{Int}
    next_frame::Matrix{Int}
end

function check_neighbors(curr,i,j,a,b)
    r=0
    if (i==1 && j==1 && r==0)
        cn=curr[1,2]+curr[2,2]+curr[2,1]
        r=1
    end
    if (i==1 && j==b && r==0)
        cn=curr[1,b-1]+curr[2,b-1]+curr[2,b]
        r=1
    end
    if (i==a && j==1 && r==0)
        cn=curr[a,2]+curr[a-1,1]+curr[a-1,2]
        r=1
    end
    if (i==a && j==b && r==0)
        cn=curr[a,b-1]+curr[a-1,b-1]+curr[a-1,b]
        r=1
    end

    if (i==1 && r==0)
        cn=curr[1,j-1]+curr[1,j+1]+curr[2,j]+curr[2,j-1]+curr[2,j+1]
        r=1
    end
    if (i==a && r==0)
        cn=curr[a,j-1]+curr[a,j+1]+curr[a-1,j]+curr[a-1,j-1]+curr[a-1,j+1]
        r=1
    end
    if (j==1 && r==0)
        cn=curr[i-1,1]+curr[i+1,1]+curr[i-1,2]+curr[i+1,2]+curr[i,2]
        r=1
    end
    if (j==b && r==0)
        cn=curr[i-1,b]+curr[i+1,b]+curr[i-1,b-1]+curr[i+1,b-1]+curr[i,b-1]
        r=1
    end

    if r==0
        cn=curr[i,j+1]+curr[i,j-1]+curr[i+1,j+1]+curr[i+1,j-1]+curr[i-1,j+1]+curr[i-1,j-1]+curr[i+1,j]+curr[i-1,j]
    end

    return cn
end

function rules(cn,point)
    if point==1
        if (cn<2 || cn>3)
            r=0
        else
            r=1
        end
    else
        if cn==3
            r=1
        else
            r=0
        end
    end
    return r
end

function step!(z::Life)
    (a,b)=size(z.current_frame)
    curr = z.current_frame
    next = z.next_frame 

    for i in 1:a
        for j in 1:b            
            next[i,j] = rules(check_neighbors(curr,i,j,a,b),curr[i,j])
        end
    end

    #=
    TODO: вместо случайного шума
    реализовать один шаг алгоритма "Игра жизнь"
    =#

    z.current_frame.=z.next_frame
    z.next_frame.=next
end

function (@main)(ARGS)
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

export main

end

using .GameOfLife
using Plots
GameOfLife.main("")
