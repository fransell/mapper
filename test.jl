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
end

@testset "larHelix" begin
	@test CalcoloVolumeBox(larHelix()()[1])==8 
	#raggio=1, passo=1, numgiri=2, è contenuto in un parallelepipedo di volume (raggio*2)^2*passo*numgiri
	@test CalcoloVolumeBox(larHelix(2,2,2)()[1])==64
	@test CalcoloVolumeBox(larHelix(1,2,5)()[1])==40
	@test CalcoloVolumeBox(larHelix(1,1,3)()[1])==12
end

@testset "larDisk" begin
    @test CalcoloAreaBox(larDisk()()[1])==4
    @test CalcoloAreaBox(larDisk(2,2*pi)()[1])==16
    @test CalcoloAreaBox(larDisk(3,pi)()[1])==18
    @test CalcoloAreaBox(larDisk(5,pi/2)()[1])==25
end

@testset "larHelicoid" begin
    @test CalcoloVolumeBox(larHelicoid()()[1])==8 
    #raggio=1, passo=1, numgiri=2, è contenuto in un parallelepipedo di volume (raggio*2)^2*passo*numgiri
    @test CalcoloVolumeBox(larHelicoid(2,1,2,2)()[1])==64
    @test CalcoloVolumeBox(larHelicoid(1,0.5,2,5)()[1])==40
    @test CalcoloVolumeBox(larHelicoid(1,0.3,1,3)()[1])==12  
end

@testset "larRing" begin
    @test CalcoloAreaBox(larRing(1,3,2*pi)()[1])==36
    @test CalcoloAreaBox(larRing(1,2,pi)()[1])==8
    @test CalcoloAreaBox(larRing(2,5,pi/2)()[1])==25
end

@testset "larSphere" begin
    @test CalcoloVolumeBox(larSphere(2,pi,2*pi)()[1])==64
    @test CalcoloVolumeBox(larSphere(6,pi,pi)()[1])==864
    @test CalcoloVolumeBox(larSphere(4,pi,2*pi)()[1])==8^3
end

@testset "larCylinder" begin
	@test CalcoloVolumeBox(larCylinder(1,5,2*pi)()[1])==20
	@test CalcoloVolumeBox(larCylinder(2,2,pi)()[1])==16
	@test CalcoloVolumeBox(larCylinder(1,4,pi)()[1])==8
end

@testset "larToroidal" begin
    @test CalcoloVolumeBox(larToroidal(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloVolumeBox(larToroidal(2,3,2*pi,2*pi)()[1])==400
    #volume box toro=(((R+r)*2)^2)*(r*2)

end

@testset "larCrown" begin
    @test CalcoloVolumeBox(larCrown(1,3,2*pi)()[1])==128
    @test CalcoloVolumeBox(larCrown(2,3,2*pi)()[1])==400
end

@testset "larBox" begin
    @test CalcoloVolumeBox(larBox([-1,-1,-1],[1,1,1])[1])==(1+1)^3
    @test CalcoloAreaBox(larBox([-1,-1],[1,1])[1])==4
    @test CalcoloVolumeBox(larBox([-1,0,-3],[1,4,5])[1])==(1+1)*(4+0)*(5+3)
    @test CalcoloAreaBox(larBox([2,3],[4,5])[1])==(4-2)*(5-3)
end

@testset "larTorus" begin
    @test CalcoloVolumeBox(larTorus(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloVolumeBox(larTorus(2,3,2*pi,2*pi)()[1])==400
    #volume box toro=(((R+r)*2)^2)*(r*2)
end

@testset "larBall" begin
           @test CalcoloVolumeBox(larBall(1,pi,2*pi)()[1])==8
           @test CalcoloVolumeBox(larBall(6,pi,pi)()[1])==864
           @test CalcoloVolumeBox(larBall(3,pi,2*pi)()[1])==6^3
       end

@testset "larBall1" begin
           @test CalcoloVolumeBox(larBall1(1,pi,2*pi)([60,60,1])[1])==8
           @test CalcoloVolumeBox(larBall1(6,pi,pi)([60,60,1])[1])==864
           @test CalcoloVolumeBox(larBall1(3,pi,2*pi)([60,60,1])[1])==216
       end

@testset "larRod" begin
    @test CalcoloVolumeBox(larRod(1,5,2*pi)()[1])==20
    @test CalcoloVolumeBox(larRod(2,2,pi)()[1])==16
    @test CalcoloVolumeBox(larRod(1,4,pi)()[1])==8
end

@testset "larRod1" begin
    @test CalcoloVolumeBox(larRod1(1,5,2*pi)()[1])==20
    @test CalcoloVolumeBox(larRod1(2,2,pi)()[1])==16
    @test CalcoloVolumeBox(larRod1(1,4,pi)()[1])==8
end

@testset "larPizza" begin
    @test CalcoloVolumeBox(larPizza(1,2,pi/2)()[1])==18
     @test CalcoloVolumeBox(larPizza(0.5,2,pi)()[1])==12.5
end
#(((R+r)*2)^2)*r se angolo=pi


@testset "larHollowCyl" begin
	@test CalcoloVolumeBox(larHollowCyl(0,1,5,2*pi)()[1])==20
	@test CalcoloVolumeBox(larHollowCyl(1,2,4,pi)()[1])==32
	@test CalcoloVolumeBox(larHollowCyl(1,4,3,pi/2)()[1])==48
end

@testset "larHollowSphere" begin
           @test CalcoloVolumeBox(larHollowSphere(0,2,pi,2*pi)([60,60,1])[1])==64
           @test CalcoloVolumeBox(larHollowSphere(0,6,pi,pi)([32,32,1])[1])==864
           @test CalcoloVolumeBox(larHollowSphere(0,4,pi,2*pi)([60,60,1])[1])==8^3
       end


