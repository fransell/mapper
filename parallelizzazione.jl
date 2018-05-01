function larCirclePmap(radius=1.,angle=2*pi)
    function larCircle0(shape=36)
        V,CV = LARLIB.larCuboids([shape])
        V = (angle/shape)*V
        U = hcat(pmap(u->[radius*cos(u); radius*sin(u)],V)...)
        return U,CV
    end 
    return larCircle0   
end

function larCircleP(radius=1.,angle=2*pi)
    function larCircle0(shape=36)
        V,CV = LARLIB.larCuboids([shape])
        V = (angle/shape)*V
        W = @parallel (hcat) for i = 1:size(V,2)
            [radius*cos(V[i]); radius*sin(V[i])]
        end
    return W,CV
    end
    return larCircle0
end


function larHelixPmap(radius=1.,pitch=1.,nturns=2)
    function larHelix0(shape=36*nturns)
        angle = nturns*2*pi
        V,CV = LARLIB.larCuboids([shape])
        V = (angle/shape)*V 
        W = hcat(pmap(u->[radius*cos(u);radius*sin(u);(pitch/(2*pi))*u],V)...)
        return W,CV
    end
    return larHelix0
 end 

 function larHelixP(radius=1.,pitch=1.,nturns=2)
    function larHelix0(shape=36*nturns)
        angle = nturns*2*pi
        V,CV = LARLIB.larCuboids([shape])
        V = (angle/shape)*V 
        W = @parallel (hcat) for i = 1:size(V,2)
            [radius*cos(V[i]);radius*sin(V[i]);(pitch/(2*pi))*V[i]]
        end
        return W,CV
    end
    return larHelix0
 end 

function larDiskPmap(radius=1.,angle=2*pi)
    function larDisk0(shape=[36,1])
        V,CV = LARLIB.larCuboids(shape)
        V = [angle/shape[1] 0;0 radius/shape[2]]*V
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        Z = hcat(pmap(p->let(u,v)=p;[v*cos(u);v*sin(u)] end,W)...)
        return Z,CV
    end
    return larDisk0    
end

function larDiskP(radius=1.,angle=2*pi)
    function larDisk0(shape=[36,1])
        V,CV = LARLIB.larCuboids(shape)
        V = [angle/shape[1] 0;0 radius/shape[2]]*V
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        Z = @parallel (hcat) for i=1:length(W)
            [W[i][2]*cos(W[i][1]);W[i][2]*sin(W[i][1])]
        end
        return Z,CV
    end
    return larDisk0    
end

function larHelicoidPmap(R=1.,r=0.5,pitch=1.,nturns=2)
    function larHelicoid0(shape=[36*nturns,2])
        angle = nturns*2*pi
        V,CV = larSimplexGrid1(shape)
        V = [angle/shape[1] 0;0 (R-r)/shape[2]]*V
        V = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[0,r]
        end
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        X = hcat(pmap(p->let(u,v)=p;[v*cos(u);v*sin(u);(pitch/(2*pi))*u] end,W)...)
        return X,CV
    end
    return larHelicoid0    
end

function larHelicoidP(R=1.,r=0.5,pitch=1.,nturns=2)
    function larHelicoid0(shape=[36*nturns,2])
        angle = nturns*2*pi
        V,CV = larSimplexGrid1(shape)
        V = [angle/shape[1] 0;0 (R-r)/shape[2]]*V
        V = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[0,r]
        end
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        X = @parallel (hcat) for i=1:length(W)
            [W[i][2]*cos(W[i][1]);W[i][2]*sin(W[i][1]);(pitch/(2*pi))*W[i][1]]
        end
        return X,CV
    end
    return larHelicoid0    
end

function larRingPmap(r1,r2,angle=2*pi)
	function larRing0(shape=[36,1])
		V,CV = LARLIB.larCuboids(shape)
		V = [angle/shape[1] 0;0 (r2-r1)/shape[2]]*V
        V = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[0,r1]
        end
		 W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
		Z = hcat(pmap(p->let(u,v)=p;[v*cos(u);v*sin(u)] end,W)...)
        return Z,CV
    end
    return larRing0
end 

