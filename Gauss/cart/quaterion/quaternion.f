	subroutine conjugate(p,q)
	real p(4),q(4)
	q(1)=p(1)
	q(2)=-p(1)
	q(3)=-p(3)
	q(4)=-p(4)
	end

	subroutine multi(p,q,pq)
	real p(4),q(4),pq(4)
	pq(1)=p(1)*q(1)-p(2)*q(2)-p(3)*q(3)-p(4)*q(4)
	pq(2)=p(1)*q(2)+p(2)*q(1)+p(3)*q(4)-p(4)*q(3)
	pq(3)=p(1)*q(3)-p(2)*q(4)+p(3)*q(1)+p(4)*q(2)
	pq(4)=p(1)*q(4)+p(2)*q(3)-p(3)*q(2)+p(4)*q(1)
	end
	
	subroutine inverse(p,pinv)
	real p(4),pinv(4),pnorm2
	pnorm2=p(1)*p(1)+p(2)*p(2)+p(3)*p(3)+p(4)*p(4)
	pinv(1)=p(1)/pnorm2
	pinv(2)=-p(2)/pnorm2
	pinv(3)=-p(3)/pnorm2
	pinv(4)=-p(4)/pnorm2
	end
