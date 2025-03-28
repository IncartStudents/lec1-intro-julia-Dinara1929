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
    space = 3
    if state.boid[1]<space
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
    if state.boid[1]>(state.width-space)
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
    if state.boid[2]<space
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
    if state.boid[2]>(state.height-space)
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

function norm(indiv_vec,i,xy)   
    d=sqrt(indiv_vec[1,i]^2+indiv_vec[2,i]^2) 
    dd=sqrt(xy[1]^2+xy[2]^2)

    xy[1]=(xy[1]/dd)*0.2
    xy[2]=(xy[2]/dd)*0.2

    sum_x=indiv_vec[1,i]+xy[1]
    sum_y=indiv_vec[2,i]+xy[2]
    sum_d=sqrt(sum_x^2+sum_y^2)

    indiv_vec[1,i]=(sum_x/sum_d*d)
    indiv_vec[2,i]=(sum_y/sum_d*d)
end

function group(indiv_vec,n_boids,mid_vec)
    for i in 1:n_boids
        xy=zeros(2)
        xy[1]=mid_vec[1,1]-indiv_vec[1,i]
        xy[2]=mid_vec[1,2]-indiv_vec[2,i]
        norm(indiv_vec,i,xy)
    end
end

function untouch(birds,indiv_vec,i,j,n_boids)
    xy=zeros(2)
    xy[1]=(birds[j].boid[1]-birds[i].boid[1])
    xy[2]=(birds[j].boid[2]-birds[i].boid[2])
    
    dlin=sqrt(xy[1]^2+xy[2]^2)
    if dlin<3
        di=sqrt(indiv_vec[1,i]^2+indiv_vec[2,i]^2)
        dj=sqrt(indiv_vec[1,j]^2+indiv_vec[2,j]^2)

        indiv_vec[1,i]=(indiv_vec[1,i]-xy[1]*3)
        indiv_vec[2,i]=(indiv_vec[2,i]-xy[2]*3)
        d=sqrt(indiv_vec[1,i]^2+indiv_vec[2,i]^2)
        indiv_vec[1,i]=indiv_vec[1,i]/d*di
        indiv_vec[2,i]=indiv_vec[2,i]/d*di

        indiv_vec[1,j]=(indiv_vec[1,j]+xy[1]*3)
        indiv_vec[2,j]=(indiv_vec[2,j]+xy[2]*3)
        d=sqrt(indiv_vec[1,j]^2+indiv_vec[2,j]^2)
        indiv_vec[1,j]=indiv_vec[1,j]/d*dj
        indiv_vec[2,j]=indiv_vec[2,j]/d*dj
    end
end

function speed(indiv_vec,n_boids,xy)
    speed=sqrt(xy[2,1]^2+xy[2,2]^2)
    k=0.1
    for i in 1:n_boids
        d=sqrt(indiv_vec[1,i]^2+indiv_vec[2,i]^2)
        if speed>d
            indiv_vec[1,i]=indiv_vec[1,i]+k*xy[2,1]
            indiv_vec[2,i]=indiv_vec[2,i]+k*xy[2,1]
        end
        if speed<d
            indiv_vec[1,i]=indiv_vec[1,i]-k*xy[2,2]
            indiv_vec[2,i]=indiv_vec[2,i]-k*xy[2,2]
        end
    end
end

function update!(state::WorldState,indiv_vec,i)
    xy=indiv_vec
    walls(state,xy,i)
    
    state.boid = replace(state.boid,state.boid[1]=>state.boid[1]+xy[1,i])
    state.boid = replace(state.boid,state.boid[2]=>state.boid[2]+xy[2,i])
    # TODO: реализация уравнения движения птичек
    indiv_vec[1,i]=xy[1,i]
    indiv_vec[2,i]=xy[2,i]
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
        group(indiv_vec,n_boids,mid_vec(birds,n_boids,indiv_vec))
        for i in 1:(n_boids-1)
            for j in (i+1):n_boids
                untouch(birds,indiv_vec,i,j,n_boids)
            end
        end
        speed(indiv_vec,n_boids,mid_vec(birds,n_boids,indiv_vec))
            
        for i in 1:n_boids
            update!(birds[i],indiv_vec,i)
            x = [bird.boid[1] for bird in birds]
            y = [bird.boid[2] for bird in birds]
            scatter(x,y,xlim = (0, w), ylim = (0, h))
        end  
    end
    gif(anim, "boids.gif", fps = 10)
    #gif(anim, "boids-group.gif", fps = 10)
    #gif(anim, "boids-untouch.gif", fps = 10)
    #gif(anim, "boids-speed.gif", fps = 10)
end

export main

end

using .Boids
Boids.main("")