function larRingP(r1,r2,angle=2*pi)
    function larRing0(shape=[36,1])
        V,CV = LARLIB.larCuboids(shape)
        V = [angle/shape[1] 0;0 (r2-r1)/shape[2]]*V
        V = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[0,r1]
        end
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        Z = @parallel (hcat) for i=1:length(W)
            [W[i][2]*cos(W[i][1]);W[i][2]*sin(W[i][1])]
        end
        return Z,CV
    end
    return larRing0
end 

function larSpherePmap(radius=1,angle1=pi,angle2=2*pi)
    function larSphere0(shape=[18,36])
        V,CV = larSimplexGrid1(shape)
        V = [angle1/shape[1] 0;0 angle2/shape[2]]*V
        V = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[-angle1/2,-angle2/2]
        end
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        X = hcat(pmap(p->let(u,v)=p;[radius*cos(u)*cos(v);radius*cos(u)*sin(v);radius*sin(u)]end,W)...) 
        return X,CV
        end
    return larSphere0    
end 

function larSphereP(radius=1,angle1=pi,angle2=2*pi)
    function larSphere0(shape=[18,36])
        V,CV = larSimplexGrid1(shape)
        V = [angle1/shape[1] 0;0 angle2/shape[2]]*V
        V = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[-angle1/2,-angle2/2]
        end
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        X = @parallel (hcat) for i=1:length(W)
            [radius*cos(W[i][1])*cos(W[i][2]);radius*cos(W[i][1])*sin(W[i][2]);radius*sin(W[i][1])]
        end
        return X,CV
        end
    return larSphere0    
end 

function larCylinderPmap(radius,height,angle=2*pi)
    function larCylinder0(shape=[36,1])
        V,CV = LARLIB.larCuboids(shape)
        V = [angle/shape[1] 0;0 1./shape[2]]*V
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        Z = hcat(pmap(p->let(u,v)=p;[radius*cos(u);radius*sin(u);height*v] end,W)...)
        return Z,CV
    end
    return larCylinder0
end 


function larCylinderP(radius,height,angle=2*pi)
	function larCylinder0(shape=[36,1])
		V,CV = LARLIB.larCuboids(shape)
		V = [angle/shape[1] 0;0 1./shape[2]]*V
		W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        Z = @parallel (hcat) for i=1:length(W)
            [radius*cos(W[i][1]);radius*sin(W[i][1]);height*W[i][2]]
        end
        return Z,CV
    end
    return larCylinder0
end 

function larToroidalPmap(r=1,R=2,angle1=2*pi,angle2=2*pi)
    function larToroidal0(shape=[24,36])
        V,CV = larSimplexGrid1(shape)
        V = [angle1/shape[1] 0;0 angle2/shape[2]]*V
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        X = hcat(pmap(p->let(u,v)=p;[(R+r*cos(u))*cos(v);(R+r*cos(u))*sin(v);-r*sin(u)]end,W)...) 
        return X,CV
    end
    return larToroidal0    
end 

function larToroidalP(r=1,R=2,angle1=2*pi,angle2=2*pi)
    function larToroidal0(shape=[24,36])
        V,CV = larSimplexGrid1(shape)
        V = [angle1/shape[1] 0;0 angle2/shape[2]]*V
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        X = @parallel (hcat) for i=1:length(W)
            [(R+r*cos(W[i][1]))*cos(W[i][2]);(R+r*cos(W[i][1]))*sin(W[i][2]);-r*sin(W[i][1])]
        end
        return X,CV
    end
    return larToroidal0    
end 

function larCrownPmap(r=1,R=2,angle=2*pi)
    function larCrown0(shape=[24,36])
        V,CV = larSimplexGrid1(shape)
        V = [pi/shape[1] 0;0 angle/shape[2]]*V
        W = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[-pi/2,0]
        end
        W = @parallel (append!) for k=1:size(V,2) 
            [W[:,k]] 
        end
        X = hcat(pmap(p->let(u,v)=p;[(R+r*cos(u))*cos(v);(R+r*cos(u))*sin(v);-r*sin(u)]end,W)...)
        return X,CV
    end
    return larCrown0    
end  

