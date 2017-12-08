function larCircle(radius=1,angle=2*pi)
    function larCircle0(shape=36)
        V1,EV=LARLIB.larCuboids([shape])
        V1=(angle/shape)*V1
        W=hcat(map(u->[radius*cos(u); radius*sin(u)],V1)...)
        return W,EV
        end
    return larCircle0
end

  function larHelix(radius=1,pitch=1,nturns=2)
    function larHelix0(shape=36*nturns)
        angle=nturns*2*pi
        V,CV=LARLIB.larCuboids([shape])
        V=(angle/shape)*V 
        #se lo mettevo direttamente in W cioè radius*cos(u*angle/shape);ecc il test con (1,1,3) non passava
        W=hcat(map(u->[radius*cos(u);radius*sin(u);(pitch/(2*pi))*u],V)...)
        return W,CV
        end
    return larHelix0
 end

function larDisk(radius=1,angle=2*pi)
    function larDisk0(shape=[36,1])
        V,CV=LARLIB.larCuboids(shape)
        V=[1./shape[1] 0;0 1./shape[2]]*V
        V=[angle 0;0 radius]*V
        W=[V[:,k] for k=1:size(V,2)]
        Z=hcat(map(p->let(u,v)=p;[v*cos(u);v*sin(u)] end,W)...)
        return Z,CV
        end
    return larDisk0    
end

function larRing(r1,r2,angle=2*pi)
	function larRing0(shape=[36,1])
		V,CV=LARLIB.larCuboids(shape)
		V=[1./shape[1] 0;0 1./shape[2]]*V
		V=[angle 0;0 (r2-r1)]*V
		V=broadcast(+,V,[0,r1])
		W=[V[:,k] for k=1:size(V,2)]
		Z=hcat(map(p->let(u,v)=p;[v*cos(u);v*sin(u)] end,W)...)
        return Z,CV
     end
    return larRing0
end

function larCylinder(radius,height,angle=2*pi)
	function larCylinder0(shape=[36,1])
		V,CV=LARLIB.larCuboids(shape)
		V=[1./shape[1] 0;0 1./shape[2]]*V
		V=[angle 0;0 1]*V
		W=[V[:,k] for k=1:size(V,2)]
		Z=hcat(map(p->let(u,v)=p;[radius*cos(u);radius*sin(u);height*v] end,W)...)
        return Z,CV
    end
    return larCylinder0
end

function larTorus(r,R,angle1=2*pi,angle2=2*pi)
	function larTorus0(shape=[24,36,1])
		V,CV=LARLIB.larCuboids(shape)
		V=[1./shape[1] 0 0;0 1./shape[2] 0;0 0 1./shape[3]]*V
		V=[angle1 0 0;0 angle2 0;0 0 r]*V
		W=[V[:,k] for k=1:size(V,2)]
		X=hcat(map(p->let(u,v,z)=p;[(R+z*cos(u))*cos(v);(R+z*cos(u))*sin(v);-z*sin(u)] end,W)...)
        return X,CV
    end
    return larTorus0
end

function larHollowCyl(r,R,height,angle=2*pi)
	function larHollowCyl0(shape=[36,1,1])
		V,CV=LARLIB.larCuboids(shape)
		V=[1./shape[1] 0 0;0 1./shape[2] 0;0 0 1./shape[3]]*V
		V=[angle 0 0;0 R-r 0;0 0 height]*V
		V=broadcast(+,V,[0,r,0])
		W=[V[:,k] for k=1:size(V,2)]
		X=hcat(map(p->let(u,v,z)=p;[v*cos(u);v*sin(u);z*height] end,W)...)
        return X,CV
    end
    return larHollowCyl0
end

function larHollowSphere(r,R,angle1=pi,angle2=2*pi)
	function larHollowSphere0(shape=[36,1,1])
		V,CV=LARLIB.larCuboids(shape)
		V=[1./shape[1] 0 0;0 1./shape[2] 0;0 0 1./shape[3]]*V
		V=[angle1 0 0;0 angle2 0;0 0 R-r]*V
		V=broadcast(+,V,[-(angle1)/2,-(angle2)/2,r])
		W=[V[:,k] for k=1:size(V,2)]
		X=hcat(map(p->let(u,v,z)=p;[z*cos(u)*cos(v);z*cos(u)*sin(v);z*sin(u)] end,W)...)
        return X,CV
    end
    return larHollowSphere0
end
#non si visualizza attenzione ricontrolla!!








