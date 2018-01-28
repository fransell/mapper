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
V = hcat(V[:,1],[V[:,k] for k in 1:size(V,2)]...)
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

V,CV=larTorus(1,3,pi,2*pi)()
V = hcat(V[:,1],[V[:,k] for k in 1:size(V,2)]...)
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

#esempi sfera
V,CV=larSphere(1,pi,2*pi)()
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)
#mezza sfera
V,CV=larSphere(1,pi,pi)()
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

#esempi cilindro
V,CV=larCylinder(1,3,2*pi)()
V = hcat(V[:,1],[V[:,k] for k in 1:size(V,2)]...)
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

V,CV=larCylinder(1,3,pi)()
V = hcat(V[:,1],[V[:,k] for k in 1:size(V,2)]...)
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

V,CV=larToroidal(1,2,2*pi,2*pi)()
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

V,CV=larToroidal(1,2,pi,2*pi)()
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

V,CV=larCrown(1,3,2*pi)()
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

V,CV=larCrown(1,3,pi)()
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

V,CV=larHelicoid()()
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

V,CV=larHollowSphere(1,2,pi,pi)([36,36,1])
V = hcat(V[:,1],[V[:,k] for k in 1:size(V,2)]...)
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)

V,CV=larHollowCyl(1,2,4,pi)([36,1,1])
V = hcat(V[:,1],[V[:,k] for k in 1:size(V,2)]...)
W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
hpc = p.STRUCT(p.MKPOLS(PyObject([W,CV,[]])))
p.VIEW(hpc)
