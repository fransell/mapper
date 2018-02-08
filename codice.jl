function larCircle(radius=1.,angle=2*pi)
    function larCircle0(shape=36)
        V,CV=LARLIB.larCuboids([shape])
        V=(angle/shape)*V
        W=hcat(map(u->[radius*cos(u); radius*sin(u)],V)...)
        return W,CV
    end
    return larCircle0
end

function larHelix(radius=1.,pitch=1.,nturns=2)
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

function larDisk(radius=1.,angle=2*pi)
    function larDisk0(shape=[36,1])
        V,CV=LARLIB.larCuboids(shape)
        V=[angle/shape[1] 0;0 radius/shape[2]]*V
        W=[V[:,k] for k=1:size(V,2)]
        Z=hcat(map(p->let(u,v)=p;[v*cos(u);v*sin(u)] end,W)...)
        return Z,CV
    end
    return larDisk0    
end

function larHelicoid(R=1.,r=0.5,pitch=1.,nturns=2)
    function larHelicoid0(shape=[36*nturns,2])
        angle=nturns*2*pi
        V,CV=larSimplexGrid1(shape)
        V=[angle/shape[1] 0;0 (R-r)/shape[2]]*V
        V=broadcast(+,V,[0,r])
        W=[V[:,k] for k=1:size(V,2)]
        X=hcat(map(p->let(u,v)=p;[v*cos(u);v*sin(u);(pitch/(2*pi))*u] end,W)...)
        return X,CV
    end
    return larHelicoid0    
end

function larRing(r1,r2,angle=2*pi)
	function larRing0(shape=[36,1])
		V,CV=LARLIB.larCuboids(shape)
		V=[angle/shape[1] 0;0 (r2-r1)/shape[2]]*V
		V=broadcast(+,V,[0,r1])
		W=[V[:,k] for k=1:size(V,2)]
		Z=hcat(map(p->let(u,v)=p;[v*cos(u);v*sin(u)] end,W)...)
        return Z,CV
    end
    return larRing0
end

function larSphere(radius=1,angle1=pi,angle2=2*pi)
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

function larCylinder(radius,height,angle=2*pi)
	function larCylinder0(shape=[36,1])
		V,CV=LARLIB.larCuboids(shape)
		V=[angle/shape[1] 0;0 1./shape[2]]*V
		W=[V[:,k] for k=1:size(V,2)]
		Z=hcat(map(p->let(u,v)=p;[radius*cos(u);radius*sin(u);height*v] end,W)...)
        return Z,CV
    end
    return larCylinder0
end

function larToroidal(r=1,R=2,angle1=2*pi,angle2=2*pi)
    function larToroidal0(shape=[24,36])
        V,CV=larSimplexGrid1(shape)
        V=[angle1/shape[1] 0;0 angle2/shape[2]]*V
        W=[V[:,k] for k=1:size(V,2)]
        X=hcat(map(p->let(u,v)=p;[(R+r*cos(u))*cos(v);(R+r*cos(u))*sin(v);-r*sin(u)]end,W)...) 
        return X,CV
    end
    return larToroidal0    
end

function larCrown(r=1,R=2,angle=2*pi)
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

function larBox(minVect,maxVect)
    siz=maxVect-minVect
    box=larApplyMapper(s(siz))(LARLIB.larCuboids(fill(1,length(siz))))
    return larApplyMapper(t(minVect))(box)
end 

function larBall(radius=1,angle1=pi,angle2=2*pi)
    function larBall0(shape=[18,36])
        V,CV=larSphere(radius,angle1,angle2)(shape)
        W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
        W= [map(approxVal(4),v) for v in W]
        X=hcat(collect(Set(W))...)
        return X,[collect(0:size(X,2)-1)]
    end
    return larBall0
end

function larRod(radius=1,height=3,angle=2*pi)
    function larRod0(shape=[36,1])
        V,CV=larCylinder(radius,height,angle)(shape)
        W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
        W= [map(approxVal(4),v) for v in W]
        X=hcat(collect(Set(W))...)
        return X,[collect(0:size(X,2)-1)]
    end
    return larRod0
end

function larTorus(r,R,angle1=2*pi,angle2=2*pi)
    function larTorus0(shape=[24,36,1])
        V,CV=LARLIB.larCuboids(shape)
        V=[angle1/shape[1] 0 0;0 angle2/shape[2] 0;0 0 r/shape[3]]*V
        W=[V[:,k] for k=1:size(V,2)]
        X=hcat(map(p->let(u,v,z)=p;[(R+z*cos(u))*cos(v);(R+z*cos(u))*sin(v);-z*sin(u)] end,W)...)
        return X,CV
    end
    return larTorus0
