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

@testset "larCircleP" begin
    @test CalcoloBox(larCircleP()()[1])==4
    @test CalcoloBox(larCircleP(2,2*pi)()[1])==16
    @test CalcoloBox(larCircleP(3,pi)()[1])==18
    @test CalcoloBox(larCircleP(5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larCircleP(3,2*pi)(60)[1],2)==61
    @test length(larCircleP(3,2*pi)(60)[2])==60
    #da python
end

@testset "larCirclePmap" begin
    @test CalcoloBox(larCirclePmap()()[1])==4
    @test CalcoloBox(larCirclePmap(2,2*pi)()[1])==16
    @test CalcoloBox(larCirclePmap(3,pi)()[1])==18
    @test CalcoloBox(larCirclePmap(5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larCirclePmap(3,2*pi)(60)[1],2)==61
    @test length(larCirclePmap(3,2*pi)(60)[2])==60
    #da python
end

@testset "larHelixP" begin
	@test CalcoloBox(larHelixP()()[1])==8
	@test CalcoloBox(larHelixP(2,2,2)()[1])==64
	@test CalcoloBox(larHelixP(1,2,5)()[1])==40
	@test CalcoloBox(larHelixP(1,1,3)()[1])==12
    #=
    raggio=1, passo=1, numgiri=2, è contenuto
    in un parallelepipedo di volume (raggio*2)^2*passo*numgiri
    =#
    @test size(larHelixP(5,7,9)()[1],2)==325
    @test length(larHelixP(5,7,9)()[2])==324
end

@testset "larHelixPmap" begin
    @test CalcoloBox(larHelixPmap()()[1])==8
    @test CalcoloBox(larHelixPmap(2,2,2)()[1])==64
    @test CalcoloBox(larHelixPmap(1,2,5)()[1])==40
    @test CalcoloBox(larHelixPmap(1,1,3)()[1])==12
    #=
    raggio=1, passo=1, numgiri=2, è contenuto
    in un parallelepipedo di volume (raggio*2)^2*passo*numgiri
    =#
    @test size(larHelixPmap(5,7,9)()[1],2)==325
    @test length(larHelixPmap(5,7,9)()[2])==324
end

@testset "larDiskP" begin
    @test CalcoloBox(larDiskP()()[1])==4
    @test CalcoloBox(larDiskP(2,2*pi)()[1])==16
    @test CalcoloBox(larDiskP(3,pi)()[1])==18
    @test CalcoloBox(larDiskP(5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larDiskP(10,pi/7)()[1],2)==74
    @test length(larDiskP(10,pi/7)()[2])==36
end

@testset "larDiskPmap" begin
    @test CalcoloBox(larDiskPmap()()[1])==4
    @test CalcoloBox(larDiskPmap(2,2*pi)()[1])==16
    @test CalcoloBox(larDiskPmap(3,pi)()[1])==18
    @test CalcoloBox(larDiskPmap(5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larDiskPmap(10,pi/7)()[1],2)==74
    @test length(larDiskPmap(10,pi/7)()[2])==36
end

@testset "larHelicoidP" begin
    @test CalcoloBox(larHelicoidP()()[1])==8
    @test CalcoloBox(larHelicoidP(2,1,2,2)()[1])==64
    @test CalcoloBox(larHelicoidP(1,0.5,2,5)()[1])==40
    @test CalcoloBox(larHelicoidP(1,0.3,1,3)()[1])==12
     #=
    raggio=1, passo=1, numgiri=2, è contenuto in un
    parallelepipedo di volume (raggio*2)^2*passo*numgiri
    =#
    @test size(larHelicoidP(1.3,0.7,1,3)()[1],2)==327
    @test length(larHelicoidP(1.3,0.7,1,3)()[2])==432
end

@testset "larHelicoidPmap" begin
    @test CalcoloBox(larHelicoidPmap()()[1])==8
    @test CalcoloBox(larHelicoidPmap(2,1,2,2)()[1])==64
    @test CalcoloBox(larHelicoidPmap(1,0.5,2,5)()[1])==40
    @test CalcoloBox(larHelicoidPmap(1,0.3,1,3)()[1])==12
     #=
    raggio=1, passo=1, numgiri=2, è contenuto in un
    parallelepipedo di volume (raggio*2)^2*passo*numgiri
    =#
    @test size(larHelicoidPmap(1.3,0.7,1,3)()[1],2)==327
    @test length(larHelicoidPmap(1.3,0.7,1,3)()[2])==432
end

@testset "larRingP" begin
    @test CalcoloBox(larRingP(1,3,2*pi)()[1])==36
    @test CalcoloBox(larRingP(1,2,pi)()[1])==8
    @test CalcoloBox(larRingP(2,5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larRingP(5,10,pi/6)()[1],2)==74
    @test length(larRingP(5,10,pi/6)()[2])==36
end

@testset "larRingPmap" begin
    @test CalcoloBox(larRingPmap(1,3,2*pi)()[1])==36
    @test CalcoloBox(larRingPmap(1,2,pi)()[1])==8
    @test CalcoloBox(larRingPmap(2,5,pi/2)()[1])==25
    #(radius*2)^2
    @test size(larRingPmap(5,10,pi/6)()[1],2)==74
    @test length(larRingPmap(5,10,pi/6)()[2])==36
end

@testset "larSphereP" begin
    @test CalcoloBox(larSphereP(2,pi,2*pi)()[1])==64
    @test CalcoloBox(larSphereP(6,pi,pi)()[1])==864
    @test CalcoloBox(larSphereP(4,pi,2*pi)()[1])==8^3
    #(radius*2)^3
    @test size(larSphereP(2.5,pi/3,pi/5)()[1],2)==703
    @test length(larSphereP(2.5,pi/3,pi/5)()[2])==1296
end

@testset "larSpherePmap" begin
    @test CalcoloBox(larSpherePmap(2,pi,2*pi)()[1])==64
    @test CalcoloBox(larSpherePmap(6,pi,pi)()[1])==864
    @test CalcoloBox(larSpherePmap(4,pi,2*pi)()[1])==8^3
    #(radius*2)^3
    @test size(larSpherePmap(2.5,pi/3,pi/5)()[1],2)==703
    @test length(larSpherePmap(2.5,pi/3,pi/5)()[2])==1296
end

@testset "larCylinderP" begin
	@test CalcoloBox(larCylinderP(1,5,2*pi)()[1])==20
	@test CalcoloBox(larCylinderP(2,2,pi)()[1])==16
	@test CalcoloBox(larCylinderP(1,4,pi)()[1])==8
    #((radius*2)^2)*height
    @test size(larCylinderP(3.4,20,pi/7)()[1],2)==74
    @test length(larCylinderP(3.4,20,pi/7)()[2])==36
end

@testset "larCylinderPmap" begin
    @test CalcoloBox(larCylinderPmap(1,5,2*pi)()[1])==20
    @test CalcoloBox(larCylinderPmap(2,2,pi)()[1])==16
    @test CalcoloBox(larCylinderPmap(1,4,pi)()[1])==8
    #((radius*2)^2)*height
    @test size(larCylinderPmap(3.4,20,pi/7)()[1],2)==74
    @test length(larCylinderPmap(3.4,20,pi/7)()[2])==36
end

@testset "larToroidalP" begin
    @test CalcoloBox(larToroidalP(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloBox(larToroidalP(2,3,2*pi,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larToroidalP(1.3,4.6,pi/4,pi/7)()[1],2)==925
    @test length(larToroidalP(1.3,4.6,pi/4,pi/7)()[2])==1728
end

@testset "larToroidalPmap" begin
    @test CalcoloBox(larToroidalPmap(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloBox(larToroidalPmap(2,3,2*pi,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larToroidalPmap(1.3,4.6,pi/4,pi/7)()[1],2)==925
    @test length(larToroidalPmap(1.3,4.6,pi/4,pi/7)()[2])==1728
end

@testset "larCrownP" begin
    @test CalcoloBox(larCrownP(1,3,2*pi)()[1])==128
    @test CalcoloBox(larCrownP(2,3,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larCrownP(1.5,5.6,pi/8)()[1],2)==925
    @test length(larCrownP(1.5,5.6,pi/8)()[2])==1728
end

@testset "larCrownPmap" begin
    @test CalcoloBox(larCrownPmap(1,3,2*pi)()[1])==128
    @test CalcoloBox(larCrownPmap(2,3,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larCrownPmap(1.5,5.6,pi/8)()[1],2)==925
    @test length(larCrownPmap(1.5,5.6,pi/8)()[2])==1728
end

@testset "larTorusP" begin
    @test CalcoloBox(larTorusP(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloBox(larTorusP(2,3,2*pi,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larTorusP(5.2,7,pi/3,pi/4)()[1],2)==1850
    @test length(larTorusP(5.2,7,pi/3,pi/4)()[2])==864
end

@testset "larTorusPmap" begin
    @test CalcoloBox(larTorusPmap(1,3,2*pi,2*pi)()[1])==128
    @test CalcoloBox(larTorusPmap(2,3,2*pi,2*pi)()[1])==400
    #(((R+r)*2)^2)*(r*2)
    @test size(larTorusPmap(5.2,7,pi/3,pi/4)()[1],2)==1850
    @test length(larTorusPmap(5.2,7,pi/3,pi/4)()[2])==864
end

@testset "larBallP" begin
    @test CalcoloBox(larBallP(1,pi,2*pi)()[1])==8
    @test CalcoloBox(larBallP(6,pi,pi)()[1])==864
    @test CalcoloBox(larBallP(3,pi,2*pi)()[1])==6^3
    #(radius*2)^3
    @test size(larBallP(2.6,pi/5,pi/9)()[1],2)==703
    @test length(larBallP(2.6,pi/5,pi/9)()[2])==1
end

@testset "larRodP" begin
    @test CalcoloBox(larRodP(1,5,2*pi)()[1])==20
    @test CalcoloBox(larRodP(2,2,pi)()[1])==16
    @test CalcoloBox(larRodP(1,4,pi)()[1])==8
    #((radius*2)^2)*height
    @test size(larRodP(3.7,8.9,pi/9)()[1],2)==74
    @test length(larRodP(3.7,8.9,pi/9)()[2])==1
end

@testset "larPizzaP" begin
    @test CalcoloBox(larPizzaP(1,2,pi/2)()[1])==18
    @test CalcoloBox(larPizzaP(0.5,2,pi)()[1])==12.5
    #(((R+r)*2)^2)*r se angolo=pi
    @test size(larPizzaP(0.03,5.6,pi/9)()[1],2)==927
    @test length(larPizzaP(0.03,5.6,pi/9)()[2])==1
end

@testset "larHollowCylPmap" begin
	@test CalcoloBox(larHollowCylPmap(0,1,5,2*pi)()[1])==20
	@test CalcoloBox(larHollowCylPmap(1,2,4,pi)()[1])==32
	@test CalcoloBox(larHollowCylPmap(1,4,3,pi/2)()[1])==48
    #((radius*2)^2)*height
    @test size(larHollowCylPmap(3.4,7.8,pi/5)()[1],2)==148
    @test length(larHollowCylPmap(3.4,7.8,pi/5)()[2])==36
end

@testset "larHollowCylP" begin
    @test CalcoloBox(larHollowCylP(0,1,5,2*pi)()[1])==20
    @test CalcoloBox(larHollowCylP(1,2,4,pi)()[1])==32
    @test CalcoloBox(larHollowCylP(1,4,3,pi/2)()[1])==48
    #((radius*2)^2)*height
    @test size(larHollowCylP(3.4,7.8,pi/5)()[1],2)==148
    @test length(larHollowCylP(3.4,7.8,pi/5)()[2])==36
end

@testset "larHollowSphereP" begin
    @test CalcoloBox(larHollowSphereP(0,2,pi,2*pi)([36,36,1])[1])==64
    @test CalcoloBox(larHollowSphereP(1,6,pi,pi)([36,36,1])[1])==864
    @test CalcoloBox(larHollowSphereP(2,4,pi,2*pi)([36,36,1])[1])==8^3
    #(radius*2)^3
    @test size(larHollowSphereP(1.5,6.7,pi/3,2*pi/3)()[1],2)==148
    @test length(larHollowSphereP(1.5,6.7,pi/3,2*pi/3)()[2])==36
end

@testset "larHollowSpherePmap" begin
    @test CalcoloBox(larHollowSpherePmap(0,2,pi,2*pi)([36,36,1])[1])==64
    @test CalcoloBox(larHollowSpherePmap(1,6,pi,pi)([36,36,1])[1])==864
    @test CalcoloBox(larHollowSpherePmap(2,4,pi,2*pi)([36,36,1])[1])==8^3
    #(radius*2)^3
    @test size(larHollowSpherePmap(1.5,6.7,pi/3,2*pi/3)()[1],2)==148
    @test length(larHollowSpherePmap(1.5,6.7,pi/3,2*pi/3)()[2])==36
end