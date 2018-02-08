using Base.Test

function CalcoloAreaBox(Vertici)
    Minx=minimum(Vertici[1,:])
    Maxx=maximum(Vertici[1,:])
    Miny=minimum(Vertici[2,:])
    Maxy=maximum(Vertici[2,:])
    dx=Maxx-Minx
    dy=Maxy-Miny
    Area=dx*dy
    return Area
end

function CalcoloVolumeBox(Vertici)
    Minx=minimum(Vertici[1,:])
    Maxx=maximum(Vertici[1,:])
    Miny=minimum(Vertici[2,:])
    Maxy=maximum(Vertici[2,:])
    Minz=minimum(Vertici[3,:])
    Maxz=maximum(Vertici[3,:])
    dx=Maxx-Minx
    dy=Maxy-Miny
    dz=Maxz-Minz
    Volume=dx*dy*dz
    return Volume
end

@testset "larCircle" begin
    @test CalcoloAreaBox(larCircle()()[1])==4
    @test CalcoloAreaBox(larCircle(2,2*pi)()[1])==16
    @test CalcoloAreaBox(larCircle(3,pi)()[1])==18
    @test CalcoloAreaBox(larCircle(5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larCircle(3,2*pi)(60)[1],2)==61
    @test length(larCircle(3,2*pi)(60)[2])==60
    #da python
end

@testset "larHelix" begin
	@test CalcoloVolumeBox(larHelix()()[1])==8 
	@test CalcoloVolumeBox(larHelix(2,2,2)()[1])==64
	@test CalcoloVolumeBox(larHelix(1,2,5)()[1])==40
	@test CalcoloVolumeBox(larHelix(1,1,3)()[1])==12
    #=
    raggio=1, passo=1, numgiri=2, è contenuto 
    in un parallelepipedo di volume (raggio*2)^2*passo*numgiri
    =#
    @test size(larHelix(5,7,9)()[1],2)==325
    @test length(larHelix(5,7,9)()[2])==324 
end

@testset "larDisk" begin
    @test CalcoloAreaBox(larDisk()()[1])==4
    @test CalcoloAreaBox(larDisk(2,2*pi)()[1])==16
    @test CalcoloAreaBox(larDisk(3,pi)()[1])==18
    @test CalcoloAreaBox(larDisk(5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larDisk(10,pi/7)()[1],2)==74
    @test length(larDisk(10,pi/7)()[2])==36
end

@testset "larHelicoid" begin
    @test CalcoloVolumeBox(larHelicoid()()[1])==8 
    @test CalcoloVolumeBox(larHelicoid(2,1,2,2)()[1])==64
    @test CalcoloVolumeBox(larHelicoid(1,0.5,2,5)()[1])==40
    @test CalcoloVolumeBox(larHelicoid(1,0.3,1,3)()[1])==12  
     #=
    raggio=1, passo=1, numgiri=2, è contenuto in un 
    parallelepipedo di volume (raggio*2)^2*passo*numgiri
    =#
    @test size(larHelicoid(1.3,0.7,1,3)()[1],2)==327
    @test length(larHelicoid(1.3,0.7,1,3)()[2])==432
end

@testset "larRing" begin
    @test CalcoloAreaBox(larRing(1,3,2*pi)()[1])==36
    @test CalcoloAreaBox(larRing(1,2,pi)()[1])==8
    @test CalcoloAreaBox(larRing(2,5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larRing(5,10,pi/6)()[1],2)==74
    @test length(larRing(5,10,pi/6)()[2])==36
end

@testset "larSphere" begin
    @test CalcoloVolumeBox(larSphere(2,pi,2*pi)()[1])==64
    @test CalcoloVolumeBox(larSphere(6,pi,pi)()[1])==864
    @test CalcoloVolumeBox(larSphere(4,pi,2*pi)()[1])==8^3
    #(radius*2)^3
    @test size(larSphere(2.5,pi/3,pi/5)()[1],2)==703
    @test length(larSphere(2.5,pi/3,pi/5)()[2])==1296
end


@testset "larCylinder" begin
	@test CalcoloVolumeBox(larCylinder(1,5,2*pi)()[1])==20
	@test CalcoloVolumeBox(larCylinder(2,2,pi)()[1])==16
	@test CalcoloVolumeBox(larCylinder(1,4,pi)()[1])==8
    #((radius*2)^2)*height
    @test size(larCylinder(3.4,20,pi/7)()[1],2)==74
    @test length(larCylinder(3.4,20,pi/7)()[2])==36 
end

@testset "larToroidal" begin
    @test CalcoloVolumeBox(larToroidal(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloVolumeBox(larToroidal(2,3,2*pi,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larToroidal(1.3,4.6,pi/4,pi/7)()[1],2)==925
    @test length(larToroidal(1.3,4.6,pi/4,pi/7)()[2])==1728
end

@testset "larCrown" begin
    @test CalcoloVolumeBox(larCrown(1,3,2*pi)()[1])==128
    @test CalcoloVolumeBox(larCrown(2,3,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larCrown(1.5,5.6,pi/8)()[1],2)==925
    @test length(larCrown(1.5,5.6,pi/8)()[2])==1728
end

@testset "larBox" begin
    @test CalcoloVolumeBox(larBox([-1,-1,-1],[1,1,1])[1])==(1+1)^3
    @test CalcoloAreaBox(larBox([-1,-1],[1,1])[1])==4
    @test CalcoloVolumeBox(larBox([-1,0,-3],[1,4,5])[1])==(1+1)*(4+0)*(5+3)
    @test CalcoloAreaBox(larBox([2,3],[4,5])[1])==(4-2)*(5-3)
    #(y1-x1)*(y2-x2)*(y3-x3)
end

@testset "larTorus" begin
    @test CalcoloVolumeBox(larTorus(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloVolumeBox(larTorus(2,3,2*pi,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larTorus(5.2,7,pi/3,pi/4)()[1],2)==1850
    @test length(larTorus(5.2,7,pi/3,pi/4)()[2])==864
end

@testset "larBall" begin
    @test CalcoloVolumeBox(larBall(1,pi,2*pi)()[1])==8
    @test CalcoloVolumeBox(larBall(6,pi,pi)()[1])==864
    @test CalcoloVolumeBox(larBall(3,pi,2*pi)()[1])==6^3
    #(radius*2)^3
    @test size(larBall(2.6,pi/5,pi/9)()[1],2)==703
    @test length(larBall(2.6,pi/5,pi/9)()[2])==1
end

@testset "larRod" begin
    @test CalcoloVolumeBox(larRod(1,5,2*pi)()[1])==20
    @test CalcoloVolumeBox(larRod(2,2,pi)()[1])==16
    @test CalcoloVolumeBox(larRod(1,4,pi)()[1])==8
    #((radius*2)^2)*height
    @test size(larRod(3.7,8.9,pi/9)()[1],2)==74
    @test length(larRod(3.7,8.9,pi/9)()[2])==1
end

@testset "larPizza" begin
    @test CalcoloVolumeBox(larPizza(1,2,pi/2)()[1])==18
    @test CalcoloVolumeBox(larPizza(0.5,2,pi)()[1])==12.5
    #(((R+r)*2)^2)*r se angolo=pi
    @test size(larPizza(0.03,5.6,pi/9)()[1],2)==927
    @test length(larPizza(0.03,5.6,pi/9)()[2])==1
end

@testset "larHollowCyl" begin
	@test CalcoloVolumeBox(larHollowCyl(0,1,5,2*pi)()[1])==20
	@test CalcoloVolumeBox(larHollowCyl(1,2,4,pi)()[1])==32
	@test CalcoloVolumeBox(larHollowCyl(1,4,3,pi/2)()[1])==48
    #((radius*2)^2)*height
    @test size(larHollowCyl(3.4,7.8,pi/5)()[1],2)==148
    @test length(larHollowCyl(3.4,7.8,pi/5)()[2])==36
end

@testset "larHollowSphere" begin
    @test CalcoloVolumeBox(larHollowSphere(0,2,pi,2*pi)([36,36,1])[1])==64
    @test CalcoloVolumeBox(larHollowSphere(1,6,pi,pi)([36,36,1])[1])==864
    @test CalcoloVolumeBox(larHollowSphere(2,4,pi,2*pi)([36,36,1])[1])==8^3
    #(radius*2)^3
    @test size(larHollowSphere(1.5,6.7,pi/3,2*pi/3)()[1],2)==148
    @test length(larHollowSphere(1.5,6.7,pi/3,2*pi/3)()[2])==36
end



