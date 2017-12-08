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

@testset "larRing" begin
    @test CalcoloAreaBox(larRing(1,3,2*pi)()[1])==36
    @test CalcoloAreaBox(larRing(1,2,pi)()[1])==8
    @test CalcoloAreaBox(larRing(2,5,pi/2)()[1])==25
end

@testset "larCylinder" begin
	@test CalcoloVolumeBox(larCylinder(1,5,2*pi)()[1])==20
	@test CalcoloVolumeBox(larCylinder(2,2,pi)()[1])==16
	@test CalcoloVolumeBox(larCylinder(1,4,pi)()[1])==8
end

@testset "larTorus" begin
    @test CalcoloVolumeBox(larTorus(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloVolumeBox(larTorus(2,3,2*pi,2*pi)()[1])==400
    #volume box toro=(((R+r)*2)^2)*(r*2)

end