function larCrownP(r=1,R=2,angle=2*pi)
    function larCrown0(shape=[24,36])
        V,CV = larSimplexGrid1(shape)
        V = [pi/shape[1] 0;0 angle/shape[2]]*V
        W = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[-pi/2,0]
        end
        W = @parallel (append!) for k=1:size(V,2) 
            [W[:,k]] 
        end
        X = @parallel (hcat) for i=1:length(W)
            [(R+r*cos(W[i][1]))*cos(W[i][2]);(R+r*cos(W[i][1]))*sin(W[i][2]);-r*sin(W[i][1])]
        end
        return X,CV
    end
    return larCrown0    
end

function larBallP(radius=1,angle1=pi,angle2=2*pi)
    function larBall0(shape=[18,36])
        V,CV = larSphere(radius,angle1,angle2)(shape)
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        W = @parallel (append!) for v in W
            [map(approxVal(4),v)] 
        end
        X = hcat(collect(Set(W))...)
        return X,[collect(0:size(X,2)-1)]
    end
    return larBall0
end

function larRodP(radius=1,height=3,angle=2*pi)
    function larRod0(shape=[36,1])
        V,CV = larCylinder(radius,height,angle)(shape)
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        W = @parallel (append!) for v in W
            [map(approxVal(4),v)] 
        end
        X = hcat(collect(Set(W))...)
        return X,[collect(0:size(X,2)-1)]
    end
    return larRod0
end

function larTorusPmap(r,R,angle1=2*pi,angle2=2*pi)
    function larTorus0(shape=[24,36,1])
        V,CV = LARLIB.larCuboids(shape)
        V = [angle1/shape[1] 0 0;0 angle2/shape[2] 0;0 0 r/shape[3]]*V
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        X = hcat(pmap(p->let(u,v,z)=p;[(R+z*cos(u))*cos(v);(R+z*cos(u))*sin(v);-z*sin(u)] end,W)...)
        return X,CV
    end
    return larTorus0
end 

function larTorusP(r,R,angle1=2*pi,angle2=2*pi)
    function larTorus0(shape=[24,36,1])
        V,CV = LARLIB.larCuboids(shape)
        V = [angle1/shape[1] 0 0;0 angle2/shape[2] 0;0 0 r/shape[3]]*V
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        X = @parallel (hcat) for i=1:length(W)
            [(R+W[i][3]*cos(W[i][1]))*cos(W[i][2]);(R+W[i][3]*cos(W[i][1]))*sin(W[i][2]);-W[i][3]*sin(W[i][1])]
        end
        return X,CV
    end
    return larTorus0
end 


function larPizzaP(r,R,angle=pi)
    function larPizza0(shape=[24,36])
        V,CV = larCrown(r,R,angle)(shape)
        W = @parallel (append!) for k=1:size(V,2) 
            [V[:,k]] 
        end
        W = @parallel (append!) for v in W
            [map(approxVal(4),v)]  
        end 
        X = hcat(collect(Set(W))...)
        H = hcat(X,[0 0;0 0;-r r])
        return H,[collect(0:size(H,2)-1)]
    end
    return larPizza0
end

 
function larHollowCylPmap(r,R,height,angle=2*pi)
	function larHollowCyl0(shape=[36,1,1])
		V,CV = LARLIB.larCuboids(shape)
		V = [angle/shape[1] 0 0;0 (R-r)/shape[2] 0;0 0 height/shape[3]]*V
		W = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[0,r,0]
        end
		W = @parallel (append!) for k=1:size(V,2) 
            [W[:,k]] 
        end
		X = hcat(pmap(p->let(u,v,z)=p;[v*cos(u);v*sin(u);z] end,W)...)
        return X,CV
    end
    return larHollowCyl0
end 

function larHollowCylP(r,R,height,angle=2*pi)
    function larHollowCyl0(shape=[36,1,1])
        V,CV = LARLIB.larCuboids(shape)
        V = [angle/shape[1] 0 0;0 (R-r)/shape[2] 0;0 0 height/shape[3]]*V
        W = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[0,r,0]
        end
        W = @parallel (append!) for k=1:size(V,2) 
            [W[:,k]] 
        end
        X = @parallel (hcat) for i=1:length(W)
            [W[i][2]*cos(W[i][1]);W[i][2]*sin(W[i][1]);W[i][3]]
        end
        return X,CV
    end
    return larHollowCyl0
