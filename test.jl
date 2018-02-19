using Base.Test

function CalcoloBox(Vertici)
    Minx=minimum(Vertici[1,:])
    Maxx=maximum(Vertici[1,:])
    Miny=minimum(Vertici[2,:])
    Maxy=maximum(Vertici[2,:])
    dx=Maxx-Minx
    dy=Maxy-Miny
    Box=dx*dy
    if size(Vertici,1)==3
        Minz=minimum(Vertici[3,:])
        Maxz=maximum(Vertici[3,:])
        dz=Maxz-Minz
        Box=Box*dz
    end
    return Box
end

@testset "larCircle" begin
    @test CalcoloBox(larCircle()()[1])==4
    @test CalcoloBox(larCircle(2,2*pi)()[1])==16
    @test CalcoloBox(larCircle(3,pi)()[1])==18
    @test CalcoloBox(larCircle(5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larCircle(3,2*pi)(60)[1],2)==61
    @test length(larCircle(3,2*pi)(60)[2])==60
    #da python
end

@testset "larHelix" begin
	@test CalcoloBox(larHelix()()[1])==8
	@test CalcoloBox(larHelix(2,2,2)()[1])==64
	@test CalcoloBox(larHelix(1,2,5)()[1])==40
	@test CalcoloBox(larHelix(1,1,3)()[1])==12
    #=
    raggio=1, passo=1, numgiri=2, è contenuto
    in un parallelepipedo di volume (raggio*2)^2*passo*numgiri
    =#
    @test size(larHelix(5,7,9)()[1],2)==325
    @test length(larHelix(5,7,9)()[2])==324
end

@testset "larDisk" begin
    @test CalcoloBox(larDisk()()[1])==4
    @test CalcoloBox(larDisk(2,2*pi)()[1])==16
    @test CalcoloBox(larDisk(3,pi)()[1])==18
    @test CalcoloBox(larDisk(5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larDisk(10,pi/7)()[1],2)==74
    @test length(larDisk(10,pi/7)()[2])==36
end

@testset "larHelicoid" begin
    @test CalcoloBox(larHelicoid()()[1])==8
    @test CalcoloBox(larHelicoid(2,1,2,2)()[1])==64
    @test CalcoloBox(larHelicoid(1,0.5,2,5)()[1])==40
    @test CalcoloBox(larHelicoid(1,0.3,1,3)()[1])==12
     #=
    raggio=1, passo=1, numgiri=2, è contenuto in un
    parallelepipedo di volume (raggio*2)^2*passo*numgiri
    =#
    @test size(larHelicoid(1.3,0.7,1,3)()[1],2)==327
    @test length(larHelicoid(1.3,0.7,1,3)()[2])==432
end

@testset "larRing" begin
    @test CalcoloBox(larRing(1,3,2*pi)()[1])==36
    @test CalcoloBox(larRing(1,2,pi)()[1])==8
    @test CalcoloBox(larRing(2,5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larRing(5,10,pi/6)()[1],2)==74
    @test length(larRing(5,10,pi/6)()[2])==36
end

@testset "larSphere" begin
    @test CalcoloBox(larSphere(2,pi,2*pi)()[1])==64
    @test CalcoloBox(larSphere(6,pi,pi)()[1])==864
    @test CalcoloBox(larSphere(4,pi,2*pi)()[1])==8^3
    #(radius*2)^3
    @test size(larSphere(2.5,pi/3,pi/5)()[1],2)==703
    @test length(larSphere(2.5,pi/3,pi/5)()[2])==1296
end


@testset "larCylinder" begin
	@test CalcoloBox(larCylinder(1,5,2*pi)()[1])==20
	@test CalcoloBox(larCylinder(2,2,pi)()[1])==16
	@test CalcoloBox(larCylinder(1,4,pi)()[1])==8
    #((radius*2)^2)*height
    @test size(larCylinder(3.4,20,pi/7)()[1],2)==74
    @test length(larCylinder(3.4,20,pi/7)()[2])==36
end

@testset "larToroidal" begin
    @test CalcoloBox(larToroidal(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloBox(larToroidal(2,3,2*pi,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larToroidal(1.3,4.6,pi/4,pi/7)()[1],2)==925
    @test length(larToroidal(1.3,4.6,pi/4,pi/7)()[2])==1728
end

@testset "larCrown" begin
    @test CalcoloBox(larCrown(1,3,2*pi)()[1])==128
    @test CalcoloBox(larCrown(2,3,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larCrown(1.5,5.6,pi/8)()[1],2)==925
    @test length(larCrown(1.5,5.6,pi/8)()[2])==1728
end

@testset "larBox" begin
    @test CalcoloBox(larBox([-1,-1,-1],[1,1,1])[1])==(1+1)^3
    @test CalcoloBox(larBox([-1,-1],[1,1])[1])==4
    @test CalcoloBox(larBox([-1,0,-3],[1,4,5])[1])==(1+1)*(4+0)*(5+3)
    @test CalcoloBox(larBox([2,3],[4,5])[1])==(4-2)*(5-3)
    #(y1-x1)*(y2-x2)*(y3-x3)
end

@testset "larTorus" begin
    @test CalcoloBox(larTorus(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloBox(larTorus(2,3,2*pi,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larTorus(5.2,7,pi/3,pi/4)()[1],2)==1850
    @test length(larTorus(5.2,7,pi/3,pi/4)()[2])==864
end

@testset "larBall" begin
    @test CalcoloBox(larBall(1,pi,2*pi)()[1])==8
    @test CalcoloBox(larBall(6,pi,pi)()[1])==864
    @test CalcoloBox(larBall(3,pi,2*pi)()[1])==6^3
    #(radius*2)^3
    @test size(larBall(2.6,pi/5,pi/9)()[1],2)==703
    @test length(larBall(2.6,pi/5,pi/9)()[2])==1
end

@testset "larRod" begin
    @test CalcoloBox(larRod(1,5,2*pi)()[1])==20
    @test CalcoloBox(larRod(2,2,pi)()[1])==16
    @test CalcoloBox(larRod(1,4,pi)()[1])==8
    #((radius*2)^2)*height
    @test size(larRod(3.7,8.9,pi/9)()[1],2)==74
    @test length(larRod(3.7,8.9,pi/9)()[2])==1
end

@testset "larPizza" begin
    @test CalcoloBox(larPizza(1,2,pi/2)()[1])==18
    @test CalcoloBox(larPizza(0.5,2,pi)()[1])==12.5
    #(((R+r)*2)^2)*r se angolo=pi
    @test size(larPizza(0.03,5.6,pi/9)()[1],2)==927
    @test length(larPizza(0.03,5.6,pi/9)()[2])==1
end

@testset "larHollowCyl" begin
	@test CalcoloBox(larHollowCyl(0,1,5,2*pi)()[1])==20
	@test CalcoloBox(larHollowCyl(1,2,4,pi)()[1])==32
	@test CalcoloBox(larHollowCyl(1,4,3,pi/2)()[1])==48
    #((radius*2)^2)*height
    @test size(larHollowCyl(3.4,7.8,pi/5)()[1],2)==148
    @test length(larHollowCyl(3.4,7.8,pi/5)()[2])==36
end

@testset "larHollowSphere" begin
    @test CalcoloBox(larHollowSphere(0,2,pi,2*pi)([36,36,1])[1])==64
    @test CalcoloBox(larHollowSphere(1,6,pi,pi)([36,36,1])[1])==864
    @test CalcoloBox(larHollowSphere(2,4,pi,2*pi)([36,36,1])[1])==8^3
    #(radius*2)^3
    @test size(larHollowSphere(1.5,6.7,pi/3,2*pi/3)()[1],2)==148
    @test length(larHollowSphere(1.5,6.7,pi/3,2*pi/3)()[2])==36
end
