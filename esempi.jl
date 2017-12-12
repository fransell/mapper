V,CV=larCircle()()
LARVIEW.viewexploded(V,CV)

V,CV=larHelix(1,0.5,4)()
LARVIEW.viewexploded(V,CV)

V,CV=larDisk()([36,4])
LARVIEW.viewexploded(V,CV)

V,CV=larRing(1,3,2*pi)([36,1])
LARVIEW.viewexploded(V,CV)
V,CV=larRing(3,7,pi)([80,10])
LARVIEW.viewexploded(V,CV)

V,CV=larTorus(1,3,2*pi,2*pi)()
LARVIEW.viewexploded(V,CV)