end

function larHollowSpherePmap(r,R,angle1=pi,angle2=2*pi)
	function larHollowSphere0(shape=[36,1,1])
		V,CV = LARLIB.larCuboids(shape)
		V = [angle1/shape[1] 0 0;0 angle2/shape[2] 0;0 0 (R-r)/shape[3]]*V
        W = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[-(angle1)/2,-(angle2)/2,r]
        end
		W = @parallel (append!) for k=1:size(V,2) 
            [W[:,k]] 
        end
		X = hcat(pmap(p->let(u,v,z)=p;[z*cos(u)*cos(v);z*cos(u)*sin(v);z*sin(u)] end,W)...)
        return X,CV
    end
    return larHollowSphere0
end 

function larHollowSpherePmap(r,R,angle1=pi,angle2=2*pi)
    function larHollowSphere0(shape=[36,1,1])
        V,CV = LARLIB.larCuboids(shape)
        V = [angle1/shape[1] 0 0;0 angle2/shape[2] 0;0 0 (R-r)/shape[3]]*V
        W = @parallel (hcat) for i=1:size(V,2)
            V[:,i]+[-(angle1)/2,-(angle2)/2,r]
        end
        W = @parallel (append!) for k=1:size(V,2) 
            [W[:,k]] 
        end
        X = @parallel (hcat) for i=1:length(W)
            [W[i][3]*cos(W[i][1])*cos(W[i][2]);W[i][3]*cos(W[i][1])*sin(W[i][2]);W[i][3]*sin(W[i][1])]
        end
        return X,CV
    end
    return larHollowSphere0
end

@everywhere function larSphere(radius=1,angle1=pi,angle2=2*pi)
    function larSphere0(shape=[18,36])
        V,CV=larSimplexGrid1(shape)
        V=[angle1/shape[1] 0;0 angle2/shape[2]]*V
        V=broadcast(+,V,[-angle1/2,-angle2/2])
        W=[V[:,k] for k=1:size(V,2)]
        X=hcat(map(p->let(u,v)=p;[radius*cos(u)*cos(v);radius*cos(u)*sin(v);radius*sin(u)]end,W)...) 
        return X,CV
        end
    return larSphere0    
end

@everywhere function larCrown(r=1,R=2,angle=2*pi)
    function larCrown0(shape=[24,36])
        V,CV=larSimplexGrid1(shape)
        V=[pi/shape[1] 0;0 angle/shape[2]]*V
        V=broadcast(+,V,[-pi/2,0])
        W=[V[:,k] for k=1:size(V,2)]
        X=hcat(map(p->let(u,v)=p;[(R+r*cos(u))*cos(v);(R+r*cos(u))*sin(v);-r*sin(u)]end,W)...)
        return X,CV
    end
    return larCrown0    
end

@everywhere function larSimplexGrid1(shape)
    model=[[]],[[0]]
    for item in shape
        model=larExtrude1(model,fill(1,item))
    end
    V,CV=model
    V=hcat(V...)
    return V,CV
end


@everywhere function larExtrude1(model,pattern)
    V,FV=model
    d,m=length(FV[1]), length(pattern)
    coords=collect(cumsum(append!([0],map(abs,pattern))))
    offset,outcells,rangelimit=length(V),[],d*m
    for cell in FV  
        tube=[v+k*offset for k in range(0,m+1) for v in cell]
        cellTube=[tube[k:k+d] for k in range(1,rangelimit)]
        outcells=vcat(outcells,reshape(cellTube,d,m))
    end
    cellGroups=[]
    for i in 1:size(outcells,2)
        if pattern[i]>0
            cellGroups=vcat(cellGroups,outcells[:,i])
        end
    end
    outVertices=[vcat(v,[z]) for z in coords for v in V]
    outModel=outVertices,cellGroups
end

@everywhere function approxVal(PRECISION)
    function approxVal0(value)
        out=round(value*(10^(PRECISION)))/10^(PRECISION)
        if out==-0.0
            out=0.0
        end
        return out 
    end
    return approxVal0
end