end

function larPizza(r,R,angle=pi)
    function larPizza0(shape=[24,36])
        V,CV=larCrown(r,R,angle)(shape)
        W = [Any[V[h,k] for h=1:size(V,1)] for k=1:size(V,2)]
        W= [map(approxVal(4),v) for v in W]
        X=hcat(collect(Set(W))...)
        H=hcat(X,[0 0;0 0;-r r])
        return H,[collect(0:size(H,2)-1)]
    end
    return larPizza0
end

function larHollowCyl(r,R,height,angle=2*pi)
	function larHollowCyl0(shape=[36,1,1])
		V,CV=LARLIB.larCuboids(shape)
		V=[angle/shape[1] 0 0;0 (R-r)/shape[2] 0;0 0 height/shape[3]]*V
		V=broadcast(+,V,[0,r,0])
		W=[V[:,k] for k=1:size(V,2)]
		X=hcat(map(p->let(u,v,z)=p;[v*cos(u);v*sin(u);z] end,W)...)
        return X,CV
    end
    return larHollowCyl0
end

function larHollowSphere(r,R,angle1=pi,angle2=2*pi)
	function larHollowSphere0(shape=[36,1,1])
		V,CV=LARLIB.larCuboids(shape)
		V=[angle1/shape[1] 0 0;0 angle2/shape[2] 0;0 0 (R-r)/shape[3]]*V
		V=broadcast(+,V,[-(angle1)/2,-(angle2)/2,r])
		W=[V[:,k] for k=1:size(V,2)]
		X=hcat(map(p->let(u,v,z)=p;[z*cos(u)*cos(v);z*cos(u)*sin(v);z*sin(u)] end,W)...)
        return X,CV
    end
    return larHollowSphere0
end

#funzione di un altro modulo simplexn
#=function larExtrude1(model, pattern)
    V, FV = model
    d,m=length(FV[1]), length(pattern)
    coords = cumsum(append!([0],abs.(pattern)))
    # built-in function cumsum
    offset, outcells, rangelimit = length(V), Int64[], d*m
    outcells = Array{Int64}(m,0)
    for cell in FV
        tube = [v + k*offset for k in 0:m for v in cell]
        celltube = Int64[]
        for k in 1:rangelimit
            append!(celltube,tube[k:k+d])
        end
        outcells = hcat(outcells,permutedims(reshape(celltube,d*(d+1),m),[2,1]))
    end
    cellGroups = Int64[]
    for k in 1:m
        if pattern[k]>0
            cellGroups=vcat(cellGroups,outcells[k,:])
        end
    end
    outVertices = [vcat(v,z) for z in coords for v in V]
    outCellGroups = Array{Int64,1}[]
    for k in 1:d+1:length(cellGroups)
        append!(outCellGroups,[cellGroups[k:k+d]])
    end
    return outVertices, outCellGroups
end
=#


function larSimplexGrid1(shape)
    model=[[]],[[0]]
    for item in shape
        model=larExtrude1(model,fill(1,item))
    end
    V,CV=model
    V=hcat(V...)
    return V,CV
end

#come la avevo fatta io
function larExtrude1(model,pattern)
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


function t(args)
    d=length(args)
    mat=eye(d+1,d+1)
    for k in 1:d
        mat[k,d+1]=args[k]
    end
    return mat
end

function s(args)
    d=length(args)
    mat=eye(d+1,d+1)
    for k in 1:d
        mat[k,k]=args[k]
    end
    return mat
end

function larApplyMapper(affineMatrix)
    function larApplyMapper0(model)
        if length(model)==2 
            V,CV=model
        elseif length(model)==3
            V,CV,FV=model 
        end
        V=*(affineMatrix,vcat(V,transpose(fill(1.0,size(V,2)))))
        if length(model)==2 
            return V[1:size(V,1)-1,:], CV
        elseif length(model)==3
            return V[1:size(V,1)-1,:],CV,FV 
        end
        return larApplyMapper0
    end
end


function approxVal(PRECISION)
    function approxVal0(value)
        out=round(value*(10^(PRECISION)))/10^(PRECISION)
        if out==-0.0
            out=0.0
        end
        return out 
    end
    return approxVal0
end








