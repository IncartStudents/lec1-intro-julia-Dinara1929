
module Boids
using Plots

mutable struct WorldState
    boid::Tuple{Float64, Float64}
    height::Float64
    width::Float64
    
    function WorldState(n_boids, width, height)
        # TODO: добавить случайные позиции для n_boids птичек вместо одной
        new((rand(3:97)/100*width, rand(3:97)/100*height), width, height)
        #new((width/2, height/2), width, height)
    end
end

function mid_vec(birds,n_boids,indiv_vec)
    MidVec=zeros(2,2)
    for i in 1:n_boids
        MidVec[1,1] =+ (birds[i].boid[1]/n_boids)
        MidVec[1,2] =+ (birds[i].boid[2]/n_boids)
        MidVec[2,1] =+ (indiv_vec[1,i]/n_boids)
        MidVec[2,2] =+ (indiv_vec[2,i]/n_boids)
    end
    return MidVec
end

function walls(state::WorldState,xy::Matrix{Float64},i::Int)
    if state.boid[1]<1
        if state.boid[2]>(state.height-state.boid[2])#xk plus; yk min
            if xy[1,i]<0
                xy[1,i]=xy[1,i]*(-1)
            end
            if xy[2,i]>0
                xy[2,i]=xy[2,i]*(-1)
            end
        else #xk plus; yk plus
            if xy[1,i]<0
                xy[1,i]=xy[1,i]*(-1)
            end
            if xy[2,i]<0
                xy[2,i]=xy[2,i]*(-1)
            end
        end
    end
    if state.boid[1]>(state.width-1)
        if state.boid[2]>(state.height-state.boid[2])#xk min; yk min
            if xy[1,i]>0
                xy[1,i]=xy[1,i]*(-1)
            end
            if xy[2,i]>0
                xy[2,i]=xy[2,i]*(-1)
            end
        else #xk min; yk plus
            if xy[1,i]>0
                xy[1,i]=xy[1,i]*(-1)
            end
            if xy[2,i]<0
                xy[2,i]=xy[2,i]*(-1)
            end
        end
    end
    if state.boid[2]<1
        if state.boid[1]>(state.height-state.boid[2])#xk min; yk plus
            if xy[1,i]>0
                xy[1,i]=xy[1,i]*(-1)
            end
            if xy[2,i]<0
                xy[2,i]=xy[2,i]*(-1)
            end
        else #xk plus; yk plus
            if xy[1,i]<0
                xy[1,i]=xy[1,i]*(-1)
            end
            if xy[2,i]<0
                xy[2,i]=xy[2,i]*(-1)
            end
        end
    end
    if state.boid[2]>(state.height-1)
        if state.boid[2]>(state.width-state.boid[2])#xk min; yk min
            if xy[1,i]>0
                xy[1,i]=xy[1,i]*(-1)
            end
            if xy[2,i]>0
                xy[2,i]=xy[2,i]*(-1)
            end
        else #xk plus; yk min
            if xy[1,i]<0
                xy[1,i]=xy[1,i]*(-1)
            end
            if xy[2,i]>0
                xy[2,i]=xy[2,i]*(-1)
            end
        end
    end 
end

function norm(state::WorldState,x::Float64,y::Float64)
    x=(x/(x*x+y*y))
    y=(y/(x*x+y*y))
    sum_x=state.boid[1]+x
    sum_y=state.boid[2]+y
    d=sqrt(state.boid[1]*state.boid[1]+state.boid[2]*state.boid[2])
    sum_d=sqrt(sum_x*sum_x+sum_y*sum_y)
    #state.boid[1].=(sum_x/sum_d*d)
    #state.boid[2].=(sum_y/sum_d*d)
end

function group(birds,n_boids,x,y)
    for i in 1:n_boids
        x1=x-birds[i].boid[1]
        y1=y-birds[i].boid[2]
        #norm(birds[i],x1,y2)
    end
end

function untouch(birds,i,j,n_boids)
    d=sqrt((birds[i].boid[1]-birds[j].boid[1])^2+(birds[i].boid[2]-birds[j].boid[2])^2)
    x=(birds[i].boid[1]-birds[j].boid[1])*0.5
    y=(birds[i].boid[2]-birds[j].boid[2])*0.5
    if d<1.5
        #norm(birds[j],x,y)
        #norm(birds[i],-x,-y)
    end
end

function speed(indiv_vec,n_boids,x,y)
    for i in 1:n_boids
        if indiv_vec[1,i]>x
            indiv_vec[1,i]=indiv_vec[1,i]-0.1*x
        else
            indiv_vec[1,i]=indiv_vec[1,i]+0.1*x
        end            
        if indiv_vec[2,i]>y
            indiv_vec[2,i]=indiv_vec[2,i]-0.1*y
        else
            indiv_vec[2,i]=indiv_vec[2,i]+0.1*y
        end
    end
end

function update!(state::WorldState,indiv_vec,i,mid_vec)
    xy=indiv_vec
    walls(state,xy,i)

    norm(state,mid_vec[1,1],mid_vec[1,2])
        
    state.boid = replace(state.boid,state.boid[1]=>state.boid[1]+xy[1,i])
    state.boid = replace(state.boid,state.boid[2]=>state.boid[2]+xy[2,i])
    # TODO: реализация уравнения движения птичек
    indiv_vec[1,i]=xy[1,i]
    indiv_vec[2,i]=xy[2,i]
    #return nothing
end

function (@main)(ARGS)
    w = 30
    h = 30
    n_boids = 10
    
    indiv_vec=Array{Float64}(undef,2,n_boids)
    for i in 1:n_boids
        indiv_vec[1,i]=rand(-9:9)/10
        indiv_vec[2,i]=rand(-9:9)/10
    end

    birds=Array{WorldState}(undef,n_boids)
    for i in 1:n_boids
        birds[i] = WorldState(n_boids, w, h)
    end

    anim = @animate for time = 1:100

        group(birds,n_boids,mid_vec(birds,n_boids,indiv_vec)[1,1],mid_vec(birds,n_boids,indiv_vec)[1,2])
        for i in 1:(n_boids-1)
            for j in (i+1):n_boids
                untouch(birds,n_boids,i,j)
            end
        end
        speed(indiv_vec,n_boids,mid_vec(birds,n_boids,indiv_vec)[2,1],mid_vec(birds,n_boids,indiv_vec)[2,2])
            
        for i in 1:n_boids
            update!(birds[i],indiv_vec,i,mid_vec(birds,n_boids,indiv_vec))
            x = [bird.boid[1] for bird in birds]
            y = [bird.boid[2] for bird in birds]
            scatter(x,y,xlim = (0, w), ylim = (0, h))
        end  
    end
    gif(anim, "boids.gif", fps = 10)
    
end

export main

end

using .Boids
Boids.main("")

#=
function norm (since string 99)
    state.boid[1].=(sum_x/sum_d*d)
    state.boid[2].=(sum_y/sum_d*d)
ERROR:
MethodError: no method matching copyto!(::Float64, ::Base.Broadcast.Broadcasted{…})
The function `copyto!` exists, but no method is defined for this combination of argument types.

=#